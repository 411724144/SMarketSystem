<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script>
    $(function () {
        $.ajax({
            url:"${pageContext.request.contextPath}/provider/findAllProvider",
            type:"get",
            dataType:"json",
            success:function (data) {
                let str = "";
                $.each(data,function (i,e) {
                    str+="<option  value='"+e.id+"'>"+e.proName+"</option>";
                })
                $("#providerId").append(str);
            }
        })
    })
</script>
<div class="right">
     <div class="location">
         <strong>你现在所在的位置是:</strong>
         <span><a href="javascript:history.back(-1)">订单管理页面</a> >> 订单添加页面</span>
     </div>
     <div class="providerAdd">
         <form id="billForm" name="billForm" method="post" action="${pageContext.request.contextPath }/bill/add">
             <!--div的class 为error是验证错误，ok是验证成功-->
             <input type="hidden" name="method" value="add">
             <div class="">
                 <label for="billCode">订单编码：</label>
                 <input type="text" name="billCode" class="text" id="billCode" value=""> 
				 <!-- 放置提示信息 -->
				 <font color="red"></font>
             </div>
             <div>
                 <label for="productName">商品名称：</label>
                 <input type="text" name="productName" id="productName" value=""> 
				 <font color="red"></font>
             </div>
             <div>
                 <label for="productUnit">商品单位：</label>
                 <input type="text" name="productUnit" id="productUnit" value=""> 
				 <font color="red"></font>
             </div>
             <div>
                 <label for="productDesc">描述：</label>
                 <input type="text" name="productDesc" id="productDesc" value="">
                 <font color="red"></font>
             </div>
             <div>
                 <label for="productCount">商品数量：</label>
                 <input type="text" name="productCount" id="productCount" value=""> 
				 <font color="red"></font>
             </div>
             <div>
                 <label for="totalPrice">总金额：</label>
                 <input type="text" name="totalPrice" id="totalPrice" value=""> 
				 <font color="red"></font>
             </div>
             <div>
                 <label >供应商：</label>
                 <select name="provider.id" id="providerId">
		         </select>
				 <font color="red"></font>
             </div>
             <div>
                 <label >是否付款：</label>
                 <input type="radio" name="isPayment" value="1" checked="checked">未付款
				 <input type="radio" name="isPayment" value="2" >已付款
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
            location.href = "${pageContext.request.contextPath}/bill/findAll";
        })
    })
</script>
<jsp:include page="/INC/common/foot.jsp"/>