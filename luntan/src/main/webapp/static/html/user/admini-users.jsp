<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<title>暗箱操作</title>
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
      <shiro:hasRole name="admin">
	      <li class="layui-nav-item layui-this">
	        <a href="/luntan/static/html/user/admini-users.jsp"><i class="iconfont layui-icon">&#xe62b;</i>管理</a>
	      </li>
      </shiro:hasRole>
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
      
      <!-- 未登入的状态 -->
     
	<shiro:notAuthenticated> 
      <li class="layui-nav-item">
        <a class="iconfont icon-touxiang layui-hide-xs" href="/luntan/static/html/user/login.jsp"></a>
      </li>
      <li class="layui-nav-item">
        <a href="/luntan/static/html/user/login.jsp">登入</a>
      </li>
      <li class="layui-nav-item">
        <a href="/luntan/static/html/user/reg.jsp">注册</a>
      </li>

    </shiro:notAuthenticated>
      
         <!-- 登入后的状态 -->
      <shiro:authenticated>
      <li class="layui-nav-item">
        <a class="fly-nav-avatar" href="userSet/home.do">
          <cite class="layui-hide-xs">${currentNickName}</cite>
          <%-- <img src="${uphoto}"> --%>
          <img src="data:image/jpeg;base64,${uphoto}">
        </a>
        <dl class="layui-nav-child">
          <dd><a href="/luntan/static/html/user/set.jsp"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
          <dd><a href="/luntan/static/html/user/message.jsp"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
          <dd><a href="/luntan/static/html/user/home.jsp"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
          <hr style="margin: 5px 0;">
          <dd><a href="logout.do" style="text-align: center;">退出</a></dd>
        </dl>
      </li>
       </shiro:authenticated>
     
    </ul>
  </div>
</div>


		<div class="layui-container fly-marginTop fly-user-main">
			<ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
				
				<li class="layui-nav-item layui-this" >
					<a href="javasrcipt:;">
						<i class="layui-icon">&#xe613;</i> 用户管理
					</a>
				</li>
				<li class="layui-nav-item ">
					<a href="/luntan/static/html/user/admini-posts.jsp">
						<i class="layui-icon">&#xe655;</i> 帖子管理
					</a>
				</li>
				<!-- <li class="layui-nav-item">
					<a href="set.html">
						<i class="layui-icon">&#xe620;</i> 基本设置
					</a>
				</li> -->
			</ul>

			<div class="site-tree-mobile layui-hide">
				<i class="layui-icon">&#xe602;</i>
			</div>
			<div class="site-mobile-shade"></div>

			<div class="site-tree-mobile layui-hide">
				<i class="layui-icon">&#xe602;</i>
			</div>
			<div class="site-mobile-shade"></div>

			<div class="fly-panel fly-panel-user" pad20>
				<div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
					
					<div class="layui-form-item">
					    
					    <div class="layui-input-inline">
					      <input type="text" name="title" required  lay-verify="required" placeholder="请输入帐号或者昵称" autocomplete="off" class="layui-input">
					    </div>
					    <div class="layui-btn" id="mysearch">
					    	搜索<i class="layui-icon">&#xe615;</i>
					    </div>
  					</div>
					<div id="LAY_minemsg" style="margin-top: 10px;">
						<!--<div class="fly-none">您暂时没有最新消息</div>-->
						<table class="layui-table">
							<colgroup>
								<col width="110">
								<col width="">
								<col width="">
								<col width="">
								<col width="80">
							</colgroup>
							<thead>
								<tr>
									<th>昵称</th>
									<th>邮箱</th>
									<th>登录时间</th>
									<th>签名</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listu}" var="us">
								<c:if test="${us.uemail ne currentemail}">
								<tr>
									<td class="uname">${us.unickname}</td>
									<td class="uemail">${us.uemail}</td>
									<td>${us.logintime}</td>
									<td>${us.umaxim}</td>
									<c:if test="${us.ban eq 0}">
									<td><div class="layui-btn pyl_ban" value="1">禁用</div></td>
									</c:if>
									<c:if test="${us.ban eq 1}">
									<td><div class="layui-btn pyl_ban" value="0">启用</div></td>
									</c:if>
								</tr>
								</c:if>
								</c:forEach>
							</tbody>
						</table>
						<center class="">
				            <div class="layui-btn  layui-btn-xs" id="prepage">
							  <i class="layui-icon">&#xe603;</i>
							</div>
							<div class="layui-inline">
							<select id="changepage">
								 <c:forEach begin="1" end="${pageMax}" var="a">
								 	<c:if test="${pageNo eq a}">
									  <option value="${a}" selected>${a}</option>
								 	</c:if>
								 <c:if test="${pageNo ne a}">
									  <option value="${a}">${a}</option>
								  </c:if>
								 </c:forEach>
							</select>  
							</div>
							<div class="layui-btn  layui-btn-xs" id="nextpage">
							  <i class="layui-icon">&#xe602;</i>
							</div>
				      	 </center> 
					</div>
				</div>
			</div>

		</div>

		<div class="fly-footer">
			<p>
				<a href="http://fly.layui.com/" target="_blank">痴优社区</a> 2020 &copy;
				<a href="http://www.layui.com/" target="_blank">jiandan 出品</a>
			</p>
			<!--<p>
    <a href="http://fly.layui.com/jie/3147/" target="_blank">付费计划</a>
    <a href="http://www.layui.com/template/fly/" target="_blank">获取Fly社区模版</a>
    <a href="http://fly.layui.com/jie/2461/" target="_blank">微信公众号</a>
  </p>-->
		</div>

		<script src="/luntan/static/res/layui/layui.js"></script>
		<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>
		<script>
			layui.cache.page = 'user';
			layui.cache.user = {
				username: '游客',
				uid: -1,
				avatar: '/luntan/static/res/images/avatar/00.jpg',
				experience: 83,
				sex: '男'
			};
			layui.config({
				version: "3.0.0",
				base: '/luntan/static/res/mods/'
			}).extend({
				fly: 'index'
			}).use('fly');
		</script>

	</body>

</html>

<script type="text/javascript">
	$(".pyl_ban").each(function(i){
		$(".pyl_ban").eq(i).click(function(){
			var name=$(this).parent().siblings(".uname").html();
			var uemail=$(this).parent().siblings(".uemail").html();
			var ban=$(this).attr("value");
			if(confirm('是否禁用用户：'+name)){
				$.ajax({
					url:'pyl/banUser.do',
					type:'post',
					dataType:'json',
					data:{"uemail":uemail,"ban":ban},
					success:function(data){
						if(data.state==0){
							$(this).html("禁用");
							$(this).attr("value",1);
						}
						if(data.state==1){
							$(this).html("启用");
							$(this).attr("value",0);
						}
					}
				
				});
						
			}
		})
		
	})
	
</script>
