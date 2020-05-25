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
  <title>故障公告页</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-status-bar-style" content="black"> 
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="format-detection" content="telephone=no">
  <link rel="stylesheet" href="/luntan/static/res/layui/css/layui.css">
  <link rel="stylesheet" href="/luntan/static/res/css/global.css">
  <style>
  .notice{width: 600px; margin: 30px auto; padding: 30px 15px; border-top: 5px solid #009688; line-height: 30px;  text-align: center; font-size: 16px; font-weight: 300; background-color: #f2f2f2;}
  
  @media screen and (max-width: 750px) {
    html body{margin-top: 0;}
    .notice{width: auto; margin: 20px 15px; padding: 30px 0;}
  }
  </style>
</head>

<body>

<div class="fly-none" style="min-height: 0; padding: 0;">
  <i class="iconfont icon-tishilian"></i>
</div>

<div class="notice layui-text">
	非常抱歉，需要正确的身份<br> <span style="padding:0 5px;"></span>
	<hr/>
	<div class="layui-btn" onclick="window.history.back()">返回</div>
</div>

</body>

</html>
