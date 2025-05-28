<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách tài khoản</title>
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









                    <h3 class="mb-4 text-primary">📋 Danh sách đơn xin nghỉ phép</h3>

                    <div class="table-responsive">
                        <div class="d-flex justify-content-between mb-3">
   <div class="filter-container">
    <label for="filterUser">🔍 Người nộp:</label>
    <select id="filterUser">
        <option value="">-- Tất cả --</option>
        <c:forEach items="${requests}" var="r">
            <option value="${r.user.fullName}">${r.user.fullName}</option>
        </c:forEach>
    </select>

    <label for="filterStatus" class="ms-3">📌 Trạng thái:</label>
    <select id="filterStatus">
        <option value="">-- Tất cả --</option>
        <option value="Đã duyệt">Đã duyệt</option>
        <option value="Đang chờ">Đang chờ</option>
        <option value="Từ chối">Từ chối</option>
        <option value="Đã hủy">Đã hủy</option>
    </select>
</div>

</div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const filterUser = document.getElementById("filterUser");
    const filterStatus = document.getElementById("filterStatus");

    function normalize(str) {
        return str.trim().toLowerCase();
    }

    function filterTable() {
        const selectedUser = normalize(filterUser.value);
        const selectedStatus = normalize(filterStatus.value);

        document.querySelectorAll("#multi_col_order tbody tr").forEach(row => {
            const user = normalize(row.cells[1].textContent);
            const status = normalize(row.cells[5].textContent);

            const matchUser = !selectedUser || user.includes(selectedUser);
            const matchStatus = !selectedStatus || status.includes(selectedStatus);

            row.style.display = (matchUser && matchStatus) ? "" : "none";
        });
    }

    filterUser.addEventListener("change", filterTable);
    filterStatus.addEventListener("change", filterTable);
});
</script>
<style>
    .filter-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        align-items: center;
        margin-bottom: 20px;
        padding: 10px;
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 8px;
    }

    .filter-container label {
        font-weight: 500;
        margin-right: 8px;
        margin-bottom: 0;
    }

    .filter-container select {
        min-width: 180px;
        padding: 5px 10px;
        border-radius: 6px;
        border: 1px solid #ced4da;
        background-color: #ffffff;
        transition: all 0.2s ease-in-out;
    }

    .filter-container select:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        outline: none;
    }
