<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	  <meta charset="utf-8">
	  <title>登入</title>
	  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	  <link rel="stylesheet" href="/luntan/static/res/layui/css/layui.css">
	  <link rel="stylesheet" href="/luntan/static/res/css/global.css">
</head>
<body>

<div class="fly-header layui-bg-black">
  <div class="layui-container">
    <a class="fly-logo" href="pyl/lookIndex.do">
      <img src="/luntan/static/res/images/logo.png" alt="layui">
    </a>
    <ul class="layui-nav fly-nav layui-hide-xs">
      <li class="layui-nav-item layui-this">
        <a href="pyl/lookIndex.do"><i class="iconfont icon-jiaoliu"></i>首页</a>
      </li>
    </ul>
    
    <ul class="layui-nav fly-nav-user">
       <%--搜索--%>
      <li class="layui-nav-item layui-hide-xs">
      	<input id="soucontent" type="text" name="title" required lay-verify="required" placeholder="请输入搜索内容" autocomplete="off" class="layui-input">
      </li>
      <li class="layui-nav-item layui-hide-xs">
        <div class="layui-btn" id="sou">
        	<i class="layui-icon">&#xe615;</i>
        </div> 
      </li>
      <!-- 登入后的状态 -->
      <li class="layui-nav-item">
        <a class="iconfont icon-touxiang layui-hide-xs" href="/luntan/static/html/user/login.jsp"></a>
      </li>
      <li class="layui-nav-item">
        <a href="/luntan/static/html/user/login.jsp">登入</a>
      </li>
      <li class="layui-nav-item">
        <a href="/luntan/static/html/user/reg.jsp">注册</a>
      </li>
     
    </ul>
  </div>
</div>

<div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li class="layui-this">登入</li>
        <li><a href="/luntan/static/html/user/reg.jsp">注册</a></li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form layui-form-pane">
            <form method="post" action="login.do">
              <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_email" name="email" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="pass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">人类验证</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="vercode" required lay-verify="required" placeholder="请回答后面的问题" autocomplete="off" class="layui-input" oninput = "value=value.replace(/[^\d]/g,'')">
                </div>
                <div class="layui-form-mid" id="code_tips">
                  <span id="vercode_tips" style="color: #c00;"></span>
                </div>
              </div>
              <div class="layui-form-item">
                <div id="pyl_login" class="layui-btn">立即登录</div>
                <span style="padding-left:20px;">
                  <a href="/luntan/static/html/user/forget.jsp">忘记密码？</a>
                </span>
              </div>
              
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="fly-footer">
  <p><a href="http://fly.layui.com/" target="_blank">禹霖社区</a> 2020 &copy; <a href="http://www.layui.com/" target="_blank">jiandan 出品</a></p>
<!--  <p>
    <a href="http://fly.layui.com/jie/3147/" target="_blank">付费计划</a>
    <a href="http://www.layui.com/template/fly/" target="_blank">获取Fly社区模版</a>
    <a href="http://fly.layui.com/jie/2461/" target="_blank">微信公众号</a>
  </p>-->
</div>

<script src="/luntan/static/res/layui/layui.js"></script>
<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>
<script src="/luntan/static/res/pyl.js"></script>
<script>
layui.cache.page = 'user';
layui.cache.user = {
  username: '游客'
  ,uid: -1
  ,avatar: '../../res/images/avatar/00.jpg'
  ,experience: 83
  ,sex: '男'
};
layui.config({
  version: "3.0.0"
  ,base: '/luntan/static/res/mods/'
}).extend({
  fly: 'index'
}).use('fly');
</script>
</body>
</html>
<script type="text/javascript">
	(function(){
		yanzhengma();
	})();
	
	
	
	
	var pyl_flag_code=false;
	var ecode=-1;
	//验证失焦
	$('#L_vercode').blur(function(){
		ecode=$("#vercode_tips").attr("code");
		if($('#L_vercode').val()==ecode){
			pyl_flag_code=true;
		}else{
			pyl_flag_code=false;
		}		
	});
	
	//注册登录事件去匹配数据库
	$("#pyl_login").click(function(){
		var flag=formjiance();
		//'uemail':uemail,'upassword':upass,'unickname':uname
		var uemail=$('#L_email').val();
		//if(uemail==""){layer.msg("邮箱不能为空", {shift: 6});return;} ;
		
		var upass=$('#L_pass').val();
		//if(upass==""){layer.msg("密码不能为空", {shift: 6});return;} ;
		if(flag){
			if(!pyl_flag_code){
				$('#L_vercode').css("border-color","red");
					layer.msg("验证码错误",{shift : 6,icon:2});
					setTimeout(function(){
						$('#L_vercode').css("border-color","#e2e2e2");
					},1000);
				return ;
			}
			$('#L_email').val("");
			$("#vercode_tips").attr("code","x");
			$.ajax({
			url:'pyl/login.do',
			type:'post',
			dataType:'json',
			data:{'uemail':uemail,'upassword':upass},
			success:function(data){
				if(data.state==0){
					layer.msg(data.msg, {shift: 6,icon:2});
					yanzhengma();
					pyl_flag_code=false;				
				}
					
				if(data.state==1){
					layer.msg(data.msg, {shift: 3,icon:1});
					setTimeout(function(){
						window.location = data.url;					
					},1000);  
				}
			},
				
			});
			}
			//else{
			//	layer.msg("请填写验证码", {shift: 6});
			//}
		});
	
</script>
