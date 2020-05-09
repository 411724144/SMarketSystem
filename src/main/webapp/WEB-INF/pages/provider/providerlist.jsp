<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
	layui.use('upload', function(){
		var upload = layui.upload;
		//执行实例
		var uploadInst = upload.render({
			elem: '#test1' //绑定元素
			,url: '${pageContext.request.contextPath}/poi/importExcel' //上传接口
			,accept:"file"
			,done: function(res){
				//上传完毕回调
				if (res.code==0){
					location.href = "${pageContext.request.contextPath}/provider/findAllByPage";
				}
			}
			,error: function(){
				//请求异常回调
			}
		});
	});
</script>
<div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>供应商管理页面</span>
        </div>
        <div class="search">
        	<form method="get" action="${pageContext.request.contextPath }/provider/findAllByPage">
				<input name="method" value="query" type="hidden">
				<span>供应商编码：</span>
				<input name="proCode" type="text" value="${proCode}">
				
				<span>供应商名称：</span>
				<input name="proName" type="text" value="${proName}">
				
				<input value="查 询" type="submit" id="searchbutton">
				<button type="button" class="layui-btn" id="test1">
					<i class="layui-icon">&#xe67c;</i>导入Excel
				</button>
				<a  style="margin: 5px;background-color:grey" href="${pageContext.request.contextPath }/poi/printExcel">导出Excel</a>
				<a style="margin: 5px" href="${pageContext.request.contextPath }/provider/add">添加供应商</a>
			</form>
        </div>
        <!--供应商操作表格-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">供应商编码</th>
                <th width="20%">供应商名称</th>
                <th width="10%">联系人</th>
                <th width="10%">联系电话</th>
                <th width="10%">传真</th>
                <th width="10%">创建时间</th>
                <th width="30%">操作</th>
            </tr>
          		<c:forEach items="${pageBean.list}" var="provider">
					<tr>
						<td>
							<span>${provider.proCode}</span>
						</td>
						<td>
							<span>${provider.proName}</span>
						</td>
						<td>
							<span>${provider.proContact}</span>
						</td>
						<td>
							<span>${provider.proPhone}</span>
						</td>
						<td>
							<span>${provider.proFax}</span>
						</td>
						<td>
					<span>
					<fmt:formatDate value="${provider.creationDate}" pattern="yyyy-MM-dd"/>
					</span>
						</td>
						<td>
							<span><a class="viewProvider" href="${pageContext.request.contextPath}/provider/check?id=${provider.id}" proid=${provider.id } proname=${provider.proName }><img src="${pageContext.request.contextPath }/images/read.png" alt="查看" title="查看"/></a></span>
							<span><a class="modifyProvider" href="${pageContext.request.contextPath}/provider/update?id=${provider.id}" proid=${provider.id } proname=${provider.proName }><img src="${pageContext.request.contextPath }/images/xiugai.png" alt="修改" title="修改"/></a></span>
							<span><a class="deleteProvider" href="${pageContext.request.contextPath}/provider/delete?id=${provider.id}" onclick="return confirm('真的删除吗？')" proid=${provider.id } proname=${provider.proName }><img src="${pageContext.request.contextPath }/images/schu.png" alt="删除" title="删除"/></a></span>
						</td>
					</tr>
				</c:forEach>
        </table>
	【当前第${pageBean.pageNum}页 / 共${pageBean.pages}页】
	<div class="pageNum">
		<ul>
			<c:if test="${pageBean.pageNum>1}">
				<li><a href="${pageContext.request.contextPath}/provider/findAllByPage?pageNum=1&pageSize=${pageBean.pageSize}&proCode=${proCode}&proName=${proName}">首页</a></li>
				<li class="threeword"><a href="${pageContext.request.contextPath}/provider/findAllByPage?pageNum=${pageBean.prePage}&pageSize=${pageBean.pageSize}&proCode=${proCode}&proName=${proName}">上一页</a></li>
			</c:if>
			<c:if test="${pageBean.pageNum<=1}">
				<li  class="threeword"><a class="btn disabled" href="javascript:;">首页</a></li>
				<li  class="threeword"><a class="btn disabled" href="javascript:;">上一页</a></li>
			</c:if>
			<c:forEach begin="${pageBean.navigateFirstPage}" end="${pageBean.navigateLastPage}" var="p">
				<c:if test="${pageBean.pageNum==p}">
					<li class="active"><a href="${pageContext.request.contextPath}/provider/findAllByPage?pageNum=${p}&pageSize=${pageBean.pageSize}&proCode=${proCode}&proName=${proName}">${p}</a></li>
				</c:if>
				<c:if test="${pageBean.pageNum!=p}">
					<li><a href="${pageContext.request.contextPath}/provider/findAllByPage?pageNum=${p}&pageSize=${pageBean.pageSize}&proCode=${proCode}&proName=${proName}">${p}</a></li>
				</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${pageBean.pageNum==pageBean.pages}">
					<li disabled class="threeword"><a class="btn disabled" href="javascript:;">下一页</a></li>
					<li disabled class="threeword"><a class="btn disabled" href="javascript:;">末页</a></li>
				</c:when>
				<c:otherwise>
					<li class="threeword"><a href="${pageContext.request.contextPath}/provider/findAllByPage?pageNum=${pageBean.nextPage}&pageSize=${pageBean.pageSize}&proCode=${proCode}&proName=${proName}">下一页</a></li>
					<li class="threeword"><a href="${pageContext.request.contextPath}/provider/findAllByPage?pageNum=${pageBean.pages}&pageSize=${pageBean.pageSize}&proCode=${proCode}&proName=${proName}">末页</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
    </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeProv">
   <div class="removerChid">
       <h2>提示</h2>
       <div class="removeMain" >
           <p>你确定要删除该供应商吗？</p>
           <a href="#" id="yes">确定</a>
           <a href="#" id="no">取消</a>
       </div>
   </div>
</div>
<jsp:include page="/INC/common/foot.jsp"/>