</style>


                        <table id="multi_col_order" class="table table-hover table-bordered align-middle text-center shadow-sm rounded">
                            <thead class="table-primary">
                                <tr>
                                    <th>#</th>
                                    <th>Người nộp đơn</th>
                                    <th>Loại nghỉ</th>
                                    <th>Thời gian</th>
                                    <th>Số ngày</th>
                                    <th>Trạng thái</th>
                                    <th>Người duyệt</th>
                                    <th>Ngày tạo</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requests}" var="r">
                                    <tr>
                                        <td>${r.requestId}</td>
                                        <td class="text-start">${r.user.fullName}</td>
                                        <td><span class="badge bg-info text-dark">${r.leaveType}</span></td>
                                        <td>
                                <fmt:formatDate value="${r.startDate}" pattern="dd/MM/yyyy" /> -
                                <fmt:formatDate value="${r.endDate}" pattern="dd/MM/yyyy" />
                                </td>
                                <td><strong>${r.daysCount}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status == 'approved'}">
                                            <span class="badge bg-success">Đã duyệt</span>
                                        </c:when>
                                        <c:when test="${r.status == 'pending'}">
                                            <span class="badge bg-warning text-dark">Đang chờ</span>
                                        </c:when>
                                        <c:when test="${r.status == 'rejected'}">
                                            <span class="badge bg-danger">Từ chối</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:out value="${r.approvedBy != null ? r.approvedBy.fullName : 'Chưa duyệt'}"/>
                                </td>
                                <td><fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
                                <!-- Cập nhật phần hành động trong bảng -->
                                <td>
                                    <button class="btn btn-sm btn-outline-success approve-btn"
                                            data-id="${r.requestId}">
                                        ✅ Phê duyệt
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger reject-btn" data-id="${r.requestId}">
                                        ❌ Từ chối
                                    </button>

                                    <button class="btn btn-sm btn-outline-secondary cancel-btn"
                                            data-id="${r.requestId}">
                                        🚫 Hủy
                                    </button>

                                </td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <style>
                        /* Căn search box sang phải */
                        div.dataTables_filter {
                            float: right !important;
                            text-align: right;
                        }

                        /* Căn phân trang sang phải */
                        div.dataTables_paginate {
                            float: right !important;
                            text-align: right;
                        }

                        /* Căn "Show entries" sang trái (tuỳ chọn) */
                        div.dataTables_length {
                            float: left !important;
                        }

                        /* Tăng khoảng cách giữa các control nếu cần */
                        .dataTables_wrapper .dataTables_filter input {
                            margin-left: 0.5rem;
                        }
                    </style>



                    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            // Phê duyệt
                            document.querySelectorAll(".approve-btn").forEach(btn => {
                                btn.addEventListener("click", function () {
                                    const requestId = this.getAttribute("data-id");

                                    Swal.fire({
                                        title: 'Phê duyệt đơn xin nghỉ',
                                        input: 'text',
                                        inputLabel: 'Nhập lý do phê duyệt (tuỳ chọn)',
                                        inputPlaceholder: 'Ví dụ: Đơn hợp lệ',
                                        showCancelButton: true,
                                        confirmButtonText: '✅ Phê duyệt',
                                        cancelButtonText: '❌ Hủy',
                                        confirmButtonColor: '#198754',
                                        cancelButtonColor: '#d33'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            const note = encodeURIComponent(result.value || '');
                                            window.location.href = '${pageContext.request.contextPath}/manager/leave-requests-approve?id=' + requestId + '&note=' + note;
                                        }
                                    });
                                });
                            });

                            document.querySelectorAll(".reject-btn").forEach(btn => {
                                btn.addEventListener("click", function () {
                                    const requestId = this.getAttribute("data-id");

                                    Swal.fire({
                                        title: 'Từ chối đơn xin nghỉ',
                                        input: 'text',
                                        inputLabel: 'Nhập lý do từ chối',
                                        inputPlaceholder: 'Ví dụ: Không đủ giấy tờ',
                                        showCancelButton: true,
                                        confirmButtonText: '❌ Từ chối',
                                        cancelButtonText: 'Hủy',
                                        confirmButtonColor: '#dc3545',
                                        cancelButtonColor: '#6c757d'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            const note = encodeURIComponent(result.value || '');
                                            window.location.href = '${pageContext.request.contextPath}/manager/leave-requests-reject?id=' + requestId + '&note=' + note;
                                        }
                                    });
                                });
                            });

                            // Hủy
                            document.querySelectorAll(".cancel-btn").forEach(button => {
                                button.addEventListener("click", function () {
                                    const id = this.getAttribute("data-id");

                                    Swal.fire({
                                        title: "Bạn có chắc muốn hủy đơn này?",
                                        input: "text",
                                        inputLabel: "Lý do hủy (tùy chọn)",
                                        inputPlaceholder: "Ví dụ: Hủy do lịch thay đổi",
                                        showCancelButton: true,
                                        confirmButtonText: "🚫 Hủy đơn",
                                        cancelButtonText: "Thoát"
                                    }).then(result => {
                                        if (result.isConfirmed) {
                                            const note = encodeURIComponent(result.value || '');
                                            window.location.href = '${pageContext.request.contextPath}/manager/leave-requests-cancel?id=' + id + '&note=' + note;
                                        }
                                    });
                                });
                            });

                        });
                    </script>






                </div>   

            </div>   
        </div>

        <!-- Import footer -->
        <c:import url="/view/compomnt/footer.jsp" />


    </div>
</body>
</html>
