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
	  <title>发表您的想法</title>
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
      <!--搜索-->
      <li class="layui-nav-item layui-hide-xs">
        <span class="fly-search"><i class="layui-icon"></i></span> 
      </li>
      
     
      
      <!-- 未登入的状态 -->
     
	<shiro:notAuthenticated> 
      <li class="layui-nav-item">
        <a class="iconfont icon-touxiang layui-hide-xs" href="user/login.html"></a>
      </li>
      <li class="layui-nav-item">
        <a href="user/login.html">登入</a>
      </li>
      <li class="layui-nav-item">
        <a href="user/reg.html">注册</a>
      </li>

    </shiro:notAuthenticated>
      
         <!-- 登入后的状态 -->
      <shiro:authenticated>
      <li class="layui-nav-item">
        <a class="fly-nav-avatar" href="/fly-3.0/html/user/home.html">
          <cite class="layui-hide-xs">贤心</cite>
          <i class="iconfont icon-renzheng layui-hide-xs" title="认证信息：layui 作者"></i>
         <!-- <i class="layui-badge fly-badge-vip layui-hide-xs">VIP3</i>-->
          <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg">
        </a>
        <dl class="layui-nav-child">
          <dd><a href="../user/set.html"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
          <dd><a href="../user/message.html"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
          <dd><a href="../user/home.html"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
          <hr style="margin: 5px 0;">
          <dd><a href="" style="text-align: center;">退出</a></dd>
        </dl>
      </li>
       </shiro:authenticated>
    </ul>
  </div>
</div>
<div class="layui-container fly-marginTop">
  <div class="fly-panel" pad20 style="padding-top: 5px;">
  <!-- 是否已经登录 -->
  	<shiro:notAuthenticated>
	    <div class="fly-none"><h2>没有权限，前先登录</h2>
	    	<hr/><a href="/luntan/static/html/user/login.jsp"><div class="layui-btn">登录</div></a>
	    </div>
    </shiro:notAuthenticated>
    
    <!-- 登录就有 -->
    <shiro:authenticated>
   	 <div class="layui-form layui-form-pane">
      <div class="layui-tab layui-tab-brief" lay-filter="user">
        <ul class="layui-tab-title">
          <li class="layui-this">发表新帖<!-- 编辑帖子 --></li>
        </ul>
        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
          <div class="layui-tab-item layui-show">
            <form  method="post">
              <div class="layui-row layui-col-space15 layui-form-item">
                <div class="layui-col-md3">
                  <label class="layui-form-label">所在专栏</label>
                  <div class="layui-input-block">
                    <select lay-verify="required" id="pyl_tpye" name="class" lay-filter="column"> 
                      <option></option> 
                      <c:forEach items="${smodule }" var="s">
                      		<option value="${s.smoduleId }">${s.smoduleName }</option>
                      </c:forEach>
                     <%--  <option value="0">提问</option> 
                      <option value="99">分享</option> 
                      <option value="100">讨论</option> 
                      <option value="168">公告</option>
                      <option value="169">动态</option>  --%>
                    </select>
                  </div>
                </div>
                <div class="layui-col-md9">
                  <label for="L_title" class="layui-form-label">标题</label>
                  <div class="layui-input-block">
                    <input type="text" id="L_title" name="title" required lay-verify="required" autocomplete="off" class="layui-input">
                    <!-- <input type="hidden" name="id" value="{{d.edit.id}}"> -->
                  </div>
                </div>
              </div>
             
              </div>
              <div class="layui-form-item layui-form-text">
                <div class="layui-input-block">
                  <textarea id="L_content" name="content" required lay-verify="required" placeholder="详细描述" class="layui-textarea fly-editor" style="height: 260px;"></textarea>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">悬赏飞吻</label>
                  <div class="layui-input-inline" style="width: 190px;">
                   <!--  <select name="experience">
                      <option value="20">20</option>
                      <option value="30">30</option>
                      <option value="50">50</option>
                      <option value="60">60</option>
                      <option value="80">80</option>
                    </select> -->
                    <input type="text" id="feiwen"  placeholder="量力而行呀" name="feiwen" autocomplete="off" class="layui-input" oninput = "value=value.replace(/[^\d]/g,'')">
                  </div>
                  <div class="layui-form-mid layui-word-aux">发表后无法更改飞吻</div>
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">人类验证</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="vercode" required lay-verify="required" placeholder="请回答后面的问题" autocomplete="off" class="layui-input" oninput= "value=value.replace(/[^\d]/g,'')">
                </div>
                <div class="layui-form-mid">
                  <span id="vercode_tips" style="color: #c00;"></span>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-btn" id="pyl_send">立即发布</div>
              </div>
            </form>
          </div>
        </div>
      </div>
   	 </div>
    </shiro:authenticated>
  </div>
</div>

<div class="fly-footer">
  <p><a href="" target="_blank">禹霖社区</a> 2020 &copy; <a href="/fly-3.0/html/index.html" target="_blank">jiandan 出品</a></p>
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
}).use('fly');
</script>

</body>
</html>
<script type="text/javascript">
	var score='${uScore}';
	
	(function(){yanzhengma()})();
	
	
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
	
	
	var pyl_flag_content=false;
	//文本域判断
	$("#L_content").blur(function(){
		if(!$("#L_content").val()==""){
			pyl_flag_content=true;
		}else{
			pyl_flag_content=false;
		}
	});
	
	
	
	
	
	
	
	
	//点击发表
	$("#pyl_send").click(function(){
		var flag=formjiance();
		//文本域的潘墩
		if(!pyl_flag_content){
			$("#L_content").css("border-color","red");
				layer.msg("将信息填写完整",{shift : 6,icon:2});
				setTimeout(function(){
					$("#L_content").css("border-color","#e2e2e2");
				},1350);
			return ;
		}
		if(flag){
			if(!pyl_flag_code){
				$('#L_vercode').css("border-color","red");
					layer.msg("验证码错误",{shift : 6,icon:2});
					setTimeout(function(){
						$('#L_vercode').css("border-color","#e2e2e2");
					},1000);
				return ;
			}
			//把查询到的积分进行对比、
			var feiwen=$("#feiwen").val();
			if(parseInt(feiwen)>score){
				$('#feiwen').css("border-color","red");
					layer.msg("飞吻余额不够支付",{shift : 6,icon:2});
					setTimeout(function(){
						$('#feiwen').css("border-color","#e2e2e2");
					},1000);
				
				return;
			}
		
			var content=$("#L_content").val();
			var type=$("#pyl_tpye").val();
			var title=$("#L_title").val();
			var typename=$("#pyl_tpye option:selected").text();
			$.ajax({
				url:'pyl/savePosts.do',
				type:'post',
				dataType:'json',
				data:{'content':content,'title':title,'type':type,'feiwen':feiwen,'typename':typename,"score":score},
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
		
		}
	});
	

</script>

