package pyl.web.controller;

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
import pyl.pojo.Posts;
import pyl.pojo.PostsContent;
import pyl.pojo.Smodule;
import pyl.pojo.Users;
import pyl.service.UsersService;
import pyl.service.PostsContentService;
import pyl.service.PostsService;
import pyl.service.ReplyService;
import pyl.service.SmoduleService;
import pyl.util.GetHttpIP;
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
	@ExceptionHandler
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
		List<Posts> listpa=postsService.findPostsAll();//全部的
		
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
	
}
