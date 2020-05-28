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
	  <title>${posts.postsTitle}</title>
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
          <cite class="layui-hide-xs">上单</cite>
          <i class="iconfont icon-renzheng layui-hide-xs" title="认证信息：layui 作者"></i>
          <img src="/luntan/static/res/images/userPhoto.png">
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
      </li>
    </ul>
  </div>
</div>

<div class="layui-hide-xs">
  <div class="fly-panel fly-column">
    <div class="layui-container">
      <ul class="layui-clear">
	    <li class="layui-hide-xs layui-this"><a href="javascript:;">首页</a></li> 
	    <li><a href="jie/index.html">提问</a></li> 
	    <li><a href="jie/index.html">分享<span class="layui-badge-dot"></span></a></li> 
	    <li><a href="jie/index.html">讨论</a></li> 
	    <li><a href="jie/index.html">公告</a></li> 
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li> 
        
        <!-- 用户登入后显示 -->
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="../user/index.html">我发表的贴</a></li> 
        <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="../user/index.html#collection">我收藏的贴</a></li> 
      </ul> 
      
      <div class="fly-column-right layui-hide-xs"> 
        <span class="fly-search"><i class="layui-icon"></i></span> 
        <a href="add.html" class="layui-btn">发表新帖</a> 
      </div> 
      <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;"> 
        <a href="add.html" class="layui-btn">发表新帖</a> 
      </div> 
    </div>
  </div>
</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1>${posts.postsTitle}</h1>
        <div class="fly-detail-info">
          <span class="layui-badge layui-bg-green fly-detail-column">${posts.smoduleName}</span>
          <c:if test="${posts.top eq 1}">
          	<span class="layui-badge layui-bg-black">置顶</span>
          </c:if>
          <c:if test="${posts.hot eq 1}">
         	 <span class="layui-badge layui-bg-red">精帖</span>
          </c:if>
          
          <shiro:hasRole name="admin">
	          <div class="fly-admin-box" data-id="123">
	            <span class="layui-btn layui-btn-xs jie-admin" type="">删除</span>
	            
	            <c:if test="${posts.top eq 0}">
	            	<span class="layui-btn layui-btn-xs jie-admin" type="" field="" rank="1">置顶</span> 
	            </c:if>
	            <c:if test="${posts.top eq 1}">
	             <span class="layui-btn layui-btn-xs jie-admin" type="" field="" rank="0" style="background-color:#ccc;">取消置顶</span>
	            </c:if>
	            <c:if test="${posts.hot eq 0}">
	            	<span class="layui-btn layui-btn-xs jie-admin" type="" field="" rank="1">加精</span> 
	            </c:if>
	            <c:if test="${posts.hot eq 1}">
	           		 <span class="layui-btn layui-btn-xs jie-admin" type="" field="" rank="0" style="background-color:#ccc;">取消加精</span>
	            </c:if>
	          </div>
         </shiro:hasRole>
          <span class="fly-list-nums"> 
            <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i>${posts.replyNum}</a>
            <i class="iconfont" title="人气">&#xe60b;</i> ${posts.pageView}
          </span>
        </div>
        <div class="detail-about">
          <a class="fly-avatar" href="/luntan/userSet/home.do?uemail=${posts.uemail}">
            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt="贤心">
          </a>
          <div class="fly-detail-user">
            <a href="../user/home.html" class="fly-link">
              <cite>贤心</cite>
            </a>
            <span>发帖时间:${posts.uptime}</span>
          </div>
          <div class="detail-hits" id="LAY_jieAdmin" data-id="123">
            <span style="padding-right: 10px; color: #FF7200">悬赏：${posts.reward}飞吻</span>  
          </div>
        </div>
        <div class="detail-body photos">
        	${postsc.content}
         <!--  <p>
            该模版由 你的帖子也写得也太好了（11）倾情提供，。阿克加好友的闪光点回复可见光。
          </p>
          <p>更新日志：</p>
