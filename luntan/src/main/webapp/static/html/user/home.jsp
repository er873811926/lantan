<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false"%>
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
	  <title>用户主页</title>
	  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	  <link rel="stylesheet" href="/luntan/static/res/layui/css/layui.css">
	  <link rel="stylesheet" href="/luntan/static/res/css/global.css">
</head>
<body style="margin-top: 65px;">

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
	        <a href="pyl/allUsers.do"><i class="iconfont layui-icon">&#xe62b;</i>管理</a>
	      </li>
      </shiro:hasRole>
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
      <%-- 未登入的状态 --%>   
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
          <dd><a href="pyl/playSet.do"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
          <dd><a href="pyl/userMessage.do"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
          <dd><a href="userSet/home.do"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
          <hr style="margin: 5px 0;">
          <dd><a href="logout.do" style="text-align: center;">退出</a></dd>
        </dl>
      </li>
       </shiro:authenticated>
     
    </ul>
  </div>
</div>


<div class="fly-home fly-panel" style="background-image: url();">
  <img  class="user_photo" src="data:image/jpeg;base64,${user.uphoto}" alt="贤心">
  <h1>
    ${user.unickname}
    <c:if test="${requestScope.user.usex eq '男'}">
    	<i class="iconfont icon-nan"></i>
    </c:if>
    <c:if test="${requestScope.user.usex eq '女'}">
   		 <i class="iconfont icon-nv"></i> 
    </c:if>
    
	    <!--特殊身份显示-->
	 <c:forEach items="${listrole}" var="role">
   	   <c:if test="${role.roleName eq 'admin'}">
	    <span style="color:#c00;">（管理员）</span>
	    <%-- <span style="color:#5FB878;">（社区之光）</span> --%>
       </c:if>
     </c:forEach>
    <c:if test="${requestScope.user.uban eq '1'}">
   		 <span>（该号已被封）</span>
    </c:if>
  </h1>

  <%-- <p style="padding: 10px 0; color: #5FB878;">认证信息：白给</p> --%>

  <p class="fly-home-info">
    <i class="iconfont icon-kiss" title="飞吻"></i><span style="color: #FF7200;">${requestScope.user.uscore } 飞吻</span>
    <i class="iconfont icon-shijian"></i><span>${requestScope.user.uregistertime} 加入</span>
    <i class="iconfont icon-chengshi"></i><span>${requestScope.user.uaddress}</span>
  </p>

  <p class="fly-home-sign">（${requestScope.user.umaxim}）</p>

<%--  <div class="fly-sns" data-user="">
    <a href="javascript:;" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">加为好友</a>
    <a href="javascript:;" class="layui-btn layui-btn-normal fly-imActive" data-type="chat">发起会话</a>
  </div>--%>

</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md6 fly-home-jie">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${user.unickname} ——最近的发帖</h3>
        <ul class="jie-row">
        	<c:set var="flag" value="0"></c:set>
          <c:forEach items="${listp}" var="p" varStatus="vs">
          	<c:if test="${vs.index eq 0}">
          		<c:set var="flag" value="1"></c:set>
          	</c:if>
        	<li>
        	<c:if test="${p.hot eq '1'}">
           	 <span class="fly-jing">精</span>
            </c:if>
            <a href="userSet/detail.do?postsNo=${p.postsNo}&uemail=${p.uemail}" class="jie-title"> ${p.postsTitle}</a>
            <i>${p.uptime}</i>
            <em class="layui-hide-xs">${p.pageView}阅 / ${p.replyNum}评论</em>
          </li>
          </c:forEach>
          <!-- <li>
            <span class="fly-jing">精</span>
            <a href="" class="jie-title"> 你的帖子真的帖子好</a>
            <i>刚刚</i>
            <em class="layui-hide-xs">1136阅/27答</em>
          </li>
           -->
           <c:if test="${flag eq 0}">
          		<div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何求解</i></div>
          	</c:if>
          <!-- <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何求解</i></div> -->
        </ul>
      </div>
    </div>
    
    <div class="layui-col-md6 fly-home-da">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${user.unickname} ——最近的回帖</h3>
        <ul class="home-jieda">
        <c:set var="flag" value="0"></c:set>
          <c:forEach items="${listr}" var="r" varStatus="vs">
          	<c:if test="${vs.index eq 0}">
          		<c:set var="flag" value="1"></c:set>
          	</c:if>
          	<li>
          <p>
          <span>${r.replyTime}</span>
          在<a href="" target="_blank">${r.postsTitle}</a>中回帖：
          </p>
          <div class="home-dacontent">
            ${r.replyContent}
          </div>
        </li>
          </c:forEach>
          
          <!-- 
        <li>
          <p>
          <span>5分钟前</span>
          在<a href="" target="_blank">在Fly社区用的是什么系统啊?</a>中回答：
          </p>
          <div class="home-dacontent">
            Fly社区采用的是NodeJS。分享出来的只是前端模版
          </div>
        </li> -->
       	  <c:if test="${flag eq 0}">
          		<div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有任何的回帖</span></div>
          </c:if>
          <!-- <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何问题</span></div> -->
        </ul>
      </div>
    </div>
  </div>
</div>

<div class="fly-footer">
  <p><a href="http://fly.layui.com/" target="_blank">禹霖社区</a> 2020 &copy; <a href="http://www.layui.com/" target="_blank">jiandan 出品</a></p>
 <!-- <p>
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
