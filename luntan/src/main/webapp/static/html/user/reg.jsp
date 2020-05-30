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
	  <title>注册</title>
	  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	  <link rel="stylesheet" href="/luntan/static/res/layui/css/layui.css">
	  <link rel="stylesheet" href="/luntan/static/res/css/global.css">
</head>
<body>

<div class="fly-header layui-bg-black">
  <div class="layui-container">
    <a class="fly-logo" href="/luntan/static/html/index.jsp">
      <img src="/luntan/static/res/images/logo.png" alt="layui">
    </a>
    <ul class="layui-nav fly-nav layui-hide-xs">
      <li class="layui-nav-item layui-this">
        <a href="/luntan/static/html/index.jsp"><i class="iconfont icon-jiaoliu"></i>首页</a>
      </li>
    </ul>
    
    <ul class="layui-nav fly-nav-user">
       <%--搜索--%>
      <li class="layui-nav-item layui-hide-xs">
      	<input id="soucontent" type="text" name="s" required lay-verify="required" placeholder="请输入搜索内容" autocomplete="off" class="layui-input">
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
  <div class="fly-panel fly-panel-L_email" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="L_email">
      <ul class="layui-tab-title">
        <li><a href="/luntan/static/html/user/login.jsp">登入</a></li>
        <li class="layui-this">注册</li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form layui-form-pane">
            <form method="post">
              <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_email" name="L_email" required lay-verify="L_email" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux email-msg">将会成为您唯一的登入名</div>
              </div>
              <div class="layui-form-item">
                <label for="L_username" class="layui-form-label">昵称</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_username" name="L_username" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux email-msg">长度为1到10;每个中英文都算1个长度</div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="pass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux pass-tips">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="repass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">人类验证</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="vercode" required lay-verify="required" placeholder="请回答后面的问题" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" id="code_tips">
                  <span id="vercode_tips" style="color: #c00;"></span>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-btn" id="pyl_reg">立即注册</div>
              </div>
           
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

</div>

<div class="fly-footer">
  <p><a href="" target="_blank">禹霖社区</a> 2020 &copy; <a href="" target="_blank">yulin 出品</a></p>
</div>