<pre>
# afsadfasdf
* 采用 java
* 全面同步最新的 风格，各种细节得到大幅优化
* 更友好的响应式适配能力
</pre>
          
          下载<hr>
          <p>
            官网：<a href="http://www.layui.com/template/fly/" target="_blank">www.sdfsadf.com/</a><br>
            推荐：<a href="https://gitee.com/sentsin/fly/" target="_blank">www.dasdgfsdfg.com</a><br>
            二图：<a href="https://github.com/layui/fly" target="_blank">www.dasfghsiudfg.com</a>
          </p>
          封面<hr>
          <p>
            <img src="../../res/images/fly.jpg" alt="Fly社区">
          </p>-->
        </div> 
      </div>
	<div class="layui-form layui-form-pane">
          <form action="/jie/reply/" method="post">
            <div class="layui-form-item layui-form-text">
              <a name="comment"></a>
              <div class="layui-input-block">
                <textarea id="L_content" name="content" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <input type="hidden" name="jid" value="123">
              <div class="layui-btn" id="pyl_reply" type="submitReply">提交回复</div>
            </div>
          </form>
     </div>
      <div class="fly-panel detail-box" id="flyReply">
        <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>回帖</legend>
        </fieldset>
        
        <!-- 放置置顶的 -->
		<ul class="jieda" id="jieda">
        <c:set var="flag" value="0"></c:set>
        <c:forEach items="${listrtop}" var="top" varStatus="vs">        	
        	<li data-id="111" class="jieda-daan" style="border-bottom: 1px solid black;">
            <a name="item-1111111111"></a>
            <div class="detail-about detail-about-reply">
              <a class="fly-avatar" href="/luntan/userSet/home.do?uemail=${top.uemail}">
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt=" ">
              </a>
              <div class="fly-detail-user">
                <a href="/luntan/userSet/home.do?uemail=${top.uemail}" class="fly-link">
                  <cite>${top.unickname}</cite>
                </a>
              </div>

              <div class="detail-hits">
                <span>${top.replyTime}</span>
              </div>
			  <c:if test="${top.top eq 1}">
               <i class="iconfont icon-caina" title="优秀答案"></i>
              </c:if>
            </div>
            <div class="detail-body jieda-body photos">
              <p>${top.replyContent}</p>
            </div>
            <div class="jieda-reply">
              <span class="jieda-zan zanok" type="zan">
                <i class="iconfont icon-zan"></i>
                <em>${top.likes}</em>
              </span>
              <span type="reply">
                <i class="iconfont icon-svgmoban53"></i>
                回复
              </span>
              <div class="jieda-admin">
                <c:if test="${delete eq 1}">
                 <span class="deleteReply" reemail="${top.uemail}" time="${top.replyTime}" type="deleteReply" >删除</span>
              	</c:if>
              	<c:if test="${delete ne 1}">
              		<shiro:hasRole name="admin">
              		<span class="deleteReply" reemail="${top.uemail}" time="${top.replyTime}" type="deleteReply">删除</span>
              		</shiro:hasRole>
              	</c:if>
                <%-- <c:if test="${top.top eq 0}">
                 <c:if test="${delete eq 1}">
                 <span class="deleteReply" time="${top.replyTime}" type="deleteReply" reeamil="${top.uemail}">删除</span>
                 </c:if>
                </c:if> --%>
              </div>
            </div>
          </li>
        
        </c:forEach>
        </ul>
        
        <ul class="jieda" id="jieda">
        <c:set var="flag" value="0"></c:set>
        <c:forEach items="${listr}" var="r" varStatus="vs">
        	<c:if test="${vs.index eq 0}">
        	 <c:set var="flag" value="1"></c:set>
        	</c:if>
        	<li data-id="111" class="jieda-daan" style="border-bottom: 1px solid black;">
            <a name="item-1111111111"></a>
            <div class="detail-about detail-about-reply">
              <a class="fly-avatar" href="/luntan/userSet/home.do?uemail=${r.uemail}">
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt=" ">
              </a>
              <div class="fly-detail-user">
                <a href="/luntan/userSet/home.do?uemail=${r.uemail}" class="fly-link">
                  <cite>${r.unickname}</cite>
                </a>
              </div>

              <div class="detail-hits">
                <span>${r.replyTime}</span>
              </div>
			  <c:if test="${r.top eq 1}">
               <i class="iconfont icon-caina" title="优秀答案"></i>
              </c:if>
            </div>
            <div class="detail-body jieda-body photos">
              <p>${r.replyContent}</p>
            </div>
            <div class="jieda-reply">
              <span class="jieda-zan zanok" type="zan">
                <i class="iconfont icon-zan"></i>
                <em>${r.likes}</em>
              </span>
              <span type="reply">
                <i class="iconfont icon-svgmoban53"></i>
                回复
              </span>
              <div class="jieda-admin">
              	<c:if test="${delete eq 1}">
                 <span class="deleteReply" reemail="${r.uemail}" time="${r.replyTime}" type="deleteReply" >删除</span>
              	</c:if>
              	<c:if test="${delete ne 1}">
              		<shiro:hasRole name="admin">
              		<span class="deleteReply" reemail="${r.uemail}"  time="${r.replyTime}" type="deleteReply" >删除</span>
              		</shiro:hasRole>
              	</c:if>
                <c:if test="${r.top eq 0}">
                 <c:if test="${delete eq 1}">
                 <span class="jieda-accept" time="${r.replyTime}" type="accept" title="第一个被采纳的人才有赏吻">采纳</span>
                 </c:if>
                </c:if>
              </div>
            </div>
          </li>
        
        </c:forEach>
        
          <%-- <li data-id="111" class="jieda-daan">
            <a name="item-1111111111"></a>
            <div class="detail-about detail-about-reply">
              <a class="fly-avatar" href="">
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt=" ">
              </a>
              <div class="fly-detail-user">
                <a href="" class="fly-link">
                  <cite>贤心</cite>
                  <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                  <!--<i class="layui-badge fly-badge-vip">VIP3</i>   -->           
                </a>
                
                <span>(楼主)</span>
                <!--
                <span style="color:#5FB878">(管理员)</span>
                <span style="color:#FF9E3F">（社区之光）</span>
                <span style="color:#999">（该号已被封）</span>
                -->
              </div>

              <div class="detail-hits">
                <span>2017-11-30</span>
              </div>

              <i class="iconfont icon-caina" title="最佳答案"></i>
            </div>
            <div class="detail-body jieda-body photos">
              <p>香菇那个蓝瘦，这是一条被采纳的回帖</p>
            </div>
            <div class="jieda-reply">
              <span class="jieda-zan zanok" type="zan">
                <i class="iconfont icon-zan"></i>
                <em>66</em>
              </span>
              <span type="reply">
                <i class="iconfont icon-svgmoban53"></i>
                回复
              </span>
              <div class="jieda-admin">
                <!--<span type="edit">编辑</span>-->
                <span type="del">删除</span>
                <!-- <span class="jieda-accept" type="accept">采纳</span> -->
              </div>
            </div>
          </li>
          
          <li data-id="111">
            <a name="item-1111111111"></a>
            <div class="detail-about detail-about-reply">
              <a class="fly-avatar" href="">
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt=" ">
              </a>
              <div class="fly-detail-user">
                <a href="" class="fly-link">
                  <cite>贤心</cite>       
                </a>
              </div>
              <div class="detail-hits">
                <span>2017-11-30</span>
              </div>
            </div>
            <div class="detail-body jieda-body photos">
              <p>蓝瘦那个香菇，这是一条没被采纳的回帖</p>
            </div>
            <div class="jieda-reply">
              <span class="jieda-zan" type="zan">
                <i class="iconfont icon-zan"></i>
                <em>0</em>
              </span>
              <span type="reply">
                <i class="iconfont icon-svgmoban53"></i>
                回复
              </span>
              <div class="jieda-admin">
                <!--<span type="edit">编辑</span>-->
                <span type="del">删除</span>
                <span class="jieda-accept" type="accept">采纳</span>
              </div>
            </div>
          </li>
           --%>
           
          <!-- 无数据时 -->
          <c:if test="${flag eq 0}">
           <li class="fly-none">消灭零回复</li>
          </c:if>
        </ul>
        
        <!-- <div class="layui-form layui-form-pane">
          <form action="/jie/reply/" method="post">
            <div class="layui-form-item layui-form-text">
              <a name="comment"></a>
              <div class="layui-input-block">
                <textarea id="L_content" name="content" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <input type="hidden" name="jid" value="123">
              <div class="layui-btn" id="pyl_reply" type="submitReply">提交回复</div>
            </div>
          </form>
        </div> -->
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
      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">最近热议</dt>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>
        <dd>
          <a href="">你的帖子也写得也太好了</a>
          <span><i class="iconfont icon-pinglun1"></i> 16</span>
        </dd>

        <!-- 无数据时 -->
        <!--
        <div class="fly-none">没有相关数据</div>
        -->
      </dl>

      <div class="fly-panel">
        <div class="fly-panel-title">
          这里可作为广告区域
        </div>
        <div class="fly-panel-main">
          <a href="http://layim.layui.com/?from=fly" target="_blank" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">LayIM 3.0 - layui 旗舰之作</a>
        </div>
      </div>

      <div class="fly-panel" style="padding: 20px 0; text-align: center;">
        <!-- <img src="../../res/images/weixin.jpg" style="max-width: 100%;" alt="layui"> -->
        <p style="position: relative; color: #666;">微信扫码</p>
      </div>

    </div>
  </div>
