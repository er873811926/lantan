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
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pyl.pojo.Users;
import pyl.service.UsersService;
import pyl.util.MyMD5;

@Controller
@RequestMapping("/pub")
public class PublicController {
	
	@Autowired
	private UsersService userservice=null;

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
	
	@RequestMapping("/regYanZheng.do")
	public  @ResponseBody Map<String,Object> regYanZheng(HttpServletRequest request,HttpServletResponse response){
		String uemail=request.getParameter("uemail");
		Map<String,Object> map=new HashMap<String, Object>();
		if(uemail==null || uemail.equals(""))return null;
		
		//先用map去查数据库
		map.put("uEmail", uemail);
		List<Users> list=userservice.findUsersByCondition(map);
		
		
		//用map去传递值
		map.clear();
		if(!list.isEmpty()){
			map.put("state", "0");
			map.put("msg", "该邮箱已注册");
		}
		
		return map;
	}

	
	@RequestMapping("/reg.do")
	public  @ResponseBody Map<String,Object> reg(HttpServletRequest request,HttpServletResponse response){
		String uEmail=request.getParameter("uemail");
		String uPassword=request.getParameter("upassword");
		String uNickname=request.getParameter("unickname");
		Map<String,Object> map=new HashMap<String, Object>();
		if("".equals(uEmail) || uEmail==null)return null;
		Users user=new Users();
		user.setUEmail(uEmail);
		//使用shiro提供的加密方式
		Object bs=ByteSource.Util.bytes(uEmail);
		SimpleHash sh=new SimpleHash("MD5", uPassword,bs, 5);
		//=====
		uPassword=sh.toString();
		user.setUPassword(uPassword);
		user.setUNickname(uNickname);
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
	
	@RequestMapping("/login.do")
	@ExceptionHandler
	public  @ResponseBody Map<String,Object> login(HttpServletRequest request,HttpServletResponse response){
		String uEmail=request.getParameter("uemail");
		String uPassword=request.getParameter("upassword");
		Map<String,Object> map=new HashMap<String, Object>();
		if("".equals(uEmail) || uEmail==null)return null;
		
		String[] arr=null;
		boolean flag=true;
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
	
}
