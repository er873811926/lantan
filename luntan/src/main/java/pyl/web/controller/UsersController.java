package pyl.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pyl.dto.ReplyNumEmailMax;
import pyl.pojo.Likes;
import pyl.pojo.Posts;
import pyl.pojo.PostsContent;
import pyl.pojo.Reply;
import pyl.pojo.RoleRelation;
import pyl.pojo.Smodule;
import pyl.pojo.UserCollect;
import pyl.pojo.UserMessage;
import pyl.pojo.Users;
import pyl.service.UsersService;
import pyl.service.LikesService;
import pyl.service.PostsContentService;
import pyl.service.PostsService;
import pyl.service.ReplyService;
import pyl.service.RoleRelationService;
import pyl.service.SmoduleService;
import pyl.service.UserCollectService;
import pyl.service.UserMessageService;
import pyl.util.GetHttpIP;
import pyl.util.ImageUtil;
import pyl.util.MyMD5;
import pyl.util.MyUUID;
import pyl.util.Myutil;

@Controller
@RequestMapping("/pyl")
public class UsersController {
	
	@Autowired
	private UsersService userservice=null;
	@Autowired
	private SmoduleService SmoduleService=null;
	@Autowired
	private PostsService postsService=null;
	@Autowired
	private PostsContentService pcService=null;
	@Autowired
	private ReplyService replyService=null;
	@Autowired
	private LikesService likesService=null;
	@Autowired
	private UserCollectService ucService=null;
	@Autowired
	private UserMessageService messageService=null;
	@Autowired
	private RoleRelationService roleRService=null;
	
	
	//验证码生成
	@RequestMapping("/yanZhengMa.do")
	public @ResponseBody Map<String,Object> yanzhengma(){
		Map<String,Object> map=new HashMap<String, Object>();
		Random r=new Random();
		int a=r.nextInt(20);
		int b=r.nextInt(20);
		int values=a+b;
		String msg=""+a+"+"+b+"=?";
		map.put("msg", msg);
		map.put("values", values);
		return map;
	}
	
	//帐号验证
	@RequestMapping("/regYanZheng.do")
	public  @ResponseBody Map<String,Object> regYanZheng(HttpServletRequest request,HttpServletResponse response){
		String uemail=request.getParameter("uemail");
		Map<String,Object> map=new HashMap<String, Object>();
		if(uemail==null || uemail.equals(""))return null;
		
		//先用map去查数据库
		map.put("uemail", uemail);
		List<Users> list=userservice.findUsersByCondition(map);
		
		
		//用map去传递值
		map.clear();
		if(!list.isEmpty()){
			map.put("state", "0");
			map.put("msg", "该邮箱已注册");
		}
		
		return map;
	}

