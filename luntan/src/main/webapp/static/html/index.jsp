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
	  <title>禹霖_知识从未停止</title>
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
      <li class="layui-hide-xs layui-this"><a href="">首页</a></li> 
      <c:forEach items="${smodule}" var="s">
               <li><a href="/luntan/static/html/jie/index.jsp?sid=${s.smoduleId}">${s.smoduleName }</a></li> 
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
      <div class="fly-panel">
        <div class="fly-panel-title fly-filter">
          <a>置顶</a>
          <a href="#signin" class="layui-hide-sm layui-show-xs-block fly-right" id="LAY_goSignin" style="color: #FF5722;">去签到</a>
        </div>
        <ul class="fly-list">
        	<c:forEach items="${listpt}" var="pt" varStatus="vs">
        		<li>
		            <a href="/luntan/userSet/home.do?uemail=${pt.uemail}" class="fly-avatar">
		              <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
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
          <%-- <li>
            <a href="/luntan/static/html/user/home.jsp" class="fly-avatar">
              <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
            </a>
            <h2>
              <a class="layui-badge">动态</a>
              <a href="/luntan/static/html/jie/detail.jsp"> 你的帖子也写得太好了</a>
            </h2>
            <div class="fly-list-info">
              <a href="user/home.html" link>
                <cite>贤心</cite>
                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
               <!-- <i class="layui-badge fly-badge-vip">VIP3</i>-->
              </a>
              <span>刚刚</span>
              
              <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> 60</span>
              <span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>
              <span class="fly-list-nums"> 
                <i class="iconfont icon-pinglun1" title="回答"></i> 66
              </span>
            </div>
            <div class="fly-list-badge">
              <!--
              <span class="layui-badge layui-bg-black">置顶</span>
              <span class="layui-badge layui-bg-red">精帖</span>
              -->
            </div>
          </li>
          --%>
        </ul>
      </div>

      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <a href="" class="layui-this">综合</a>
          <span class="fly-mid"></span>
         <%--  <a href="">未结</a>
          <span class="fly-mid"></span>
          <a href="">已结</a>
          <span class="fly-mid"></span> --%>
          <span class="fly-filter-right layui-hide-xs">
            <a href="" class="layui-this">按最新</a>
            <span class="fly-mid"></span>
            <a href="">按热议</a>
          </span>
        </div>

        <ul class="fly-list"> 
        	<c:forEach items="${listpa}" var="pt" varStatus="vs">
        		<li>
		            <a href="userSet/home.do?uemail=${pt.uemail}" class="fly-avatar">
		              <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
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
         <%--  <li>
            <a href="user/home.html" class="fly-avatar">
              <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
            </a>
            <h2>
              <a class="layui-badge">分享</a>
              <a href="jie/detail.html"> 你的帖子也写得太好了</a>
            </h2>
            <div class="fly-list-info">
              <a href="user/home.html" link>
                <cite>贤心</cite>
                <!--
                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                <i class="layui-badge fly-badge-vip">VIP3</i>
                -->
              </a>
              <span>刚刚</span>
              
              <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> 60</span>
              <!--<span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>-->
              <span class="fly-list-nums"> 
                <i class="iconfont icon-pinglun1" title="回答"></i> 66
              </span>
            </div>
            <div class="fly-list-badge">
              <!--<span class="layui-badge layui-bg-red">精帖</span>-->
            </div>
          </li>
          --%>
        </ul>
        <div style="text-align: center">
          <div class="laypage-main">
            <a href="jie/index.html" class="laypage-next">更多求解</a>
          </div>
        </div>

      </div>
    </div>
    <div class="layui-col-md4">

      <!-- <div class="fly-panel">
        <h3 class="fly-panel-title">温馨通道</h3>
        <ul class="fly-panel-main fly-list-static">
          <li>
            <a href="http://fly.layui.com/jie/4281/" target="_blank"> 帖子好 及 Gitee (码云) 仓库，欢迎Star</a>
          </li>
          <li>
            <a href="http://fly.layui.com/jie/5366/" target="_blank">
               帖子好问题的处理和实用干货集锦
            </a>
          </li>
          <li>
            <a href="http://fly.layui.com/jie/4281/" target="_blank"> 帖子好 及 Gitee (码云) 仓库，欢迎Star</a>
          </li>
          <li>
            <a href="http://fly.layui.com/jie/5366/" target="_blank">
               帖子好问题的处理和实用干货集锦
            </a>
          </li>
          <li>
            <a href="http://fly.layui.com/jie/4281/" target="_blank"> 帖子好 及 Gitee (码云) 仓库，欢迎Star</a>
          </li>
        </ul>
      </div> -->


      <div class="fly-panel fly-signin">
        <div class="fly-panel-title">
          签到
          <i class="fly-mid"></i> 
          <shiro:authenticated>
        	  <span class="fly-signin-days" id="signin-days">已连续签到<cite>16</cite>天</span>
          </shiro:authenticated>
        </div>
        <div class="fly-panel-main fly-signin-main">
          <div class="layui-btn layui-btn-danger " id="L_signin" title="连续签到可获得额外飞吻（5+连续签到天数）,连续签到天数最多提供15飞吻">今日签到</div>
          <span>可获得<cite>5</cite>飞吻</span>
          
          <!-- 已签到状态 --> 
          <!--
          <button class="layui-btn layui-btn-disabled">今日已签到</button>
          <span>获得了<cite>20</cite>飞吻</span>
          -->
        </div>
      </div>

      <div class="fly-panel fly-rank fly-rank-reply" id="LAY_replyRank">
        <h3 class="fly-panel-title">回贴榜</h3>
        <dl>
          <i class="layui-icon fly-loading layui-anim layui-anim-rotate layui-anim-loop">&#xe63d;</i>
          <dd></dd>
          <dd></dd>
          <dd></dd>
          <dd></dd>
          <%-- 
          <dd>
            <a href="user/home.html">
              <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
            </a>
          </dd> --%>
        </dl>
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

     <!--  <div class="fly-panel">
        <div class="fly-panel-title">
          这里可作为广告区域
        </div>
        <div class="fly-panel-main">
          <a href="http://layim.layui.com/?from=fly" target="_blank" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">LayIM 3.0 - layui 旗舰之作</a>
        </div>
      </div> 
      
      <div class="fly-panel fly-link">
        <h3 class="fly-panel-title">友情链接</h3>
        <dl class="fly-panel-main">
          <dd><a href="http://www.layui.com/" target="_blank">layui</a><dd>
          <dd><a href="http://layim.layui.com/" target="_blank">WebIM</a><dd>
          <dd><a href="http://layer.layui.com/" target="_blank">layer</a><dd>
          <dd><a href="http://www.layui.com/laydate/" target="_blank">layDate</a><dd>
          <dd><a href="mailto:xianxin@layui-inc.com?subject=%E7%94%B3%E8%AF%B7Fly%E7%A4%BE%E5%8C%BA%E5%8F%8B%E9%93%BE" class="fly-link">申请友链</a><dd>
        </dl>
      </div>-->

    </div>
  </div>
