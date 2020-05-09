<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>
<div class="right">
    <div class="location">
        <strong>你现在所在的位置是:</strong>
        <span><a href="javascript:history.back(-1)">供应商管理页面</a> >> 供应商修改页面</span>
    </div>
    <div class="providerAdd">
        <form id="providerForm" name="providerForm" method="post" action="${pageContext.request.contextPath }/provider/update">
            <input type="hidden" name="id" value="${provider.id}">

            <!--div的class 为error是验证错误，ok是验证成功-->
            <div class="">
                <label for="proCode">供应商编码：</label>
                <input type="text" name="proCode" id="proCode" value="${provider.proCode}">
                <!-- 放置提示信息 -->
                <font color="red"></font>
            </div>
            <div>
                <label for="proName">供应商名称：</label>
                <input type="text" name="proName" id="proName" value="${provider.proCode}">
                <font color="red"></font>
            </div>
            <div>
                <label for="proContact">联系人：</label>
                <input type="text" name="proContact" id="proContact" value="${provider.proContact}">
                <font color="red"></font>

            </div>
            <div>
                <label for="phone">联系电话：</label>
                <input type="text" name="proPhone" id="phone" value="${provider.proPhone}">
                <font color="red"></font>
            </div>
            <div>
                <label for="address">联系地址：</label>
                <input type="text" name="proAddress" id="address" value="${provider.proAddress}">
            </div>
            <div>
                <label for="proFax">传真：</label>
                <input type="text" name="proFax" id="proFax" value="${provider.proFax}">
            </div>
            <div>
                <label for="proDesc">描述：</label>
                <input type="text" name="proDesc" id="proDesc" value="${provider.proDesc}">
            </div>
            <div class="providerAddBtn">
                <input type="submit" name="add" id="add" value="保存">
                <input type="button" id="back" name="back" value="返回" >
            </div>
        </form>
    </div>
</div>
</section>
<script>
    $(function () {
        $("#back").click(function () {
            location.href = "${pageContext.request.contextPath}/provider/findAllByPage";
        })
    })
</script>
<jsp:include page="/INC/common/foot.jsp"/>