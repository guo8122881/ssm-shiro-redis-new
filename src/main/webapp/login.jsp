<%--
  Created by IntelliJ IDEA.
  User: 我的电脑
  Date: 2018/10/31
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/view/commom.jsp" %>
<html>
<head>
    <title>登录界面</title>

    <link rel="stylesheet" href="${path}/static/css/bootstrap.css">
    <link href="${path}/static/iconfont/style.css" type="text/css" rel="stylesheet">



    <style>
        body{color:#fff; font-family:"微软雅黑"; font-size:14px;}
        .wrap1{position:absolute; top:0; right:0; bottom:0; left:0; margin:auto }/*把整个屏幕真正撑开--而且能自己实现居中*/
        .main_content{background:url(${path}/static/images/main_bg.png) repeat; margin-left:auto; margin-right:auto; text-align:left; float:none; border-radius:8px;}
        .form-group{position:relative;}
        .login_btn{display:block; background:#3872f6; color:#fff; font-size:15px; width:100%; line-height:50px; border-radius:3px; border:none; }
        .login_input{width:100%; border:1px solid #3872f6; border-radius:3px; line-height:40px; padding:2px 5px 2px 30px; background:none;}
        .icon_font{position:absolute; bottom:15px; left:10px; font-size:18px; color:#3872f6;}
        .font16{font-size:16px;}
        .mg-t20{margin-top:20px;}
        @media (min-width:200px){.pd-xs-20{padding:20px;}}
        @media (min-width:768px){.pd-sm-50{padding:50px;}}
        #grad {
            background: -webkit-linear-gradient(#4990c1, #52a3d2, #6186a3); /* Safari 5.1 - 6.0 */
            background: -o-linear-gradient(#4990c1, #52a3d2, #6186a3); /* Opera 11.1 - 12.0 */
            background: -moz-linear-gradient(#4990c1, #52a3d2, #6186a3); /* Firefox 3.6 - 15 */
            background: linear-gradient(#4990c1, #52a3d2, #6186a3); /* 标准的语法 */
        }
    </style>
    <script type="text/javascript" src="${path}/static/js/jquery-3.2.1.js"></script>
    <%-- <script type="text/javascript" src="${path}/static/js/jquery-3.2.1.min.js"></script>--%>
    <script type="text/javascript" src="${path}/static/js/jquery.cookie.js"></script>
    <script type="text/javascript">
        $(function(){
            var username=$.cookie("username");
            var password=$.cookie("password");
            var remember=$.cookie("remember");
            //alert(username+"-----"+password+"----"+remember);
            if(remember!=null){
                $("#username").val(username);
                $("#password").val(password);
                $("#remember").attr("checked","checked");
            }
        });

        function login() {
            var remember=$("#remember").is(":checked");
            var username = $("#username").val();
            var password = $("#password").val();
            if (username == "" || password == "") {
                alert("请填写用户名和密码");
                return;
            }

            $.ajax({
                url: "${path}/user/login",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    username: username,
                    password: password
                },
                success: function (result) {
                    console.log(result);
                    if (result.success) {
                        alert(result.info);
                        if(remember){
                            $.cookie("username",username,{expires:7});
                            $.cookie("password",password,{expires:7});
                            $.cookie("remember",remember,{expires:7});
                        }else{
                            $.cookie("username",null);
                            $.cookie("password",null);
                            $.cookie("remember",null);
                        }
                        window.location.href = "${path}/user/tomain";
                    } else {
                        alert(result.info);
                    }
                }
            });

        }

    </script>

</head>

<body style="background:url(${path}/static/images/bg.jpg) no-repeat;">

<div class="container wrap1" style="height:450px;">
    <h2 class="mg-b20 text-center">某某公司登录页面</h2>
    <div class="col-sm-8 col-md-5 center-auto pd-sm-50 pd-xs-20 main_content">
        <p class="text-center font16">用户登录</p>
        <form>
            <div class="form-group mg-t20">
                <i class="icon-user icon_font"></i>
                <input type="text" class="login_input" id="username" placeholder="请输入用户名" />
            </div>
            <div class="form-group mg-t20">
                <i class="icon-lock icon_font"></i>
                <input type="password" class="login_input" id="password" placeholder="请输入密码" />
            </div>
            <div class="checkbox mg-b25">
                <label>
                    <input type="checkbox"  id="remember"/>记住我的登录信息
                </label>
            </div>
            <button class="login_btn" type="button" onclick="login()">登 录</button>
        </form>
    </div><!--row end-->
</div><!--container end-->
<div style="text-align:center;">
</div>
</body>
</html>