</div>

<div class="fly-footer">
  <p><a href="http://fly.layui.com/" target="_blank">禹霖社区</a> 2020 &copy; <a href="http://www.layui.com/" target="_blank">jiandan 出品</a></p>
</div>
 
<script src="/luntan/static/res/layui/layui.js"></script>
<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>
<script src="/luntan/static/res/pyl.js"></script>
<script>
layui.cache.page = 'user';
layui.cache.user = {
  username: '游客'
  ,uid: -1
  ,avatar: '/luntan/static/res/images/avatar/00.jpg'
  ,experience: 83
  ,sex: '男'
};
layui.config({
  version: "3.0.0"
  ,base: '/luntan/static/res/mods/' //这里实际使用时，建议改成绝对路径
}).extend({
  fly: 'index'
}).use('fly');
</script>

<!-- <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script> -->

</body>
</html>
<script type="text/javascript">
//
	window.onload = function(){
		$.ajax({
			url:'pyl/signInday.do',
			type:'post',
			dataType:'json',
			data:{},
			success:function(data){
				$("#L_signin").html(data.msg);
				$("#signin-days").children(":first").html(data.signintime);
				if(data.state==0){
					$("#L_signin").html(data.msg).addClass("layui-btn-disabled");
				}
			}
		});
		
	 }


	//点击签到
	$("#L_signin").click(function(){
		var signdays=$("#signin-days").children(":first").html();
		 if($("#L_signin").hasClass('layui-btn-disabled')){return;}
		$.ajax({
			url:'pyl/signIn.do',
			type:'post',
			dataType:'json',
			data:{"signdays":signdays},
			success:function(data){
				if(data.state==0){
					alert(data.msg);
					return ;
				}
				$("#L_signin").html(data.msg).addClass("layui-btn-disabled");
				$("#signin-days").children(":first").html(data.usigninday);
				var span=$("#L_signin").siblings("span").eq(0);
				$(span).empty().append("获得了<cite>"+data.score+"</cite>飞吻")
			}
		});
	
	
	});

/* //点击搜索
$("#sou").click(function(){
	var souword =$("#soucontent").val();
	if(souword==""){return;}
	window.location="pyl/souPosts.do?souword="+souword;


}); */


</script>