</div>

<div class="fly-footer">
  <p><a href="http://fly.layui.com/" target="_blank">禹霖社区</a> 2020 &copy; <a href="" target="_blank">yulin 出品</a></p>
</div>

<script src="/luntan/static/res/layui/layui.js"></script>
<script src="/luntan/static/res/layui/jquery-1.8.3.min.js"></script>
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
}).use(['fly', 'face'], function(){
  var $ = layui.$
  ,fly = layui.fly;
  //如果你是采用模版自带的编辑器，你需要开启以下语句来解析。
  /*
  $('.detail-body').each(function(){
    var othis = $(this), html = othis.html();
    othis.html(fly.content(html));
  });
  */
});
</script>
</body>
</html>
<script type="text/javascript">
	var postsTitle="${posts.postsTitle}";
	var smoduleName="${posts.smoduleName}";
	var unickname="${sessionScope.currentNickName}";
	var postsNo="${posts.postsNo}";
	var postsuemali="${posts.uemail}";
	var pageNo="${pageNo}";
	var pageMax="${pageMax}";
	
	$("#pyl_reply").click(function(){
		if(unickname==null||unickname==""){alert("请先登录");return;}
		if($("#L_content").val()==""){
			$('#L_content').css("border-color","red");
			setTimeout(function(){
				$('#L_content').css("border-color","#e2e2e2");
			},1000);
			return;
		}
		var content=$('#L_content').val();
		$('#L_content').val("");
		var data={'content':content,'postsTitle':postsTitle,'type':'submitReply','smoduleName':smoduleName,'unickname':unickname,'postsNo':postsNo};
		myajax('pyl/replyCaoZuo.do',data);
	})
	




	function myajax(seturl,setdata){
		var rurl=seturl;
		var rdata=setdata;
		$.ajax({
				url:rurl,
				type:'post',
				dataType:'json',
				data:rdata,
				success:function(data){
					if(data.state==0){
						alert("操作失败");
					}
					
					if(data.state==1){
						location.reload(); 
						//$("#jieda li").eq(0).before('<li data-id="111" class="jieda-daan"><a name="item-1111111111"></a><div class="detail-about detail-about-reply"><a class="fly-avatar" href="/luntan/userSet/home.do?uemail='+data.uemail+'}"><img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" alt=""></a><div class="fly-detail-user"><a href="/luntan/userSet/home.do?uemail="'+data.uemail+'" class="fly-link"><cite>'+unickname+'</cite></a></div><div class="detail-hits"><span>'+data.replyTime+'</span></div></div><div class="detail-body jieda-body photos"><p>'+data.content+'</p></div><div class="jieda-reply"><span class="jieda-zan zanok" type="zan"><i class="iconfont icon-zan"></i><em>0</em></span><span type="reply"><i class="iconfont icon-svgmoban53"></i>回复</span><div class="jieda-admin"><span type="del">删除</span><c:if test="${r.top eq 0}"><span class="jieda-accept" type="accept" title="第一个被采纳的人才有赏吻">采纳</span></c:if></div></div></li>'); 
					}
					if(data.state==2){
						location.reload(); 
					}
				},	
			});
	}

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



//删除回复
$(".deleteReply").each(function(i){
	$(".deleteReply").eq(i).click(function(){
	if(confirm("你确定删除")){
		var replyemail= $(this).attr("reemail");
		console.log(replyemail);
		var type= $(this).attr("type");
		var replyTime= $(this).attr("time");
		var data1={"postsNo":postsNo,"uemail":replyemail,"type":type,"replyTime":replyTime};
		myajax('pyl/replyCaoZuo.do',data1);
	}
});
});
/* $(".deleteReply").click(function(){
	if(confirm("你确定删除")){
		var replyemail= $(".deleteReply").attr("email");
		var type= $(".deleteReply").attr("type");
		var replyTime= $(".deleteReply").attr("time");
		var data1={"postsNo":postsNo,"uemail":replyemail,"type":type,"replyTime":replyTime};
		myajax('pyl/replyCaoZuo.do',data1);
	}

}); */





</script>


