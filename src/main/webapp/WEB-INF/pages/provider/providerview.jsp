<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>
<section>
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span><a href="javascript:history.back(-1)">供应商管理页面</a> >> 信息查看</span>
        </div>
        <div class="providerView">
            <p><strong>供应商编码：</strong><span>${provider.proCode}</span></p>
            <p><strong>供应商名称：</strong><span>${provider.proName}</span></p>
            <p><strong>联系人：</strong><span>${provider.proContact}</span></p>
            <p><strong>联系电话：</strong><span>${provider.proPhone}</span></p>
            <p><strong>传真：</strong><span>${provider.proFax}</span></p>
            <p><strong>描述：</strong><span>${provider.proDesc}</span></p>
			<div class="providerAddBtn">
            	<input type="button" id="back" name="back" value="返回" >
            </div>
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
