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
	  <title>禹霖_更多优贴</title>
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

<div class="fly-panel fly-column">
  <div class="layui-container">
    <ul class="layui-clear">
    	<c:if test="${smoduleName eq '综合'}">
    	  <li class="layui-hide-xs layui-this"><a href="pyl/morePosts.do">综合</a></li> 
    	</c:if>
    	<c:if test="${smoduleName ne '综合'}">
    	  <li class="layui-hide-xs"><a href="pyl/morePosts.do">综合</a></li> 
    	</c:if>
    	<c:if test=""></c:if>
    	<c:if test=""></c:if>
    	<c:if test=""></c:if>
      <c:forEach items="${lists}" var="s">
		    	<c:if test="${smoduleName eq s.smoduleName}">
             	  <li class="layui-hide-xs layui-this"><a href="pyl/morePosts.do?sid=${s.smoduleId}&sname=${s.smoduleName}">${s.smoduleName }</a></li> 
		    	</c:if>
		    	<c:if test="${smoduleName ne s.smoduleName}">
             	  <li class="layui-hide-xs"><a href="pyl/morePosts.do?sid=${s.smoduleId}&sname=${s.smoduleName}">${s.smoduleName }</a></li> 
		    	</c:if>
      </c:forEach>
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li>
      
      <!-- 用户登入后显示 -->
       <shiro:authenticated>
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="pyl/findMyPosts.do?state=0">我发表的贴</a></li> 
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="pyl/findMyPosts.do?state=1">我收藏的贴</a></li> 
       </shiro:authenticated>
    </ul> 
    
    <div class="fly-column-right layui-hide-xs"> 
      <a href="pyl/addPosts.do" class="layui-btn">发表新帖</a> 
    </div> 
    <!-- <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;"> 
      <a href="" class="layui-btn">发表新帖</a> 
    </div>  -->
  </div>
</div>


<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <a class="layui-this">${smoduleName}</a>
          <span class="fly-filter-right layui-hide-xs">
            <a href="" class="layui-this">按最新</a>
            <span class="fly-mid"></span>
            <a href="">按热议</a>
          </span>
        </div>
		<c:set var="flag" value="0"></c:set>
        <ul class="fly-list">          
          <%-- 循环放置帖子信息--%>
        	<c:forEach items="${listp}" var="pt" varStatus="vs">
        		<c:if test="${vs.index eq 0}">
        			<c:set var="flag" value="1"></c:set>
        		</c:if>
        		<li>
		            <a href="userSet/home.do?uemail=${pt.uemail}" class="fly-avatar">
		              <img  class="user_photo" src="data:image/jpeg;base64,${pt.uphoto}" alt="贤心">
		            </a>
		            <h2>
		              <a class="layui-badge">${pt.smoduleName}</a>
		              <a href="userSet/detail.do?postsNo=${pt.postsNo}&uemail=${pt.uemail}">${pt.postsTitle}</a>
		            </h2>
		            <div class="fly-list-info">
		              <a href="userSet/home.do?uemail=${pt.uemail}" link>
		                <cite>${pt.unickname}</cite>
		              </a>
		              <span>${pt.uptime}</span>
		              
		              <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i>${pt.reward}</span>
		              <span class="fly-list-nums"> 
		                <i class="iconfont icon-pinglun1" title="回复"></i>${pt.replyNum}
		              </span>
		            </div>
		            <div class="fly-list-badge">
		              <%--
		              <span class="layui-badge layui-bg-black">置顶</span>
		              --%>
		              <c:if test="${pt.hot eq '1'}">
		              	<span class="layui-badge layui-bg-red">精帖</span>
		              </c:if>
		            </div>
		          </li>        	
        	</c:forEach> 
          
        </ul>
        
        <%-- 无数据时 --%>
        <c:if test="${flag eq 0}">
        	<div class="fly-none">没有相关数据</div>
        </c:if>
    
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
    <div class="layui-col-md4">
      <%-- <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">本周热议</dt>
        <dd>
          <a href="">基于 layui 的极简社区页面模版</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
      </dl> --%>

      <div class="fly-panel">
        <div class="fly-panel-title">
          这里可作为广告区域
        </div>
        <div class="fly-panel-main">
          <a href="" target="_blank" class="fly-zanzhu" style="background-color: #393D49;">虚席以待</a>
        </div>
      </div>
      
      <dl class="fly-panel fly-list-one">
       <dt class="fly-panel-title">精贴榜</dt>
        <c:set var="flag" value="0"></c:set>
        <c:forEach items="${listph}" var="h" varStatus="vs">
        	<c:if test="${vs.index eq 0}">
        		<c:set var="flag" value="1"></c:set>
        	</c:if>
        	<dd>
         	 <a href="userSet/detail.do?postsNo=${h.postsNo}&uemail=${h.uemail}"> ${h.postsTitle}</a>
          	 <span><i class="iconfont icon-pinglun1"></i>${h.replyNum}</span>
       		</dd>
        </c:forEach>
        <!-- <dd>
          <a href="jie/detail.html"> 你的帖子也写得太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
         -->
        <!-- 无数据时 -->
        <c:if test="${flag eq 0}">
        	<div class="fly-none">没有相关数据</div>
        </c:if>
      </dl>

    </div>
  </div>
</div>

<div class="fly-footer">
  <p><a href="" target="_blank">禹霖社区</a> 2017 &copy; <a href="" target="_blank">yulin 出品</a></p>
</div>
<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>
<script src="/luntan/static/res/layui/layui.js"></script>
<script src="/luntan/static/res/pyl.js"></script>
<script>
layui.cache.page = 'jie';
layui.cache.user = {
  username: '游客'
  ,uid: -1
  ,avatar: '/luntan/static/res/images/avatar/00.jpg'
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

$("#changepage").change(function(){
 	//获取被选中的option标签
 	var vs = $('select  option:selected').val();
 	window.location="userSet/detail.do?&uemail="+postsuemali+"&pageNo="+vs;
})

//下一页
$("#nextpage").click(function(){
	console.log("xx");
	pageNo=Number(pageNo)+1;
	if(pageNo>pageMax){
		pageNo=pageMax;
		return;
	}
	window.location="userSet/detail.do?pageNo="+pageNo+"&uemail="+postsuemali;
})

//上一页
$("#prepage").click(function(){
	pageNo=Number(pageNo)-1;
	
	if(pageNo<=0){
		pageNo=1;
		return;
	}
	window.location="userSet/detail.do?pageNo="+pageNo+"&uemail="+postsuemali;
})

</script>