	//注册
	@RequestMapping("/reg.do")
	public  @ResponseBody Map<String,Object> reg(HttpServletRequest request,HttpServletResponse response){
		String uEmail=request.getParameter("uemail");
		String uPassword=request.getParameter("upassword");
		String uNickname=request.getParameter("unickname");
		Map<String,Object> map=new HashMap<String, Object>();
		if("".equals(uEmail) || uEmail==null)return null;
		Users user=new Users();
		user.setUemail(uEmail);
		//使用shiro提供的加密方式
		Object bs=ByteSource.Util.bytes(uEmail);
		SimpleHash sh=new SimpleHash("MD5", uPassword,bs, 5);
		//=====
		uPassword=sh.toString();
		user.setUpassword(uPassword);
		user.setUnickname(uNickname);
		user.setUregistertime(Myutil.playTime(new Date()));
		user.setUsex("男");
		user.setUaddress("");
		user.setUmaxim("");
		Subject subject=SecurityUtils.getSubject();
		String path=request.getServletContext().getRealPath("/");
		path+="static/res/images/userPhoto.png";
		System.out.println(path);
		String uphoto=ImageUtil.convertImageToByte(path, "png");
		user.setUphoto(uphoto);
		
		
		try{
			userservice.addUsers(user);
		}catch(Exception e){
			System.out.println(e.getMessage());
			map.put("msg", "注册失败");
			map.put("state", 0);
			return map;
		}
		
		map.put("msg", "注册成功");
		map.put("state", 1);
		map.put("url", "/luntan/static/html/user/login.jsp");
		
		
		return map;
	}
	
	
	//登录
	@RequestMapping("/login.do")
	public  @ResponseBody Map<String,Object> login(HttpServletRequest request,HttpServletResponse response){
		String uEmail=request.getParameter("uemail");
		String uPassword=request.getParameter("upassword");
		Map<String,Object> map=new HashMap<String, Object>();
		if("".equals(uEmail) || uEmail==null)return null;
		String[] arr=null;
		//拿到主体
		Subject subject=SecurityUtils.getSubject(); 
		//是否认证
		if(!subject.isAuthenticated()){
			UsernamePasswordToken token=new UsernamePasswordToken(uEmail,uPassword);
			token.setRememberMe(true);
			try {			
				subject.login(token);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
				 arr=e.getMessage().split(",");				
			}
		}
		
		if(arr!=null){
			if("0".equals(arr[1].substring(7))){
				map.put("msg",arr[0].substring(4));
				map.put("state",0);
			}else{
				map.put("msg", "帐号或者密码错误");
				map.put("state", 0);
			}
		}else{
			map.put("uemail", uEmail);
			List<Users> lists=userservice.findUsersByCondition(map);
			map.put("logintime", Myutil.playTime(new Date()));
			userservice.updateUsers(map);
			subject.getSession().setAttribute("currentNickName", lists.get(0).getUnickname());
			subject.getSession().setAttribute("uphoto", lists.get(0).getUphoto());
			map.put("msg", "登录成功正在跳转...");
			map.put("state", 1);
			map.put("url", "pyl/lookIndex.do");
		}
		
		return map;
	}
	
	
	
	
	//发表帖子
	@RequestMapping("/addPosts.do")
	public String addPosts(Model model){
		Subject subject=SecurityUtils.getSubject(); 
		if(!subject.isAuthenticated()){
			
			return "redirect:/static/html/user/login.jsp";
		}
		List<Smodule> lists=SmoduleService.findSmoduleAll();
		if(lists.isEmpty()){
			return "redirect:/static/html/user/login.jsp";
		}
		
		Object uname=subject.getPrincipal();
		
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("uemail", uname);
		List<Users> listu=userservice.findUsersByCondition(map);
		
		
		model.addAttribute("uScore", listu.get(0).getUscore());
		model.addAttribute("smodule", lists);
		
		return "forward:/static/html/jie/add.jsp";
	}
	
	
	//保存帖子
	@RequestMapping("/savePosts.do")
	@Transactional
	public @ResponseBody Map<String,Object> savePosts(HttpServletRequest request,HttpServletResponse response){
		Subject subject=SecurityUtils.getSubject(); 
		Map<String,Object> map=new HashMap<String, Object>();
		if(!subject.isAuthenticated()){
			return map;
		}
		
		String uEmail=subject.getPrincipal().toString();//获取用户名
		String content=request.getParameter("content");
		String smoduleId=request.getParameter("type");
		String smoduleName=request.getParameter("typename");
		String reward=request.getParameter("feiwen");
		String postsTitle=request.getParameter("title");
		String score=request.getParameter("score");
		int y=Integer.parseInt(score)-Integer.parseInt(reward);//飞吻余额
		
		//posts类创建
		Posts posts=new Posts();
		posts.setIp(GetHttpIP.getIpAddress(request));
		String uuid=MyUUID.getUuid();
		posts.setPostsNo(uuid);
		posts.setPostsTitle(postsTitle);
		posts.setReward(Integer.parseInt(reward));
		posts.setSmoduleId(Integer.parseInt(smoduleId));
		posts.setSmoduleName(smoduleName);
		posts.setUemail(uEmail);
		posts.setUnickname((String)subject.getSession().getAttribute("currentNickName"));
		posts.setUptime(Myutil.playTime(new Date()));
		
		
		//postsContent类创建
		PostsContent postsC=new PostsContent();
		postsC.setPostsNo(uuid);
		postsC.setContent(content);
		
		//修改飞吻余额的
		map.put("uemail", uEmail);
		map.put("uscore", y);
		
		
		postsService.addPosts(posts);
		pcService.addPostsContent(postsC);
		userservice.updateUsers(map);
		map.put("state", "1");
		map.put("msg", "发表成功");
		map.put("url", "pyl/lookIndex.do");
		return map;
	}
	
	
	
