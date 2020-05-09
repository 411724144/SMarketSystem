<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<div class="right">
     <div class="location">
         <strong>你现在所在的位置是:</strong>
         <span><a href="javascript:history.back(-1)">订单管理页面</a> >> 信息查看</span>
     </div>
     <div class="providerView">
         <p><strong>订单编号：</strong><span>${bill.billCode}</span></p>
         <p><strong>商品名称：</strong><span>${bill.productName}</span></p>
         <p><strong>商品单位：</strong><span>${bill.productUnit}</span></p>
         <p><strong>商品数量：</strong><span>${bill.productCount}</span></p>
         <p><strong>总金额：</strong><span>${bill.totalPrice}</span></p>
         <p><strong>供应商：</strong><span>${bill.provider.proName}</span></p>
         <p><strong>是否付款：</strong>
         	<span>
			<c:if test="${bill.isPayment==1}">未付款</c:if>
			<c:if test="${bill.isPayment==2}">已付款</c:if>
			</span>
		</p>
		<div class="providerAddBtn">
         	<input type="button" id="back" name="back" value="返回" >
        </div>
     </div>
 </div>

</section>
<script>
    $(function () {
        $("#back").click(function () {
            location.href = "${pageContext.request.contextPath}/bill/findAll";
        })
    })
</script>
<jsp:include page="/INC/common/foot.jsp"/>