package dal;

import model.LeaveRequest;
import model.Users;
import java.sql.*;
import java.util.*;

public class LeaveRequestDAO extends DBContext {

    public List<LeaveRequest> getAllRequests() {
        List<LeaveRequest> list = new ArrayList<>();
        String sql = "SELECT lr.*, u.full_name as requester, a.full_name as approver FROM leave_requests lr "
                + "LEFT JOIN users u ON lr.user_id = u.user_id "
                + "LEFT JOIN users a ON lr.approved_by = a.user_id";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                Users requester = new Users();
                requester.setUserId(rs.getInt("user_id"));
                requester.setFullName(rs.getString("requester"));

                Users approver = null;
                if (rs.getInt("approved_by") != 0) {
                    approver = new Users();
                    approver.setUserId(rs.getInt("approved_by"));
                    approver.setFullName(rs.getString("approver"));
                }

                lr.setRequestId(rs.getInt("request_id"));
                lr.setUser(requester);
                lr.setStartDate(rs.getDate("start_date"));
                lr.setEndDate(rs.getDate("end_date"));
                lr.setLeaveType(rs.getString("leave_type"));
                lr.setStatus(rs.getString("status"));
                lr.setDaysCount(rs.getInt("days_count"));
                lr.setReason(rs.getString("reason"));
                lr.setCreatedAt(rs.getTimestamp("created_at"));
                lr.setApprovedBy(approver);

                list.add(lr);
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


}