	//浏览主页
	@RequestMapping("/lookIndex.do")
	public String lookIndex(Model model){
		Subject subject=SecurityUtils.getSubject(); 
		Map<String,Object> map=new HashMap<String, Object>();
		//需要全部的帖子和置顶的帖子，回复最多的人
		map.put("top", "0");
		map.put("desc", "");//倒叙
		map=Myutil.fenPage(map, 12,1);
		List<Posts> listpa=postsService.findPostsByCondition(map);//全部的
		
		map.put("top", "1");
		map.put("desc", "");//倒叙
		map=Myutil.fenPage(map, 4,1);
		List<Posts> listpt=postsService.findPostsByCondition(map);//置顶的
		
		map.clear();//清空map
		map.put("hot", "1");
		map.put("desc", "");//倒叙
		map=Myutil.fenPage(map, 10,1);
		List<Posts> listph=postsService.findPostsByCondition(map);//精华贴
		
		
		map.clear();//清空map
		List<Smodule> lists=SmoduleService.findSmoduleAll();//所有模块
		
		
		map.put("desc", "");//倒叙
		map.put("pageSize", 12);
		List<ReplyNumEmailMax> listMax=replyService.findReplyNumEmailMax(map);//回复数多的
		
		model.addAttribute("listpt", listpt);
		model.addAttribute("listph", listph);
		model.addAttribute("listpa", listpa);
		model.addAttribute("listMax", listMax);
		model.addAttribute("smodule", lists);
		
		
		
		return "forward:/static/html/index.jsp";
	}
	
	//自动更新签到数据
	@RequestMapping("/signInday.do")
	public  @ResponseBody Map<String,Object> signInday(HttpServletRequest request,HttpServletResponse response){
		Subject subject=SecurityUtils.getSubject(); 
		Map<String,Object> map=new HashMap<String, Object>();
		if(!subject.isAuthenticated()){
			return map;
		}
		String uemail=subject.getPrincipal().toString();
		//先用map去查数据库
		map.put("uemail", uemail);
		List<Users> list=userservice.findUsersByCondition(map);
		Users user=list.get(0);
		String signintime=user.getUsignintime();
		if(signintime==null){
			map.put("signintime", 0);
			map.put("uscore", user.getUscore());
			map.put("msg", "今日签到");
		}else{
			signintime=signintime.substring(0,10).replace("-", "");
			long time=Integer.parseInt(signintime);
			long nowtime=Integer.parseInt(Myutil.playDate(new Date()).replace("-", ""));
			//签到过的时间等于今天，就显示签到过
			if(nowtime==time){
				map.put("state", 0);
				map.put("msg", "今日已签到");
				map.put("signintime", user.getUsigninday());
				map.put("uscore", user.getUscore());
			}else{
				map.put("state", 1);
				map.put("msg", "今日签到");
				map.put("signintime", user.getUsigninday());
				map.put("uscore", user.getUscore());
			}
			return map;
		}
		return map;
	}
	
	
	
