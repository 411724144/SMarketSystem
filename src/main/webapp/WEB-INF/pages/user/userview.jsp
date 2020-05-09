<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>
<div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span><a href="javascript:history.back(-1)">用户管理页面</a> >> 用户信息查看页面</span>
        </div>
        <div class="providerView">
            <p><strong>用户编号：</strong><span>${user2.userCode}</span></p>
            <p><strong>用户名称：</strong><span>${user2.userName}</span></p>
            <p><strong>用户性别：</strong>
            	<span>
            		 <c:if test="${user2.gender == 1}">男</c:if>
					 <c:if test="${user2.gender == 2}">女</c:if>
				</span>
			</p>
            <p>
                <strong>出生日期：</strong>
                <span>
                        <fmt:formatDate value="${user2.birthday}" pattern="yyyy年MM月dd日"></fmt:formatDate>
                </span>
            </p>
            <p><strong>用户电话：</strong><span>${user2.phone}</span></p>
            <p><strong>用户地址：</strong><span>${user2.address}</span></p>
            <p><strong>用户角色：</strong><span>${user2.role.roleName}</span></p>
			<div class="providerAddBtn">
            	<input type="button" id="back" name="back" value="返回" >
            </div>
        </div>
    </div>
</section>
<script>
    $(function () {
        $("#back").click(function () {
            location.href = "${pageContext.request.contextPath}/user/findAll";
        })
    })
</script>
<jsp:include page="/INC/common/foot.jsp"/>