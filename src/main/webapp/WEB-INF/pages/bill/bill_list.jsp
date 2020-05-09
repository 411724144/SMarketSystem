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
				let pId = $("#provider_id").val();
				let str = "";
				$.each(data,function (i,e) {
					if (e.id==pId)
					str+="<option selected value='"+e.id+"'>"+e.proName+"</option>";
					str+="<option  value='"+e.id+"'>"+e.proName+"</option>";
				})
				$("#queryProviderId").append(str);
			}
		})
	})
</script>
<div class="right">
       <div class="location">
           <strong>你现在所在的位置是:</strong>
           <span>订单管理页面</span>
       </div>
       <div class="search">
       <form method="get" action="${pageContext.request.contextPath }/bill/findAll">
		   	<input id="provider_id" value="${provider_id}" type="hidden">
			<span>商品名称：</span>
			<input name="productName" type="text" value="${productName}">
			 
			<span>供应商：</span>
			<select name="provider_id" id="queryProviderId">
				   <option value="">--请选择--</option>
       		</select>
			 
			<span>是否付款：</span>
			<select name="isPayment">
				<option value="">--请选择--</option>
				<option value="1" <c:if test="${isPayment==1}">selected</c:if> >未付款</option>
				<option value="2" <c:if test="${isPayment==2}">selected</c:if>>已付款</option>
       		</select>
			
			 <input	value="查 询" type="submit" id="searchbutton">
			 <a href="${pageContext.request.contextPath }/bill/add">添加订单</a>
		</form>
       </div>
       <!--账单表格 样式和供应商公用-->
      <table class="providerTable" cellpadding="0" cellspacing="0">
          <tr class="firstTr">
              <th width="10%">订单编码</th>
              <th width="20%">商品名称</th>
              <th width="10%">供应商</th>
              <th width="10%">订单金额</th>
              <th width="10%">是否付款</th>
              <th width="10%">创建时间</th>
              <th width="30%">操作</th>
          </tr>
         	<c:forEach items="${pageBean.list}" var="bill">
				<tr>
					<td>
					<span>${bill.billCode}</span>
					</td>
					<td>
					<span>${bill.productName}</span>
					</td>
					<td>
					<span>${bill.provider.proName}</span>
					</td>
					<td>
					<span>${bill.totalPrice}</span>
					</td>
					<td>
					<span>
						<c:if test="${bill.isPayment==1}">未支付</c:if>
						<c:if test="${bill.isPayment==2}">已付款</c:if>
					</span>
					</td>
					<td>
					<span>
						<fmt:formatDate value="${bill.creationDate}" pattern="yyyy-MM-dd"></fmt:formatDate>
					</span>
					</td>
					<td>
					<span><a class="viewBill" href="${pageContext.request.contextPath}/bill/view?id=${bill.id}&type=view"><img src="${pageContext.request.contextPath }/images/read.png" alt="查看" title="查看"/></a></span>
					<span><a class="modifyBill" href="${pageContext.request.contextPath}/bill/view?id=${bill.id}&type=update"><img src="${pageContext.request.contextPath }/images/xiugai.png" alt="修改" title="修改"/></a></span>
					<span><a class="deleteBill" onclick="return confirm('真的删除吗？')" href="${pageContext.request.contextPath}/bill/delete?id=${bill.id}"><img src="${pageContext.request.contextPath }/images/schu.png" alt="删除" title="删除"/></a></span>
					</td>
				</tr>
			</c:forEach>
      </table>
	【当前第${pageBean.pageNum}页 / 共${pageBean.pages}页】
	<div class="pageNum">
		<ul>
			<c:if test="${pageBean.pageNum>1}">
			<li><a href="${pageContext.request.contextPath}/bill/findAll?pageNum=1&pageSize=${pageBean.pageSize}">首页</a></li>
			<li class="threeword"><a href="${pageContext.request.contextPath}/bill/findAll?pageNum=${pageBean.prePage}&pageSize=${pageBean.pageSize}&provider_id=${provider_id}&isPayment=${isPayment}">上一页</a></li>
			</c:if>
			<c:if test="${pageBean.pageNum<=1}">
			<li  class="threeword"><a class="btn disabled" href="javascript:;">首页</a></li>
			<li  class="threeword"><a class="btn disabled" href="javascript:;">上一页</a></li>
			</c:if>
			<c:forEach begin="${pageBean.navigateFirstPage}" end="${pageBean.navigateLastPage}" var="p">
			<c:if test="${pageBean.pageNum==p}">
			<li class="active"><a href="${pageContext.request.contextPath}/bill/findAll?pageNum=${p}&pageSize=${pageBean.pageSize}&provider_id=${provider_id}&isPayment=${isPayment}">${p}</a></li>
			</c:if>
			<c:if test="${pageBean.pageNum!=p}">
			<li><a href="${pageContext.request.contextPath}/bill/findAll?pageNum=${p}&pageSize=${pageBean.pageSize}&provider_id=${provider_id}&isPayment=${isPayment}">${p}</a></li>
			</c:if>
			</c:forEach>
			<c:choose>
			<c:when test="${pageBean.pageNum==pageBean.pages}">
			<li disabled class="threeword"><a class="btn disabled" href="javascript:;">下一页</a></li>
			<li disabled class="threeword"><a class="btn disabled" href="javascript:;">末页</a></li>
			</c:when>
			<c:otherwise>
			<li class="threeword"><a href="${pageContext.request.contextPath}/bill/findAll?pageNum=${pageBean.nextPage}&pageSize=${pageBean.pageSize}&provider_id=${provider_id}&isPayment=${isPayment}">下一页</a></li>
			<li class="threeword"><a href="${pageContext.request.contextPath}/bill/findAll?pageNum=${pageBean.pages}&pageSize=${pageBean.pageSize}&provider_id=${provider_id}&isPayment=${isPayment}">末页</a></li>
			</c:otherwise>
			</c:choose>
  </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeBi">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该订单吗？</p>
            <a href="#" id="yes">确定</a>
            <a href="#" id="no">取消</a>
        </div>
    </div>
</div>
<jsp:include page="/INC/common/foot.jsp"/>