	//点击签到数据
	@RequestMapping("/signIn.do")
	public  @ResponseBody Map<String,Object> signIn(HttpServletRequest request,HttpServletResponse response){
		Subject subject=SecurityUtils.getSubject(); 
		Map<String,Object> map=new HashMap<String, Object>();
		if(!subject.isAuthenticated()){
			map.put("state", 0);
			map.put("msg", "请先登录");
			return map;
		}
		String uemail=subject.getPrincipal().toString();
		int signinday= Integer.parseInt(request.getParameter("signdays"));
		//先用map去查数据库
		map.put("uemail", uemail);
		List<Users> list=userservice.findUsersByCondition(map);
		Users user=list.get(0);
		int score=0;//总积分计数
		int signindayscore=0;//额外积分计数
		//修改数据积分
		if(signinday>15){
			score=user.getUscore()+15+5;
			signindayscore=15;
		}else{
			score=user.getUscore()+signinday+5;
			signindayscore=signinday;
		}
		map.put("uscore", score);
		map.put("usignintime", Myutil.playTime(new Date()));
		map.put("usigninday", (signinday+1));
		
		userservice.updateUsers(map);
		map.clear();
		map.put("usigninday", (signinday+1));
		map.put("static", "1");
		map.put("score", (5+signindayscore));
		map.put("msg", "今日已签到");
		
		return map;
	}
	
	
	//回复的所有操作
	@RequestMapping("/replyCaoZuo")
	public @ResponseBody Map<String,Object> replyCaoZuo(HttpServletRequest request,HttpServletResponse response){
		String type=request.getParameter("type");
		Subject subject=SecurityUtils.getSubject();
		Map<String, Object> map= new HashMap<String, Object>();
		if(subject.getPrincipal()==null){
			map.put("state", 1);
			map.put("msg", "请先登录");
			return map;
		}
		
		if("submitReply".equals(type)){
			Reply r=new Reply();
			String uemail=subject.getPrincipal().toString();
			String replyTime=Myutil.playTime(new Date());
			String content =request.getParameter("content");
			String postsNo=request.getParameter("postsNo");
			content=Myutil.replacFace(content);
			r.setPostsNo(postsNo);
			r.setReplyContent(content);
			r.setPostsTitle(request.getParameter("postsTitle"));
			r.setUemail(uemail);
			r.setUnickname(request.getParameter("unickname"));
			r.setIp(GetHttpIP.getIpAddress(request));
			r.setReplyTime(replyTime);
			replyService.addReply(r);
			
			//修改帖子的回复数
			map.put("postsNo", postsNo);
			List<Posts> listpo=postsService.findPostsByCondition(map);
			map.put("replyNum", listpo.get(0).getReplyNum()+1);
			postsService.updatePosts(map);
			
			map.clear();
//			map.put("uemail", uemail);
//			map.put("content", content);
//			map.put("replyTime", replyTime);
			map.put("state", 1);
		}
		
		if("deleteReply".equals(type)){
			String postsNo =request.getParameter("postsNo");
			String uemail =request.getParameter("uemail");
			String replyTime =request.getParameter("replyTime");
			map.clear();
			map.put("postsNo", postsNo);
			map.put("replyTime", replyTime);
			map.put("uemail", uemail);
			replyService.removeReplyByMap(map);
			map.clear();
			map.put("state",2);
		}
		
		if("caina".equals(type)){
			
			String postsNo =request.getParameter("postsNo");
			String uemail =request.getParameter("uemail");
			String replyTime =request.getParameter("replyTime");
			String reward =request.getParameter("reward");
			map.put("postsNo", postsNo);
			map.put("top", "1");
			List<Reply> listy=replyService.findReplyByCondition(map);
			map.clear();
			if(listy.isEmpty()){
				map.put("uemail", uemail);
				List<Users> listu=userservice.findUsersByCondition(map);
				Users u=listu.get(0);
				int score=u.getUscore();
				score+=Integer.parseInt(reward);
				map.put("uscore", score);
				userservice.updateUsers(map);
				map.clear();
			}
			
			map.put("postsNo", postsNo);
			map.put("replyTime", replyTime);
			map.put("uemail", uemail);
			replyService.findReplyByCondition(map);
			
			map.put("top", "1");
			replyService.updateReply(map);
			//对次帐号积分添加
			map.clear();
			map.put("state",3);
		}
		
		//点赞
		if("likes".equals(type)){
			String postsNo =request.getParameter("postsNo");
			String uemail =request.getParameter("uemail");
//			String replyTime =request.getParameter("replyTime");
			String replyId =request.getParameter("replyId");
			String uemail1=subject.getPrincipal().toString();

			map.put("replyId", replyId);
			map.put("uemail", uemail1);
			List<Likes> listlike=likesService.findLikesByCondition(map);
			if(!listlike.isEmpty()){
				map.clear();
				map.put("state", "4");
				map.put("msg", "你点过赞了");
				return map;
			}
			Likes l= new Likes();
			l.setReplyId(Integer.parseInt(replyId));
			l.setUemail(uemail1);
			likesService.addLikes(l);
			
			map.clear();
			map.put("postsNo", postsNo);
//			map.put("replyTime", replyTime);
			map.put("uemail", uemail);
			map.put("replyId", replyId);System.out.println(replyId);
			
			List<Reply> listr =replyService.findReplyByCondition(map);
			
			Reply r=listr.get(0);
			map.put("likes", r.getLikes()+1);
			replyService.updateReply(map);
			
			map.put("state", 5);
			
		}
		
		
		//置顶帖子
		if("top".equals(type)){
			String postsNo =request.getParameter("postsNo");
			String uemail =request.getParameter("uemail");
//			String replyTime =request.getParameter("replyTime");
			String replyId =request.getParameter("replyId");
			String uemail1=subject.getPrincipal().toString();
			
			map.put("replyId", replyId);
			map.put("uemail", uemail1);
			List<Likes> listlike=likesService.findLikesByCondition(map);
			if(!listlike.isEmpty()){
				map.clear();
				map.put("state", "4");
				map.put("msg", "你点过赞了");
				return map;
			}
			Likes l= new Likes();
			l.setReplyId(Integer.parseInt(replyId));
			l.setUemail(uemail1);
			likesService.addLikes(l);
			
			map.clear();
			map.put("postsNo", postsNo);
//			map.put("replyTime", replyTime);
			map.put("uemail", uemail);
			map.put("replyId", replyId);System.out.println(replyId);
			
			List<Reply> listr =replyService.findReplyByCondition(map);
			
			Reply r=listr.get(0);
			map.put("likes", r.getLikes()+1);
			replyService.updateReply(map);
			
			map.put("state", 5);
			
		}
		
		
		return map;
	}
	
