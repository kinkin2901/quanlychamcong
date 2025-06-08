package dal;

import model.LeaveRequest;
import model.Users;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.time.LocalDate;
import model.Locations;

public class LeaveRequestDAO extends DBContext {

//    public List<LeaveRequest> getAllRequests() {
//        List<LeaveRequest> list = new ArrayList<>();
//        String sql = "SELECT lr.*, u.full_name as requester, a.full_name as approver FROM leave_requests lr "
//                + "LEFT JOIN users u ON lr.user_id = u.user_id "
//                + "LEFT JOIN users a ON lr.approved_by = a.user_id";
//
//        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                LeaveRequest lr = new LeaveRequest();
//                Users requester = new Users();
//                requester.setUserId(rs.getInt("user_id"));
//                requester.setFullName(rs.getString("requester"));
//
//                Users approver = null;
//                if (rs.getInt("approved_by") != 0) {
//                    approver = new Users();
//                    approver.setUserId(rs.getInt("approved_by"));
//                    approver.setFullName(rs.getString("approver"));
//                }
//
//                lr.setRequestId(rs.getInt("request_id"));
//                lr.setUser(requester);
//                lr.setStartDate(rs.getDate("start_date"));
//                lr.setEndDate(rs.getDate("end_date"));
//                lr.setLeaveType(rs.getString("leave_type"));
//                lr.setStatus(rs.getString("status"));
//                lr.setDaysCount(rs.getInt("days_count"));
//                lr.setReason(rs.getString("reason"));
//                lr.setCreatedAt(rs.getTimestamp("created_at"));
//                lr.setApprovedBy(approver);
//
//                list.add(lr);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return list;
//    }
    public List<LeaveRequest> getAllRequests() {
        List<LeaveRequest> list = new ArrayList<>();

        String sql = "SELECT lr.*, u.full_name AS requester, a.full_name AS approver, "
                + "l.location_id, l.name AS location_name, l.address, l.is_active, l.ip_map "
                + "FROM leave_requests lr "
                + "JOIN users u ON lr.user_id = u.user_id "
                + "LEFT JOIN users a ON lr.approved_by = a.user_id "
                + "LEFT JOIN user_locations ul ON ul.user_id = u.user_id "
                + "LEFT JOIN locations l ON ul.location_id = l.location_id "
                + "ORDER BY lr.request_id";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            int currentRequestId = -1;
            LeaveRequest lr = null;

            while (rs.next()) {
                int requestId = rs.getInt("request_id");

                // Nếu gặp request_id mới → tạo LeaveRequest mới
                if (requestId != currentRequestId) {
                    lr = new LeaveRequest();

                    // Lấy người nộp đơn
                    Users requester = new Users();
                    requester.setUserId(rs.getInt("user_id"));
                    requester.setFullName(rs.getString("requester"));

                    // Lấy người duyệt (nếu có)
                    Users approver = null;
                    if (rs.getInt("approved_by") != 0) {
                        approver = new Users();
                        approver.setUserId(rs.getInt("approved_by"));
                        approver.setFullName(rs.getString("approver"));
                    }

                    // Set thông tin LeaveRequest
                    lr.setRequestId(requestId);
                    lr.setUser(requester);
                    lr.setStartDate(rs.getDate("start_date"));
                    lr.setEndDate(rs.getDate("end_date"));
                    lr.setLeaveType(rs.getString("leave_type"));
                    lr.setStatus(rs.getString("status"));
                    lr.setDaysCount(rs.getInt("days_count"));
                    lr.setReason(rs.getString("reason"));
                    lr.setCreatedAt(rs.getTimestamp("created_at"));
                    lr.setApprovedBy(approver);
                    lr.setApproveComment(rs.getString("approve_comment"));

                    // Tạo list locations mới
                    lr.setLocations(new ArrayList<>());

                    // Thêm vào list chính
                    list.add(lr);

                    currentRequestId = requestId;
                }

                // Với mỗi dòng → kiểm tra nếu có location thì thêm vào list locations
                int locationId = rs.getInt("location_id");
                if (locationId != 0) {
                    Locations loc = new Locations();
                    loc.setId(locationId);
                    loc.setName(rs.getString("location_name"));
                    loc.setAddress(rs.getString("address"));
                    loc.setIsActive(rs.getBoolean("is_active"));
                    loc.setIpMap(rs.getString("ip_map"));

                    lr.getLocations().add(loc);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void approveRequest(int requestId, int approverId, String note) {
        String sql = "UPDATE leave_requests SET status = 'approved', approved_by = ?, approve_note = ? WHERE request_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, approverId);
            ps.setString(2, note);
            ps.setInt(3, requestId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void rejectRequest(int requestId, int approverId, String note) {
        String sql = "UPDATE leave_requests SET status = 'rejected', approved_by = ?, approve_comment = ? WHERE request_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, approverId);
            ps.setString(2, note);
            ps.setInt(3, requestId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void cancelRequest(int requestId, int userId, String note) {
        String sql = "UPDATE leave_requests SET status = 'canceled', approved_by = ?, approve_comment = ? WHERE request_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, note);
            ps.setInt(3, requestId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public LeaveRequest getRequestById(int id) {
        String sql = "SELECT lr.*, u.full_name as requester, a.full_name as approver FROM leave_requests lr "
                + "LEFT JOIN users u ON lr.user_id = u.user_id "
                + "LEFT JOIN users a ON lr.approved_by = a.user_id "
                + "WHERE lr.request_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LeaveRequest lr = new LeaveRequest();

                // Người gửi
                Users requester = new Users();
                requester.setUserId(rs.getInt("user_id"));
                requester.setFullName(rs.getString("requester"));
                lr.setUser(requester);

                // Người duyệt (có thể null)
                int approverId = rs.getInt("approved_by");
                Users approver = null;
                if (!rs.wasNull()) {
                    approver = new Users();
                    approver.setUserId(approverId);
                    approver.setFullName(rs.getString("approver"));
                }

                // Gán các thuộc tính còn lại
                lr.setRequestId(rs.getInt("request_id"));
                lr.setStartDate(rs.getDate("start_date"));
                lr.setEndDate(rs.getDate("end_date"));
                lr.setLeaveType(rs.getString("leave_type"));
                lr.setStatus(rs.getString("status"));
                lr.setDaysCount(rs.getInt("days_count"));
                lr.setReason(rs.getString("reason"));
                lr.setCreatedAt(rs.getTimestamp("created_at"));
                lr.setApprovedBy(approver);
                lr.setApproveComment(rs.getString("approve_comment"));

                return lr;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createRequest(int userId, Date startDate, Date endDate, String leaveType, String reason, int daysCount) {
        String sql = "INSERT INTO leave_requests "
                + "(user_id, start_date, end_date, leave_type, reason, days_count, status, created_at, approved_by, approve_comment) "
                + "VALUES (?, ?, ?, ?, ?, ?, 'pending', GETDATE(), NULL, NULL)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            ps.setString(4, leaveType);
            ps.setString(5, reason);
            ps.setInt(6, daysCount);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<LeaveRequest> getRequestsByUserId(int userId) {
        List<LeaveRequest> list = new ArrayList<>();
        String sql = "SELECT lr.*, u.full_name as requester FROM leave_requests lr "
                + "JOIN users u ON lr.user_id = u.user_id "
                + "WHERE lr.user_id = ? ORDER BY lr.created_at DESC";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                Users requester = new Users();
                requester.setUserId(rs.getInt("user_id"));
                requester.setFullName(rs.getString("requester"));

                lr.setRequestId(rs.getInt("request_id"));
                lr.setUser(requester);
                lr.setStartDate(rs.getDate("start_date"));
                lr.setEndDate(rs.getDate("end_date"));
                lr.setLeaveType(rs.getString("leave_type"));
                lr.setStatus(rs.getString("status"));
                lr.setDaysCount(rs.getInt("days_count"));
                lr.setReason(rs.getString("reason"));
                lr.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(lr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        LeaveRequestDAO dao = new LeaveRequestDAO();

        int testId = 5; // Thay bằng request_id có thật trong DB

        LeaveRequest lr = dao.getRequestById(testId);

        if (lr != null) {
            System.out.println("📄 Chi tiết đơn xin nghỉ:");
            System.out.println("🆔 Mã đơn: " + lr.getRequestId());
            System.out.println("👤 Nhân viên: " + lr.getUser().getFullName());
            System.out.println("📅 Từ ngày: " + lr.getStartDate());
            System.out.println("📅 Đến ngày: " + lr.getEndDate());
            System.out.println("📌 Loại nghỉ: " + lr.getLeaveType());
            System.out.println("📝 Lý do: " + lr.getReason());
            System.out.println("🔢 Số ngày: " + lr.getDaysCount());
            System.out.println("📆 Ngày tạo: " + lr.getCreatedAt());
            System.out.println("📊 Trạng thái: " + lr.getStatus());

            Users approver = lr.getApprovedBy();
            if (approver != null) {
                System.out.println("✅ Duyệt bởi: " + approver.getFullName());
            } else {
                System.out.println("⏳ Chưa được duyệt");
            }

            System.out.println("💬 Ghi chú duyệt: " + (lr.getApproveComment() != null ? lr.getApproveComment() : "Không có"));
        } else {
            System.out.println("❌ Không tìm thấy đơn xin nghỉ với ID = " + testId);
        }
    }
}
