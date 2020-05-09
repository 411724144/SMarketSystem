<%--
  Created by IntelliJ IDEA.
  User: 远远
  Date: 2020/4/23
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市订单管理系统</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<!--头部-->
<header class="publicHeader">
    <h1>超市订单管理系统</h1>
    <div class="publicHeaderR">
        <p><span>下午好！</span><span style="color: #fff21b">${user.userName}</span> , 欢迎你！</p>
        <a href="${pageContext.request.contextPath}/user/logout">退出</a>
    </div>
</header>
<!--时间-->
<section class="publicTime">
    <span id="time">2015年1月1日 11:11  星期一</span>
    <a href="#">温馨提示：为了能正常浏览，请使用高版本浏览器！（IE10+）</a>
</section>
<!--主体内容-->
<section class="publicMian ">
    <div class="left">
        <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
        <nav>
            <ul class="list">
                <li ><a href="${pageContext.request.contextPath }/bill/findAll">订单管理</a></li>
                <li><a href="${pageContext.request.contextPath }/jsp/provider.do?method=query">供应商管理</a></li>
                <li><a href="${pageContext.request.contextPath }/user/findAll">用户管理</a></li>
                <li><a href="${pageContext.request.contextPath }/user/toPwdModify">密码修改</a></li>
                <li><a href="${pageContext.request.contextPath }/user/logout">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <input type="hidden" id="path" name="path" value=""/>
    <input type="hidden" id="referer" name="referer" value="http://localhost/users/queryAll?pageNo=1"/>

    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span><a href="javascript:history.back(-1)">用户管理页面</a> >> 用户添加页面</span>
        </div>
        <div class="providerAdd">
            <form id="userForm" name="userForm" method="post" onsubmit="return validate()" action="${pageContext.request.contextPath}/user/addUser">

                <!--div的class 为error是验证错误，ok是验证成功-->
                <div>
                    <label for="userCode">用户编码：</label>
                    <input type="text" autofocus name="userCode" id="userCode" value="" required>
                    <!-- 放置提示信息 -->
                    <font color="red" id="userCodeMsg"></font>
                </div>
                <div>
                    <label for="userName">用户名称：</label>
                    <input type="text" name="userName" id="userName" value="" required>
                    <font color="red"></font>
                </div>
                <div>
                    <label for="userPassword">用户密码：</label>
                    <input type="password" name="userPassword" id="userPassword" value="" required>
                    <font color="red"></font>
                </div>
                <div>
                    <label for="ruserPassword">确认密码：</label>
                    <input type="password" name="ruserPassword" id="ruserPassword" value="" required>
                    <font color="red" id="ruserPasswordSpan"></font>
                </div>
                <div>
                    <label >用户性别：</label>
                    <select name="gender" id="gender">
                        <option value="1" selected="selected">男</option>
                        <option value="2">女</option>
                    </select>
                </div>
                <div>
                    <label for="birthday">出生日期：</label>
                    <input type="text" Class="Wdate" id="birthday" name="birthday" onclick="WdatePicker();" >
					<font color="red" id="birthdayMsg"></font>
                </div>
                <div>
                    <label for="phone">用户电话：</label>
                    <input type="text" name="phone" id="phone" value="">
                    <font color="red"></font>
                </div>
                <div>
                    <label for="address">用户地址：</label>
                    <input name="address" id="address"  value="">
                </div>
                <div>
                    <label >用户角色：</label>
                    <!-- 列出所有的角色分类 -->
                    <select name="role.id" id="queryUserRole">

                    </select>
                    <font color="red"></font>
                </div>
                <div class="providerAddBtn">
                    <input type="submit" name="add" id="add" value="保存" >
                    <input type="button" id="back" name="back" value="返回" >
                </div>
            </form>
        </div>
    </div>
</section>

<script type="text/javascript">

    $("#back").click(function () {
        location.href = "${pageContext.request.contextPath}/user/findAll";
    })

    //生日验证
    $("#birthday").blur(function () {
        var birthRex=/^(\d{4})(-)(\d{2})(-)(\d{2})$/;
        if (!birthRex.test($(this).val())) {
            $("#birthdayMsg").text("时间的格式为：xxxx-xx-xx的格式！");
            $("#add").attr("disabled","true")
        }else {
            $("#birthdayMsg").text("");
            $("#add").removeAttr("disabled");
        }
    })

    //用户编号验证
    $("#userCode").blur(function () {
        $.ajax({
            url:"${pageContext.request.contextPath}/user/findByUserCode",
            type:"get",
            data:"userCode="+$("#userCode").val(),
            dataType:"json",
            contentType:"json",
            success:function (data) {
                if (data=="1"){
                    $("#userCodeMsg").text("用户编号已存在！");
                    $("#add").attr("disabled","true")
                }else {
                    $("#userCodeMsg").text("");
                    $("#add").removeAttr("disabled");
                }
            }
        })
    })

    var  flag3 = false;
    //验证两次密码是否一致
    $("#ruserPassword").blur(function () {
        if ($(this).val().trim().length==0 || $(this).val()!=$("#userPassword").val()){
            $("#ruserPasswordSpan").text("两次输入的密码不一致!");
            $("#add").attr("disabled","true")
        }else {
            $("#ruserPasswordSpan").text("");
            $("#add").removeAttr("disabled");
        }
    })

    $(function(){
        $.ajax({
            type:"get",
            url:"${pageContext.request.contextPath}/role/findAll",
            dataType:"json",
            contentType:"json",
            success:function (data) {
                //遍历
                var  str="";
                for (var  role of data){
                    str+='<option value="'+role.id+'">--'+role.roleName+'--</option>';
                }
                //追加
                $("#queryUserRole").append(str);
            }
        })
    })
</script>