	//帖子的的所有操作
	@RequestMapping("/postsCaoZuo")
	public @ResponseBody Map<String,Object> postsCaoZuo(HttpServletRequest request,HttpServletResponse response){
		String type=request.getParameter("type");
		Subject subject=SecurityUtils.getSubject();
		Map<String, Object> map= new HashMap<String, Object>();
		if("deletePosts".equals(type)){
			String postsId =request.getParameter("postsId");
			postsService.removePostsById(Integer.parseInt(postsId));
			map.put("state", 6);
			map.put("url", "pyl/lookIndex.do");
		}
		
		//置顶帖子
		if("topPosts".equals(type)){
			String postsId =request.getParameter("postsId");
			String top =request.getParameter("top");
			map.put("postsId", postsId);
			map.put("top", Integer.parseInt(top));
			postsService.updatePosts(map);
			map.put("state", 7);
		}
		
		//加精帖子
		if("hotPosts".equals(type)){
			String postsId =request.getParameter("postsId");
			String hot =request.getParameter("hot");
			map.put("postsId", postsId);
			map.put("hot", Integer.parseInt(hot));
			postsService.updatePosts(map);
			map.put("state", 8);
		}
		
		//收藏帖子
		if("soucang".equals(type)){
			String postsNo =request.getParameter("postsNo");
			String postsTitle =request.getParameter("postsTitle");
			String vangvalue =request.getParameter("vangvalue");
			String uemail=subject.getPrincipal().toString();
			if("1".equals(vangvalue)){
				UserCollect uc=new UserCollect();
				uc.setPostsNo(postsNo);
				uc.setPostsTitle(postsTitle);
				uc.setUemail(uemail);
				ucService.addUserCollect(uc);
				
			}else{
				map.put("postsNo", postsNo);
				map.put("uemail", uemail);
				List<UserCollect> uc=ucService.findUserCollectByCondition(map);
				if(!uc.isEmpty()){
					ucService.removeUserCollectById(uc.get(0).getCollectId());
				}
			}
//			postsService.updatePosts(map);
			map.put("state", 9);
		}
				
		return map;
	}
	
	
	//搜索帖子
	@RequestMapping("/souPosts.do")
	public String souPosts(HttpServletRequest request,HttpServletResponse response,Model model){
		String souword=request.getParameter("souword");
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("postsTitle", souword);
		List<Smodule> smodule=SmoduleService.findSmoduleAll();//所有模块
		
		int pageNo=1;
		int pageSize=10;
		int numMax=postsService.findPostsMaxNum(map);
		int pageMax=numMax;
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
		try {
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
			if(pageNo>pageMax)pageNo=pageMax;
		} catch (Exception e) {
			// TODO: handle exception
			pageNo=1;
		}
		List<Posts> listsou= postsService.findPostsByCondition(map);
		
		model.addAttribute("numMax",numMax);
		model.addAttribute("pageNo",pageNo);
		model.addAttribute("pageMax",pageMax);
		model.addAttribute("smodule",smodule);
		model.addAttribute("listsou",listsou);
		model.addAttribute("souword",souword);
		return "forward:/static/html/user/sou.jsp";
	}
	
	@RequestMapping("/findMyPosts.do")
	public String findMyPosts(HttpServletRequest request,HttpServletResponse response,Model model){
		Subject subject =SecurityUtils.getSubject();
		if(subject.getPrincipal()==null){
			return "redirect:pyl/lookIndex.do";
		}
		String state=request.getParameter("state");
		String uemail=subject.getPrincipal().toString();
		Map<String,Object> map=new HashMap<String, Object>();
		//查询所有的帖子
		map.put("uemail", uemail);
		List<Posts> listp=postsService.findPostsByCondition(map);
		model.addAttribute("listp", listp);
		
		//查询所有的帖子
		model.addAttribute("postsstate", state);
		List<UserCollect> listuc=ucService.findUserCollectByCondition(map);
		model.addAttribute("listuc", listuc);
		return "forward:/static/html/user/index.jsp";
	}
	
	
	@RequestMapping("/playSet.do")
	public String findMyCollect(HttpServletRequest request,HttpServletResponse response,Model model){
		Subject subject =SecurityUtils.getSubject();
		if(subject.getPrincipal()==null){
			return "redirect:pyl/lookIndex.do";
		}
		
		String uemail=subject.getPrincipal().toString();
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("uemail", uemail);
		List<Users> listu=userservice.findUsersByCondition(map);
		model.addAttribute("oneu", listu.get(0));
		
		return "forward:/static/html/user/set.jsp";
	}
	
	
	@RequestMapping("/setUser.do")
	public @ResponseBody Map<String,Object> setUser(HttpServletRequest request,HttpServletResponse response,Model model){
		Subject subject =SecurityUtils.getSubject();
		Map<String,Object> map=new HashMap<String, Object>();
		if(subject.getPrincipal()==null){
			System.out.println(1);
			return map;
		}
		
		String uemail=subject.getPrincipal().toString();
		map.put("uemail", uemail);
		List<Users>listu=userservice.findUsersByCondition(map);
		String umaxim=request.getParameter("umaxim");
		String usex=request.getParameter("usex");
		String uaddress=request.getParameter("uaddress");
		String unickname=request.getParameter("unickname");
		if(!listu.isEmpty()){
			map.put("umaxim", umaxim);
			map.put("unickname", unickname);
			map.put("usex", usex);
			map.put("uaddress", uaddress);
			
			userservice.updateUsers(map);
		}
		map.clear();
		subject.getSession().setAttribute("currentNickName", unickname);
		map.put("state", 1);
		map.put("msg", "修改成功");
		
		
		return map;
	}
	
	
	
