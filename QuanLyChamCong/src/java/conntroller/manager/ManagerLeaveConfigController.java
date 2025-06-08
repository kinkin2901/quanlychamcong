package conntroller.manager;

import dal.LeaveRequestDAO;
import model.LeaveConfig;
import model.Users;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LeaveConfigController", urlPatterns = {"/manager/leave-config"})
public class ManagerLeaveConfigController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LeaveRequestDAO dao = new LeaveRequestDAO();

        // Danh sách config
        List<LeaveConfig> list = dao.getAllConfigs();

        request.setAttribute("configs", list);
        request.getRequestDispatcher("/view/manager/leave-config.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        LeaveRequestDAO dao = new LeaveRequestDAO();

        try {
            if ("add".equals(action)) {
                int year = Integer.parseInt(request.getParameter("year"));
                String leaveType = request.getParameter("leaveType");
                int defaultDays = Integer.parseInt(request.getParameter("defaultDays"));

                LeaveConfig config = new LeaveConfig();
                config.setYear(year);
                config.setLeaveType(leaveType);
                config.setDefaultDays(defaultDays);
                config.setCreatedBy(currentUser); // Lưu user

                boolean added = dao.addConfig(config);
                if (added) {
                    session.setAttribute("message", "Thêm cấu hình thành công!");
                } else {
                    session.setAttribute("error", "Thêm thất bại.");
                }

            } else if ("delete".equals(action)) {
                int configId = Integer.parseInt(request.getParameter("configId"));
                boolean deleted = dao.deleteConfig(configId);
                if (deleted) {
                    session.setAttribute("message", "Xóa cấu hình thành công!");
                } else {
                    session.setAttribute("error", "Xóa thất bại.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Đã có lỗi xảy ra.");
        }

        response.sendRedirect(request.getContextPath() + "/leave-config");
    }

    @Override
    public String getServletInfo() {
        return "LeaveConfigController - quản lý cấu hình phép";
    }

}
