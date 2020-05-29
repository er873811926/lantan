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
				
				<li class="layui-nav-item " >
					<a href="/luntan/static/html/user/admini-users.jsp">
						<i class="layui-icon">&#xe613;</i> 用户管理
					</a>
				</li>
				<li class="layui-nav-item layui-this">
					<a href="javascript:;">
						<i class="layui-icon">&#xe655;</i> 帖子管理
					</a>
				</li>
				<li class="layui-nav-item">
					<a href="set.html">
						<i class="layui-icon">&#xe620;</i> 基本设置
					</a>
				</li>
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
								<col width="80">
								<col width="120">
								<col width="120">
								<col width="80">
							</colgroup>
							<thead>
								<tr>
									<th>作者</th>
									<th>标题</th>
									<th>类型</th>
									<th>置顶</th>
									<th>加精</th>
									<th>删除</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>肥鸡</td>
									<td><a href="">其实考研计划要详细制定</a></td>
									<td>分享</td>
									<td><div class="layui-btn">置顶</div></td>
									<td><div class="layui-btn">加精</div></td>
									<td><div class="layui-btn">删除</div></td>
								</tr>
								<tr>
									<td>许闲心</td>
									<td><a href="">每一个大学都有研究生有什么不同</a></td>
									<td>分享</td>
									<td><div class="layui-btn">取消置顶</div></td>
									<td><div class="layui-btn">取消加精</div></td>
									<td><div class="layui-btn">删除</div></td>
								</tr>
								
								
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>

		<div class="fly-footer">
			<p>
				<a href="" target="_blank">禹霖社区</a> 2020 &copy;
				<a href="" target="_blank">yulin 出品</a>
			</p>
	
		</div>
		<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>
		<script src="/luntan/static/res/layui/layui.js"></script>
		<script>
			layui.cache.page = 'user';
			layui.cache.user = {
				username: '游客',
				uid: -1,
				avatar: '../../res/images/avatar/00.jpg',
				experience: 83,
				sex: '男'
			};
			layui.config({
				version: "3.0.0",
				base: '../../res/mods/'
			}).extend({
				fly: 'index'
			}).use('fly');
		</script>

	</body>


</html>
<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>