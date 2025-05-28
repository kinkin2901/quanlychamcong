<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách đơn xin nghỉ phép</title>
        <link href="${pageContext.request.contextPath}/view/lib/dist/css/style.min.css" rel="stylesheet">
    </head>
    <body>


        <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
             data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">


            <!-- Import header -->
            <c:import url="/view/compomnt/header.jsp" />

            <!-- Import sidebar -->
            <c:import url="/view/compomnt/siderbar.jsp" />

            <div class="page-wrapper">
                <div class="container-fluid" style="background-color: #ffffff">
                    <!-- Thông báo -->
                    <c:import url="/view/compomnt/notification.jsp" />






                    <h3>📄 Danh sách đơn xin nghỉ phép</h3>
                    <table id="multi_col_order" class="table table-bordered table-striped text-center shadow-sm">
                        <thead class="table-primary">
                            <tr>
                                <th>#</th>
                                <th>Loại nghỉ</th>
                                <th>Thời gian</th>
                                <th>Số ngày</th>
                                <th>Trạng thái</th>
                                <th>Lý do</th>
                                <th>Ngày tạo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requests}" var="r" varStatus="loop">
                                <tr style="cursor: pointer;" onclick="window.location = '${pageContext.request.contextPath}/employee/leave-request-detail?id=${r.requestId}'">
                                    <td>${loop.index + 1}</td>
                                    <td><span class="badge bg-info text-dark">${r.leaveType}</span></td>
                                    <td>
                            <fmt:formatDate value="${r.startDate}" pattern="dd/MM/yyyy" />
                            -
                            <fmt:formatDate value="${r.endDate}" pattern="dd/MM/yyyy" />
                            </td>
                            <td>${r.daysCount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.status == 'approved'}">
                                        <span class="badge bg-success">Đã duyệt</span>
                                    </c:when>
                                    <c:when test="${r.status == 'rejected'}">
                                        <span class="badge bg-danger">Từ chối</span>
                                    </c:when>
                                    <c:when test="${r.status == 'canceled'}">
                                        <span class="badge bg-secondary">Đã hủy</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark">Đang chờ</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-start">${r.reason}</td>
                            <td><fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>









                </div>   

            </div>   
        </div>

        <!-- Import footer -->
        <c:import url="/view/compomnt/footer.jsp" />


    </div>
</body>
</html>