	@RequestMapping("/updatePhoto.do")
	public @ResponseBody Map<String,Object> uploadPhoto(HttpServletRequest request,HttpServletResponse response,Model model){
		Subject subject =SecurityUtils.getSubject();
		Map<String,Object> map=new HashMap<String, Object>();
		if(subject.getPrincipal()==null){
			return map;
		}
		
		String uemail=subject.getPrincipal().toString();
		String uphoto=request.getParameter("uphoto");
		uphoto=uphoto.substring(uphoto.indexOf(",")+1);
		map.put("uphoto", uphoto);
		map.put("uemail", uemail);
		userservice.updateUsers(map);

		subject.getSession().setAttribute("uphoto", uphoto);
		
		map.clear();
		map.put("state", 1);
		map.put("msg", "头像修改成功");
		return map;
	}
	@RequestMapping("/updatePass.do")
	public @ResponseBody Map<String,Object> updatePass(HttpServletRequest request,HttpServletResponse response,Model model){
		Subject subject =SecurityUtils.getSubject();
		Map<String,Object> map=new HashMap<String, Object>();
		if(subject.getPrincipal()==null){
			return map;
		}
		
		System.out.println("进来了");
		String uemail=subject.getPrincipal().toString();
		String oldupass=request.getParameter("oldupass");
		String newupass=request.getParameter("newupass");
		map.put("uemail", uemail);
		List<Users> listu=userservice.findUsersByCondition(map);
		
		//使用shiro提供的加密方式
		Object bs=ByteSource.Util.bytes(uemail);
		SimpleHash sh=new SimpleHash("MD5", oldupass,bs, 5);
		oldupass=sh.toString();
		
		//密码匹配正确修改
		if(oldupass.equals(listu.get(0).getUpassword())){
			sh=new SimpleHash("MD5", newupass,bs, 5);
			newupass=sh.toString();
			map.put("upassword", newupass);
			userservice.updateUsers(map);
		}
		map.clear();
		map.put("state", 1);
		map.put("msg", "密码修改成功");
		return map;
	}
	
	//用户消息
	@RequestMapping("/userMessage.do")
	public String userMessage(HttpServletRequest request,Model model){
		Subject subject=SecurityUtils.getSubject(); 
		if(subject.getPrincipal()==null){
			return "redirect:/pyl/lookIndex.do";
		}
		String uemail=subject.getPrincipal().toString();
		Map<String, Object> map=new HashMap<String, Object>();
		
		int pageNo=1;
		int pageSize=10;
		map.put("uemail", uemail);
		int pageMax=messageService.findUserMessageMaxNum(map);
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		map.put("desc", "");
		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
		try {
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
			if(pageNo>pageMax)pageNo=pageMax;
		} catch (Exception e) {
			// TODO: handle exception
			pageNo=1;
		}
		
		List<UserMessage> listms=messageService.findUserMessageByCondition(map);
		
		model.addAttribute("listms",listms);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageMax", pageMax);
		return "forward:/static/html/user/message.jsp";
	}	
	
	
	@RequestMapping("/clearAllMsg.do")
	public @ResponseBody Map<String, Object> clearAllMsg(HttpServletRequest request,Model model){
		Subject subject=SecurityUtils.getSubject(); 
		Map<String, Object> map=new HashMap<String, Object>();
		if(subject.getPrincipal()==null){
			return map;
		}
		try {
			messageService.removeUserMessageAll();		
			map.put("state", 1);
			map.put("msg", "清空完成");
			
		} catch (Exception e) {
			// TODO: handle exception
			map.put("state", 0);
			map.put("msg", "清空失败");
		}
		return map;
	}
	
