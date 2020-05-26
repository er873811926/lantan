package pyl.web.controller;

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

import pyl.pojo.Posts;
import pyl.pojo.PostsContent;
import pyl.pojo.Reply;
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
	
	
	
	

	
	
	//登录
	@RequestMapping("/sdfsdf.do")
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
			map.put("url", "/luntan/static/html/index.jsp");
		}
		
		return map;
	}
	
	
	
	
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
		
		map.put("uEmail", uname);
		List<Users> listu=userservice.findUsersByCondition(map);
		
		map=Myutil.fenPage(map, 12, 1);//分页
		map.put("desc", "");
		List<Posts> listp=postsService.findPostsByCondition(map);
		List<Reply> listr=replyService.findReplyByCondition(map);
		
		
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
	
	
	
}
