<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>

    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span><a href="javascript:history.back(-1)">用户管理页面</a> >> 用户添加页面</span>
        </div>
        <input type="hidden" id="test" value="${user2.role.id}">
        <div class="providerAdd">
            <form id="userForm" name="userForm" method="post" action="${pageContext.request.contextPath}/user/update">
                <!--div的class 为error是验证错误，ok是验证成功-->

                <input type="hidden" value="${user2.id}" name="id">
                <div>
                    <label for="userCode">用户编码：</label>
                    <input type="text" readonly name="userCode"  id="userCode" value="${user2.userCode}" />
                    <!-- 放置提示信息 -->
                    <font color="red"></font>
                </div>
                <div>
                    <label for="userName">用户名称：</label>
                    <input type="text" name="userName" id="userName" value="${user2.userName}">
                    <font color="red"></font>
                </div>
                <div>
                    <label for="userPassword">用户密码：</label>
                    <input type="text" name="userPassword" id="userPassword" value="${user2.userPassword}">
                    <font color="red"></font>
                </div>
                <div>
                    <label >用户性别：</label>
                    <select name="gender" id="gender">
                        <option value="1" <c:if test="${user2.gender==1}"> selected="selected" </c:if>>男</option>
                        <option value="2" <c:if test="${user2.gender==2}"> selected="selected" </c:if>>女</option>
                    </select>
                </div>

                <div>
                    <label for="birthday">出生日期：</label>
                    <input type="text" Class="Wdate" id="birthday" onclick="WdatePicker();" name="birthday" value='<fmt:formatDate value="${user2.birthday}" pattern="yyyy-MM-dd"/>'>
					<font color="red" id="birthdayMsg"></font>
                </div>
                <div>
                    <label for="phone">用户电话：</label>
                    <input type="text" name="phone" id="phone" value="${user2.phone}">
                    <font color="red"></font>
                </div>
                <div>
                    <label for="address">用户地址：</label>
                    <input name="address" id="address"  value="${user2.address}">
                </div>
                <div>
                    <label >用户角色：</label>
                    <!-- 列出所有的角色分类 -->
                    <select name="role.id" id="queryUserRole">
                        <option value="${user2.role.id}">--${user2.role.roleName}--</option>
                    </select>
                    <font color="red"></font>
                </div>
                <div class="providerAddBtn">
                    <input type="button" id="add" value="保存" >
                    <input type="button" id="back" name="back" value="返回">
                </div>
            </form>
        </div>
    </div>
</section>

<script type="text/javascript">


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
                    if (role.id !=$("#test").val())
                    str+='<option  value="'+role.id+'">--'+role.roleName+'--</option>';
                }
                //追加
                $("#queryUserRole").append(str);
            }
        })

        $("#back").click(function () {
            location.href = "${pageContext.request.contextPath}/user/findAll";
        })

        var flag = false;
        var birthRex=/^(\d{4})(-)(\d{2})(-)(\d{2})$/;
        //生日验证
        $("#birthday").blur(function () {

            if (!birthRex.test($(this).val())) {
                $("#birthdayMsg").text("时间的格式为：xxxx-xx-xx的格式！");
            }else {
                $("#birthdayMsg").text("");
                flag = true;
            }
        })

        $("#add").click(function () {
            if (flag==true || $("#birthday").val()=="" || birthRex.test($("#birthday").val())){
                $("#userForm").submit();
            }
        })
    })
</script>
