package pyl.web.controller;

import java.util.ArrayList;
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

import pyl.pojo.Likes;
import pyl.pojo.Posts;
import pyl.pojo.PostsContent;
import pyl.pojo.Reply;
import pyl.pojo.Role;
import pyl.pojo.RoleRelation;
import pyl.pojo.Smodule;
import pyl.pojo.UserCollect;
import pyl.pojo.Users;
import pyl.service.UsersService;
import pyl.service.LikesService;
import pyl.service.PostsContentService;
import pyl.service.PostsService;
import pyl.service.ReplyService;
import pyl.service.RoleRelationService;
import pyl.service.SmoduleService;
import pyl.service.UserCollectService;
import pyl.util.GetHttpIP;
import pyl.util.MyMD5;
import pyl.util.MyUUID;
import pyl.util.Myutil;

@Controller
@RequestMapping("/userSet")
public class UsersSetController {
	
	@Autowired
	private UsersService userservice=null;
	@Autowired
	private PostsService postsService=null;
	@Autowired
	private PostsContentService pcService=null;
	@Autowired
	private ReplyService replyService=null;
	@Autowired
	private RoleRelationService roleRelationService=null;
	@Autowired
	private LikesService likesService=null;
	@Autowired
	private UserCollectService ucService=null;
	
	//访问用户主页
	@RequestMapping("/home.do")
	public String addPosts(HttpServletRequest request,Model model){
		String uname=request.getParameter("uemail");
		Subject subject=SecurityUtils.getSubject(); 
		if(uname==null||"".equals(uname)){
			uname=subject.getPrincipal().toString();
			if(uname==null||"".equals(uname)){
				return "redirect:/static/html/login.jsp";
			}
		}
		Map<String,Object> map=new HashMap<String, Object>();
		//查询用户信息
		map.put("uemail", uname);
		List<Users> listu=userservice.findUsersByCondition(map);
		//用户的全选
		List<RoleRelation> listrole=roleRelationService.findRoleRelationByCondition(map);
		
		
		map=Myutil.fenPage(map, 12, 1);//分页
		map.put("desc", "");
		List<Posts> listp=postsService.findPostsByCondition(map);
		List<Reply> listr=replyService.findReplyByCondition(map);
		
		
		model.addAttribute("listrole", listrole);
		model.addAttribute("listr", listr);
		model.addAttribute("listp", listp);
		
	
		model.addAttribute("user", (Users)listu.get(0));
		
		return "forward:/static/html/user/home.jsp";
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
		posts.setIp(GetHttpIP.getIpAddress(request));
		
		//postsContent类创建
		PostsContent postsC=new PostsContent();
		postsC.setPostsNo(uuid);
		postsC.setContent(content);
		
		//修改飞吻余额的
		map.put("uEmail", uEmail);
		map.put("uScore", y);
		
		
		postsService.addPosts(posts);
		pcService.addPostsContent(postsC);
		userservice.updateUsers(map);
		map.put("state", "1");
		map.put("msg", "发表成功");
		map.put("url", "/luntan/static/html/index.jsp");
		return map;
	}
	
	//访问用户帖子
	@RequestMapping("/detail.do")
	public String detail(HttpServletRequest request,Model model){
		String uname=request.getParameter("uemail");
		String postsNo=request.getParameter("postsNo");
		Subject subject=SecurityUtils.getSubject(); 
		if(uname==null||"".equals(uname)){
			return "redirect:/pyl/lookIndex.do";
		}
		
		Map<String,Object> map=new HashMap<String, Object>();
		//查询用户信息
		map.put("uemail", uname);
		List<Users> listu=userservice.findUsersByCondition(map);
		
		//查询该用户的帖子
		map.put("postsNo", postsNo);
		List<Posts> listp=postsService.findPostsByCondition(map);
		Posts p1=listp.get(0);
		map.put("pageView", p1.getPageView()+1);
		postsService.updatePosts(map);
		
		
		//查询帖子的内容
		List<PostsContent> listpc=pcService.findPostsContentByCondition(map);
		PostsContent pc=listpc.get(0);
		String ct=pc.getContent();
		ct=Myutil.replacFace(ct);//替换表情和标签和换行
		pc.setContent(ct);
		
		//查询帖子的所有回复
		map.clear();
		map.put("postsNo", postsNo);
		int pageNo=1;
		int pageSize=10;
		int pageMax=replyService.findReplyMaxNum(map);
		//查询所有置顶的
		map.put("top", 1);
		map.put("postsNo", postsNo);
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		List<Reply> listrtop=replyService.findReplyByCondition(map);
		int topnum=0;
		if(!listrtop.isEmpty()){
			topnum=listrtop.size();
			pageMax-=topnum;
		}
		pageMax=pageMax%pageSize!=0?pageMax/pageSize+1:1;
		
		try {
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
			if(pageNo>pageMax)pageNo=pageMax;
		} catch (Exception e) {
			// TODO: handle exception
			pageNo=1;
		}
		
		map.clear();
		map.put("top", "0");
		map.put("postsNo", postsNo);
//		pageSize=pageSize-topnum;
		if(pageSize<0){
			pageSize=0;
		}
		
		map=Myutil.fenPage(map, pageSize, pageNo);//分页
		map.put("desc", "");
		List<Reply> listr=replyService.findReplyByCondition(map);
		
		//判断是否进入自己的帖子
		String currentemail="";
		if(subject.getPrincipal()!=null)
			currentemail=subject.getPrincipal().toString();//当前登录的帐号
		
		if(!"".equals(currentemail)&&uname.equals(currentemail)){
			model.addAttribute("delete",1);
		}
		
		map.clear();
		List<Likes> listlike=null;
		if(subject.getPrincipal()!=null){
			String email=subject.getPrincipal().toString();
			map.put("email", email);
			listlike=likesService.findLikesByCondition(map);
		}
		
		map.clear();
		map.put("postsNo", postsNo);
		map.put("uemail", uname);
		//查询是否收藏
		List<UserCollect> clist=ucService.findUserCollectByCondition(map);
		if(clist.isEmpty()){
			model.addAttribute("uc", "1");
		}else{
			model.addAttribute("uc", "0");
		}
		
		
		model.addAttribute("listlike", listlike);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageMax", pageMax);
		model.addAttribute("listr", listr);
		model.addAttribute("listrtop", listrtop);
		model.addAttribute("postsc", pc);
		model.addAttribute("posts", listp.get(0));
		model.addAttribute("user", (Users)listu.get(0));
		
		return "forward:/static/html/jie/detail.jsp";
	}	
	
	
	
}
