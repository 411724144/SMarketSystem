<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>

    <div class="right">
            <div class="location">
                <strong>你现在所在的位置是:</strong>
                <span>密码修改页面</span>
            </div>
            <div class="providerAdd">
                <form id="userForm" name="userForm" method="post">
                    <input type="hidden" name="method" value="savepwd">
                    <!--div的class 为error是验证错误，ok是验证成功-->
                    <div class="info">${message}</div>
                    <div class="">
                        <label for="oldPassword">旧密码：</label>
                        <input type="password" name="oldpassword" id="oldpassword" value="">
						<font color="red" id="oldPasswordSpan"></font>
                    </div>
                    <div>
                        <label for="newPassword">新密码：</label>
                        <input type="password" name="newpassword" id="newpassword" value=""> 
						<font color="red"></font>
                    </div>
                    <div>
                        <label for="reNewPassword">确认新密码：</label>
                        <input type="password" name="rnewpassword" id="rnewpassword" value=""> 
						<font color="red" id="reNewPasswordSpan"></font>
                    </div>
                    <div class="providerAddBtn">
                        <!--<a href="#">保存</a>-->
                        <input type="button" name="save" id="save" value="保存" class="input-button">
                        <input type="button" id="back" name="back" value="返回">
                    </div>
                </form>
            </div>
        </div>
</section>
<script>
    $(function () {
        $("#back").click(function () {
            location.href = "${pageContext.request.contextPath}/user/findAll";
        })
        //失去焦点验证旧密码
        $("#oldpassword").blur(function () {
            $.ajax({
                url:"${pageContext.request.contextPath}/user/findById?id=${user.id}",
                type:"post",
                contentType:"json",
                dataType:"json",
                success:function (data) {
                    if (data.userPassword!=$("#oldpassword").val()){
                        $("#oldPasswordSpan").text("旧密码不一致！");
                    }else {
                        $("#oldPasswordSpan").text("√");
                    }
                }
            })
        })

        //验证密码是否一致
        $("#save").click(function () {
            if ($("#newpassword").val()==$("#rnewpassword").val()){
                location.href = "${pageContext.request.contextPath}/user/updatePwd?id=${user.id}&newPwd="+$("#rnewpassword").val();
            }else {
                $("#reNewPasswordSpan").text("前后密码不一致！");
            }
        })
    })
</script>