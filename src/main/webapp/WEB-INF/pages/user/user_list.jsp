<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/INC/common/head.jsp"/>
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
                        str+='<option value="'+role.id+'">--'+role.roleName+'--</option>';
                    }

                    //追加
                    $("#queryUserRole").append(str);

                    //数据查找后回显
                    $("#queryUserRole").val($("#roleid").val());
                }
            })

        })
    </script>

    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>用户管理页面</span>
        </div>
        <div class="search">
            <form id="queryForm" method="post" action="${pageContext.request.contextPath}/user/findAll">
                <span>用户名：</span>
                <input name="userName" class="input-text"	type="text" value="${userName}">
                <input type="hidden" id="roleid" value="${roleId}"/>
                <span>用户角色：</span>
                <select id="queryUserRole" name="roleId">
                    <option value="0">--请选择--</option>
                </select>

                <input type="hidden" id="pageNo" name="pageNo" value="1"/>
                <input	value="查 询" type="submit" id="searchbutton">
                <a href="${pageContext.request.contextPath}/user/toUserAddPage" >添加用户</a>
            </form>
        </div>
        <!--用户-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">用户编码</th>
                <th width="20%">用户名称</th>
                <th width="10%">性别</th>
                <th width="10%">生日</th>
                <th width="10%">电话</th>
                <th width="10%">用户角色</th>
                <th width="30%">操作</th>
            </tr>
            <c:forEach items="${pageBean.list}" var="user">
            <tr>
                <td>
                    <span>${user.userCode}</span>
                </td>
                <td>
                    <span>${user.userName}</span>
                </td>
                <td>
							<span>
                                <c:if test="${user.gender == 1}">男</c:if>
								<c:if test="${user.gender == 2}">女</c:if>
							</span>
                </td>
                <td>
						<span>
                            <fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"></fmt:formatDate>
						</span>
                </td>
                <td>
                    <span>${user.phone}</span>
                </td>
                <td>
                    <span>${user.role.roleName}</span>
                </td>
                <td>
                    <span><a href="${pageContext.request.contextPath }/user/view?id=${user.id}&type=check"><img src="${pageContext.request.contextPath }/images/read.png" alt="查看" title="查看"/></a></span>
                    <span><a  href="${pageContext.request.contextPath }/user/view?id=${user.id}&type=update"><img src="${pageContext.request.contextPath }/images/xiugai.png" alt="修改" title="修改"/></a></span>
                    <span><a class="deleteUser" href="${pageContext.request.contextPath }/user/delete?id=${user.id}" onclick="return confirm('真的删除吗？')"><img src="${pageContext.request.contextPath }/images/schu.png" alt="删除" title="删除"/></a></span>
                </td>
            </tr>
            </c:forEach>
        </table>
        <input type="hidden" id="totalPageCount" value=""/>
        【当前第${pageBean.pageNum}页 / 共${pageBean.pages}页】
        <div class="pageNum">
            <ul>
                <c:if test="${pageBean.pageNum>1}">
                    <li><a href="${pageContext.request.contextPath}/user/findAll?pageNum=1&pageSize=${pageBean.pageSize}&userName=${userName}&roleId=${roleId}">首页</a></li>
                    <li class="threeword"><a href="${pageContext.request.contextPath}/user/findAll?pageNum=${pageBean.prePage}&pageSize=${pageBean.pageSize}&userName=${userName}&roleId=${roleId}">上一页</a></li>
                </c:if>
                <c:if test="${pageBean.pageNum<=1}">
                    <li  class="threeword"><a class="btn disabled" href="javascript:;">首页</a></li>
                    <li  class="threeword"><a class="btn disabled" href="javascript:;">上一页</a></li>
                </c:if>
                <c:forEach begin="${pageBean.navigateFirstPage}" end="${pageBean.navigateLastPage}" var="p">
                    <c:if test="${pageBean.pageNum==p}">
                        <li class="active"><a href="${pageContext.request.contextPath}/user/findAll?pageNum=${p}&pageSize=${pageBean.pageSize}&userName=${userName}&roleId=${roleId}">${p}</a></li>
                    </c:if>
                    <c:if test="${pageBean.pageNum!=p}">
                        <li><a href="${pageContext.request.contextPath}/user/findAll?pageNum=${p}&pageSize=${pageBean.pageSize}&userName=${userName}&roleId=${roleId}">${p}</a></li>
                    </c:if>
                </c:forEach>
                <c:choose>
                    <c:when test="${pageBean.pageNum==pageBean.pages}">
                        <li disabled class="threeword"><a class="btn disabled" href="javascript:;">下一页</a></li>
                        <li disabled class="threeword"><a class="btn disabled" href="javascript:;">末页</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="threeword"><a href="${pageContext.request.contextPath}/user/findAll?pageNum=${pageBean.nextPage}&pageSize=${pageBean.pageSize}&userName=${userName}&roleId=${roleId}">下一页</a></li>
                        <li class="threeword"><a href="${pageContext.request.contextPath}/user/findAll?pageNum=${pageBean.pages}&pageSize=${pageBean.pageSize}&userName=${userName}&roleId=${roleId}">末页</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

    </div>
</section>



<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeUse">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该用户吗？</p>
            <a href="#" id="yes">确定</a>
            <a href="#" id="no">取消</a>
        </div>
    </div>
</div>



<footer class="footer">
    &copy;2020
</footer>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/time.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/calendar/WdatePicker.js"></script>
</body>
</html>
<script>

</script>

