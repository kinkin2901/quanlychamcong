<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách tài khoản</title>
    <link href="${pageContext.request.contextPath}/view/lib/dist/css/style.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
     data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">

    <!-- Import header -->
    <c:import url="/view/compomnt/header.jsp"/>

    <!-- Import sidebar -->
    <c:import url="/view/compomnt/siderbar.jsp"/>

    <div class="page-wrapper">
        <div class="container-fluid" style="background-color: #ffffff">
            <!-- Thông báo -->
            <c:import url="/view/compomnt/notification.jsp"/>

            <h3>📄 Tạo đơn xin nghỉ phép</h3>
            <form action="${pageContext.request.contextPath}/employee/leave-request-create" method="post">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="start_date" class="form-label">📅 Ngày bắt đầu</label>
                        <input type="date" id="start_date" name="start_date" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label for="end_date" class="form-label">📅 Ngày kết thúc</label>
                        <input type="date" id="end_date" name="end_date" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="leave_type" class="form-label">📌 Loại nghỉ</label>
                    <select id="leave_type" name="leave_type" class="form-select" required>
                        <option value="">-- Chọn loại nghỉ --</option>
                        <option value="annual">Nghỉ phép năm</option>
                        <option value="sick">Nghỉ ốm</option>
                        <option value="personal">Nghỉ cá nhân</option>
                        <option value="unpaid">Nghỉ không lương</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="reason" class="form-label">📝 Lý do</label>
                    <textarea id="reason" name="reason" class="form-control" rows="4" required></textarea>
                </div>

                <button type="submit" class="btn btn-success">✅ Gửi đơn</button>
                <a href="${pageContext.request.contextPath}/employee/leave-requests" class="btn btn-secondary">🔙 Quay lại</a>
            </form>
        </div>
    </div>
</div>

<!-- Import footer -->
<c:import url="/view/compomnt/footer.jsp"/>

<!-- Giới hạn ngày bắt đầu từ hôm nay -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const today = new Date().toISOString().split('T')[0];
        const startInput = document.getElementById("start_date");
        const endInput = document.getElementById("end_date");

        startInput.setAttribute("min", today);
        endInput.setAttribute("min", today);

        // Khi chọn ngày bắt đầu thì ngày kết thúc phải >= ngày bắt đầu
        startInput.addEventListener("change", function () {
            endInput.setAttribute("min", startInput.value);
        });
    });
</script>

</body>
</html>
