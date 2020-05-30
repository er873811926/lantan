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
	  <title>帐号设置</title>
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
      <li class="layui-hide-xs layui-this"><a href="">首页</a></li> 
      <c:forEach items="${smodule}" var="s">
               <li><a href="/luntan/static/html/jie/index.jsp?sid=${s.smoduleId}">${s.smoduleName }</a></li> 
      </c:forEach>
     <!--  <li><a href="/luntan/static/html/jie/index.jsp">提问</a></li> 
      <li><a href="/luntan/static/html/jie/index.jsp">分享<span class="layui-badge-dot"></span></a></li> 
      <li><a href="/luntan/static/html/jie/index.jsp">讨论</a></li> 
      <li><a href="/luntan/static/html/jie/index.jsp">公告</a></li> -->  
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li>
      
      <!-- 用户登入后显示 -->
       <shiro:authenticated>
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="/luntan/static/html/user/index.jsp">我发表的贴</a></li> 
	      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="/luntan/static/html/user/index.jsp#collection">我收藏的贴</a></li> 
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

<div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
     <li class="layui-nav-item">
      <a href="userSet/home.do">
        <i class="layui-icon">&#xe609;</i>
        我的主页
      </a>
    </li>
    <li class="layui-nav-item ">
      <a href="pyl/findMyPosts.do?state=0"><!-- pyl/findMyPosts.do?state=0 -->
        <i class="layui-icon">&#xe612;</i>
        用户中心
      </a>
    </li>
    <li class="layui-nav-item layui-this">
      <a href="Javascript:;">
        <i class="layui-icon">&#xe620;</i>
        基本设置
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="pyl/userMessage.do">
        <i class="layui-icon">&#xe611;</i>
        我的消息
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
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li class="layui-this" lay-id="info">我的资料</li>
        <li lay-id="avatar">头像</li>
        <li lay-id="pass">密码</li>
        <!--<li lay-id="bind">帐号绑定</li>-->
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
          <form method="post">
            <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">昵称</label>
              <div class="layui-input-inline">
                <input type="text" id="L_username" name="username" required lay-verify="required" autocomplete="off" value="${oneu.unickname}" class="layui-input">
              </div>
              <div class="layui-inline">
                <div class="layui-input-inline">
                <c:if test="${oneu.usex eq '男'}">
                  <input type="radio" name="sex" value="男" checked title="男">
                  <input type="radio" name="sex" value="女" title="女">
                </c:if>  
                <c:if test="${oneu.usex ne '男'}">
                  <input type="radio" name="sex" value="男"  title="男">
                  <input type="radio" name="sex" value="女" checked title="女">
                </c:if>  
                </div>
              </div>
            </div>
            <div class="layui-form-item">
              <label for="L_city" class="layui-form-label">城市</label>
              
              <div class="layui-input-inline">
                <input type="text" id="L_city" name="city"  autocomplete="off" value="${oneu.uaddress}" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item layui-form-text">
              <label for="L_sign" class="layui-form-label">签名</label>
              <div class="layui-input-block">
                <textarea placeholder="随便写些什么刷下存在感" id="L_sign"  name="sign" autocomplete="off" class="layui-textarea" style="height: 80px;">${oneu.umaxim}</textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <div id="updateUser" class="layui-btn" key="set-mine" >确认修改</div>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <div class="layui-form-item">
              <div class="avatar-add">
                <p>建议尺寸168*168，支持jpg、png、gif，最大不能超过50KB</p>
                <button type="button" id="selectphoto" class="layui-btn" >
                  <i class="layui-icon">&#xe67c;</i>上传头像
                </button>
                <input type="file" id="file"  
style="filter:alpha(opacity=0);opacity:0;width: 0;height: 0;"/> 
                <img id="zhanshi" src="data:image/jpeg;base64,${oneu.uphoto}">
                <span class="loading"></span>
              </div>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <form action="/user/repass" method="post">
              <div class="layui-form-item">
                <label for="L_nowpass" class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_nowpass" name="nowpass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="pass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="repass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div id="updatePass" class="layui-btn" key="set-mine">确认修改</div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="fly-footer">
  <p><a href="" target="_blank">禹霖社区</a> 2020 &copy; <a href="http://www.layui.com/" target="_blank">jiandan 出品</a></p>
 <%-- <p>
    <a href="http://fly.layui.com/jie/3147/" target="_blank">付费计划</a>
    <a href="http://www.layui.com/template/fly/" target="_blank">获取Fly社区模版</a>
    <a href="http://fly.layui.com/jie/2461/" target="_blank">微信公众号</a>
  </p>--%>
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
  version: "2.0.0"
  ,base: '/luntan/static/res/mods/'
}).extend({
  fly: 'index'
}).use('fly');
</script>
</body>
</html>

<script type="text/javascript">

	function myajax(seturl,setdata){
		var rurl=seturl;
		var rdata=setdata;
		$.ajax({
				url:rurl,
				type:'post',
				dataType:'json',
				data:rdata,
				success:function(data){
					if(data.state==1){
						location.reload(); 
						alert(data.msg);
					}
				}	
			});
	}
	
	
	$("#updateUser").click(function(){
		if(confirm("确认修改吗")){
			var unickname=$("#L_username").val();
			var usex=$("input[type='radio']:checked").val();
			var umaxim=$("#L_sign").val();
			var uaddress=$("#L_city").val();
			console.log(usex);
			console.log(umaxim);
			var content ={"unickname":unickname,"usex":usex,"umaxim":umaxim,"uaddress":uaddress};
			myajax("pyl/setUser.do",content);
		}
	});

//修改图片按钮
$("#selectphoto").click(function(){
	$("#file").trigger("click"); 

});

function selectFile(){ 
	$("#file").trigger("click"); 
} 

$("#file").change(function(){
			var size=$(this)[0].files[0].size;
			console.log(size);
			if(size>50000){alert("图片大于50K");return;}
			l($(this));
});

//修改头像获取ba64字符串
function l(evn){
	var name = $(evn)[0].files[0].name;//获取上传的文件名
	var file = $(evn)[0].files[0];
	if (window.FileReader) {
	var reader = new FileReader();
	reader.readAsDataURL(file);
	//监听文件读取结束后事件
	reader.onloadend = function (e) {
		$("#zhanshi").attr("src",e.target.result); //e.target.result就是最后的路径地址
		var uphotobs64=e.target.result;
		var content={"uphoto":uphotobs64};
		myajax("pyl/updatePhoto.do",content);
		
	};
	}
}


$("#updatePass").click(function(){
	var oldupass=$("#L_nowpass").val();
	var newupass=$("#L_pass").val();
	var reupass=$("#L_repass").val();

	if(oldupass==""||newupass==""||reupass==""){
		alert("信息填写完整");	
		return;
	}
	if(newupass.length>16||newupass.length<6){alert("密码长度不合格");return;}
	
	if(newupass==reupass){
		var content={"oldupass":oldupass,"newupass":newupass};
		myajax("pyl/updatePass.do",content);
	}
});

</script>