	@RequestMapping("/clearOneMsg.do")
	public @ResponseBody Map<String, Object> clearOneMsg(HttpServletRequest request,Model model){
		Subject subject=SecurityUtils.getSubject(); 
		Map<String, Object> map=new HashMap<String, Object>();
		if(subject.getPrincipal()==null){
			return map;
		}
		String messageId=request.getParameter("messageId");
		try {
			map.put("state", 2);
			messageService.removeUserMessageById(Integer.parseInt(messageId));	
			
		} catch (Exception e) {
			// TODO: handle exception
			map.put("state", 0);
			map.put("msg", "删除失败");
		}
		return map;
	}
	
	//更多帖子
	@RequestMapping("/morePosts.do")
	public String morePosts(HttpServletRequest request,Model model){
		Subject subject=SecurityUtils.getSubject(); 
		Map<String, Object> map=new HashMap<String, Object>();
		
		String smoduleId=request.getParameter("sid");
		String smoduleName=request.getParameter("sname");
		
		
		map.clear();//清空map
		List<Smodule> lists=SmoduleService.findSmoduleAll();//所有模块
		boolean flag=false;
		int sid=0;
		try {
			sid=Integer.parseInt(smoduleId);
			for (Smodule s : lists) {
				if(s.getSmoduleId()==sid){
					flag=true;
					smoduleName=s.getSmoduleName();
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	
		if(flag){
			model.addAttribute("smoduleName", smoduleName);
		}else{
			model.addAttribute("smoduleName", "综合");
		}
		
		
		
		int pageNo=1;
		int pageSize=10;
		if(smoduleName!=null){
			map.put("smoduleName", smoduleName);
		}
		int pageMax=postsService.findPostsMaxNum(map);
		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
		try {
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
		} catch (Exception e) {
			// TODO: handle exception
			pageNo=1;
		}
		if(pageNo>pageMax)pageNo=pageMax;
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		map.put("desc", "");
		List<Posts> listp=postsService.findPostsByCondition(map);
		
		map.clear();
		map.put("hot", "1");
		map.put("desc", "");//倒叙
		map=Myutil.fenPage(map, 10,1);
		List<Posts> listph=postsService.findPostsByCondition(map);//置顶的
		
		
		model.addAttribute("listph",listph);
		model.addAttribute("listp",listp);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageMax", pageMax);
		model.addAttribute("lists", lists);
		return "forward:/static/html/jie/index.jsp";
	}	
	
	
	//更多帖子
	@RequestMapping("/loadphoto.do")
	public @ResponseBody Map<String, Object> loadphoto(HttpServletRequest request,Model model){
		Map<String, Object> map=new HashMap<String, Object>();
		String uemail=request.getParameter("uemail");
		map.put("uemail", uemail);
		List<Users> listu=userservice.findUsersByCondition(map);
		map.clear();
		System.out.println(listu.get(0).getUemail());
		map.put("uphoto", listu.get(0).getUphoto());
		
		return map;
	}	
	
	@RequestMapping("/allUsers.do")
	public String allUsers(HttpServletRequest request,Model model){
		Subject subject =SecurityUtils.getSubject();
		Map<String,Object> map=new HashMap<String, Object>();
		if(!subject.hasRole("admin")){
			return "redirect:pyl/lookIndex.do";
		}
		
		int pageNo=1;
		int pageSize=8;
		int pageMax=userservice.findUsersMaxNum(map);
		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
		try {
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
		} catch (Exception e) {
			// TODO: handle exception
			pageNo=1;
		}
		if(pageNo>pageMax)pageNo=pageMax;
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		map.put("desc", "");
		List<Users> listu=userservice.findUsersByCondition(map);
		
		model.addAttribute("currentemail", subject.getPrincipal().toString());
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageMax", pageMax);
		model.addAttribute("listu", listu);
		return "forward:/static/html/user/admini-users.jsp";
	}	
		
	//禁用用户
	@RequestMapping("/banUser.do")
	public @ResponseBody Map<String, Object> banUser(HttpServletRequest request,Model model){
		Map<String, Object> map=new HashMap<String, Object>();
		String uemail=request.getParameter("uemail");
		String uban=request.getParameter("uban");
		map.put("uemail", uemail);
		map.put("uban",uban);
		userservice.updateUsers(map);
		map.clear();
		map.put("state", uban);
		return map;
	}	
	
	//搜索用户
	@RequestMapping("/searchUsers.do")
	public  String searchUsers(HttpServletRequest request,Model model){
		Subject subject =SecurityUtils.getSubject();
		Map<String,Object> map=new HashMap<String, Object>();
		if(!subject.hasRole("admin")){
			return "redirect:pyl/lookIndex.do";
		}
		String searchname=request.getParameter("name");
		String searchuemail=request.getParameter("email");
		
		map.put("uemail", searchuemail);
		map.put("unickname", searchname);
		int pageNo=1;
		int pageSize=8;
		int pageMax=userservice.findUsersMaxNum(map);
		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
		try {
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
		} catch (Exception e) {
			// TODO: handle exception
			pageNo=1;
		}
		if(pageNo>pageMax)pageNo=pageMax;
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		map.put("desc", "");
		map.put("uemaillike", "");
		List<Users> listu=userservice.findUsersByCondition(map);
		map.clear();
		model.addAttribute("currentemail", subject.getPrincipal().toString());
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageMax", pageMax);
		model.addAttribute("listu", listu);
		model.addAttribute("searchname", searchname);
		model.addAttribute("searchuemail", searchuemail);
		return "forward:/static/html/user/admini-users.jsp";
	}	
	
	
	@RequestMapping("/allPosts.do")
	public String allPosts(HttpServletRequest request,Model model){
		Subject subject =SecurityUtils.getSubject();
		Map<String,Object> map=new HashMap<String, Object>();
		if(!subject.hasRole("admin")){
			return "redirect:pyl/lookIndex.do";
		}
		
		int pageNo=1;
		int pageSize=8;
		int pageMax=postsService.findPostsMaxNum(map);
		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
		try {
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
		} catch (Exception e) {
			// TODO: handle exception
			pageNo=1;
		}
		if(pageNo>pageMax)pageNo=pageMax;
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		map.put("desc", "");
		List<Posts> listp=postsService.findPostsByCondition(map);
		
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageMax", pageMax);
		model.addAttribute("listp", listp);
		return "forward:/static/html/user/admini-posts.jsp";
	}	
//	
	//加精帖子
	@RequestMapping("/hotPosts.do")
	public @ResponseBody Map<String, Object> hotPosts(HttpServletRequest request,Model model){
		Map<String, Object> map=new HashMap<String, Object>();
		String postsNo=request.getParameter("postsNo");
		String hot=request.getParameter("hot");
		map.put("postsNo", postsNo);
		map.put("hot",hot);
		postsService.updatePosts(map);
		return map;
	}	
	
	//置顶帖子
	@RequestMapping("/topPosts.do")
	public @ResponseBody Map<String, Object> topPosts(HttpServletRequest request,Model model){
		Map<String, Object> map=new HashMap<String, Object>();
		String postsNo=request.getParameter("postsNo");
		String top=request.getParameter("top");
		map.put("postsNo", postsNo);
		map.put("top",top);
		postsService.updatePosts(map);
		return map;
	}	
//	
//	//搜索用户
//	@RequestMapping("/searchUsers.do")
//	public  String searchUsers(HttpServletRequest request,Model model){
//		Subject subject =SecurityUtils.getSubject();
//		Map<String,Object> map=new HashMap<String, Object>();
//		if(!subject.hasRole("admin")){
//			return "redirect:pyl/lookIndex.do";
//		}
//		String searchname=request.getParameter("name");
//		String searchuemail=request.getParameter("email");
//		
//		map.put("uemail", searchuemail);
//		map.put("unickname", searchname);
//		int pageNo=1;
//		int pageSize=8;
//		int pageMax=userservice.findUsersMaxNum(map);
//		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
//		try {
//			pageNo=Integer.parseInt(request.getParameter("pageNo"));
//		} catch (Exception e) {
//			// TODO: handle exception
//			pageNo=1;
//		}
//		if(pageNo>pageMax)pageNo=pageMax;
//		map=Myutil.fenPage(map, pageSize, pageNo);//分页
//		map.put("desc", "");
//		map.put("uemaillike", "");
//		List<Users> listu=userservice.findUsersByCondition(map);
//		map.clear();
//		model.addAttribute("currentemail", subject.getPrincipal().toString());
//		model.addAttribute("pageNo", pageNo);
//		model.addAttribute("pageMax", pageMax);
//		model.addAttribute("listu", listu);
//		model.addAttribute("searchname", searchname);
//		model.addAttribute("searchuemail", searchuemail);
//		return "forward:/static/html/user/admini-users.jsp";
//	}	
	
}
