<%@ page import="com.hwua.ssm.entity.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 我的电脑
  Date: 2018/11/5
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <title>Tree Actions - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/easyUI/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/easyUI/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/easyUI/demo/demo.css">
    <script type="text/javascript" src="${path}/static/easyUI/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/easyUI/jquery.easyui.min.js"></script>
</head>
<body>
<div class="easyui-panel" style="padding:5px">
    <ul id="tt" class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true"></ul>
</div>
</body>
</html>