<script src="/luntan/static/res/layui/layui.js"></script>
<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>
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
<script src="/luntan/static/res/pyl.js"></script>
<script type="text/javascript">
	
	(function(){
		yanzhengma();
	})();
	
	
	

	
	var pyl_flag_code=false;
	var pyl_flag_L_pass=false;
	var pyl_flag_L_repass=false;
	var pyl_flag_L_email=false;
	var pyl_flag_L_username=false;
	
	

	
	//昵称失焦
	$('#L_username').blur(function(){
		if($('#L_username').val()=="")return;
		var  namelength=$('#L_username').val().length;
		if(namelength>1 && namelength<10){
			
			pyl_flag_L_username=true; //成功返回不变false，最后注册验证
			return;
		}else{
			layer.msg('输入的昵称长度超过限制', {shift: 6,icon:2});
		}
		pyl_flag_L_username=false;
	
	});

	//密码按键事件
	$('#L_pass').keyup(function(){
		$('#L_repass').val("");
		if($('#L_pass').val()=='')return;
		if($('#L_pass').val().length<6||$('#L_pass').val().length>16){$('.pass-tips').html('&otimes; 长度只能在6-16之间').css('color','orange');pyl_flag_L_pass=false;return;};
		var re1_6_20=/^(\d{6,16}|[A-z]{6,10}|[\W]{6,10})$/g;
		if(re1_6_20.test($('#L_pass').val())){
			$('.pass-tips').html('<i></i>&Theta; 有被盗风险，建议使用数字、字母、和符号两种及以上的组合').css('color','orange');
			pyl_flag_L_pass=true;
			return;
		};
		
		var re2_6_20=/^([\D]{6,16}|[^A-z]{6,10}|[\w]{6,10})$/g;
		if(re2_6_20.test($('#L_pass').val())){
			$('.pass-tips').html('<i></i>&Theta; 安全强度适中，可以使用三种及以上的组合来提高安全强度').css('color','gray');
			pyl_flag_L_pass=true;return;
		};
		
		var renumber=/^.{7,16}$/g;
		if(renumber.test($('#L_pass').val())){
			var re3_1=/[\W]/;
			if(re3_1.test($('#L_pass').val())){
				var re3_2=/[\d]/;
				if(re3_2.test($('#L_pass').val())){
					var re3_3=/[A-z]/;
					if(re3_3.test($('#L_pass').val())){
						$('.pass-tips').html('<i></i>&Theta; 你的密码很安全').css('color','gray');
						pyl_flag_L_pass=true;return;
					};
				};
			};
		};
	});
	
	
	
	//确定密码失焦
	$('#L_repass').blur(function(){
		if($('#L_repass').val()=='')return;
		if($('#L_repass').val()==$('#L_pass').val()){
			
			pyl_flag_L_repass=true;//成功返回不变false，最后注册验证
			return;
		}else{
			layer.msg('两次密码不同', {shift: 6,icon:2});
		}
		
		pyl_flag_L_repass=false;
	});
	
	
	
	
	//邮箱失焦
	var emailjilu='';
	$('#L_email').blur(function(){
	
		var email=$('#L_email').val();
		if(emailjilu==email)return;//防止重复验证
		emailjilu=email;
		var  re=/^[0-9A-z_]+@[0-9A-z_]+\.com$/g;
		if(re.test(email)){
			pyl_flag_L_email=true; //成功返回不变false，最后注册验证
			$.ajax({
			url:'pyl/regYanZheng.do',
			type:'post',
			dataType:'json',
			data:{'uemail':email},
			success:function(data){
				if(data.state==0){
					layer.msg(data.msg, {shift: 6,icon:2});
					pyl_flag_L_email=false;
				}
			},
			
			});
			
			
		}else{
			if($('#L_email').val()=="")return;
			layer.msg('邮箱格式不对，请重试', {shift: 6,icon:2});
			pyl_flag_L_email=false;
		}
	});
	
	//点击更换验证码
	/* $('#code_tips').click(yanzhengma()); */
	
	var ecode=-1;
	//验证失焦
	$('#L_vercode').blur(function(){
		ecode=$("#vercode_tips").attr("code");
		var re=/^[\d]{1,2}$/g;
		if(!re.test($('#L_vercode').val())){
			pyl_flag_code=false;
			return;
		};
		if($('#L_vercode').val()==ecode){
			pyl_flag_code=true;
			
		}
		
	});
	
	
	
	
	
	//注册点击事件去匹配数据库
	$("#pyl_reg").click(function(){
		var flag=formjiance();
		//'uemail':uemail,'upassword':upass,'unickname':uname
		var uemail=$('#L_email').val();
		//if(uemail==""){layer.msg("邮箱不能为空", {shift: 6});return;} ;
		var uname=$('#L_username').val();
		//if(uname==""){layer.msg("昵称不能为空", {shift: 6});return;} ;
		var upass=$('#L_pass').val();
		//if(upass==""){layer.msg("密码不能为空", {shift: 6});return;} ;
		
//		if(pyl_flag_code&&pyl_flag_L_email&&pyl_flag_L_pass&&pyl_flag_L_repass&&pyl_flag_L_username){
		if(flag){
		console.log(flag);
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
			url:'pyl/reg.do',
			type:'post',
			dataType:'json',
			data:{'uemail':uemail,'upassword':upass,'unickname':uname},
			success:function(data){
				if(data.state==0){
					layer.msg(data.msg, {shift: 6,icon:2});
					yanzhengma();				
				}
					
				if(data.state==1){
					layer.msg(data.msg, {shift: 3,icon:1});
					setTimeout(function(){
						window.location = data.url;					
					},1000);  
				}
			},
				
			});
			}else{
				layer.msg("将信息填写完整", {shift: 6,icon:2});
			}
		});
	


</script>


