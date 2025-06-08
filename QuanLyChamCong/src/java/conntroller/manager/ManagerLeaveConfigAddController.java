/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conntroller.manager;

import dal.LeaveRequestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.LeaveConfig;
import model.Users;

@WebServlet(name = "ManagerLeaveConfigAddController", urlPatterns = {"/manager/leave-config-add"})
public class ManagerLeaveConfigAddController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form thêm mới
        request.getRequestDispatcher("/view/manager/leave-config-add.jsp").forward(request, response);
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

        try {
            int year = Integer.parseInt(request.getParameter("year"));
            String leaveType = request.getParameter("leaveType");
            int defaultDays = Integer.parseInt(request.getParameter("defaultDays"));

            LeaveConfig config = new LeaveConfig();
            config.setYear(year);
            config.setLeaveType(leaveType);
            config.setDefaultDays(defaultDays);
            config.setCreatedBy(currentUser);

            LeaveRequestDAO dao = new LeaveRequestDAO();
            boolean success = dao.addConfig(config);

            if (success) {
                session.setAttribute("successMessage", "Thêm cấu hình thành công!");
            } else {
                session.setAttribute("errorMessage", "Thêm cấu hình thất bại!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra!");
        }

        // Sau khi thêm → quay lại danh sách
        response.sendRedirect(request.getContextPath() + "/manager/leave-config");
    }
}
