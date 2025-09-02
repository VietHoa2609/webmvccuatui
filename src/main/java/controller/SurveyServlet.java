package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Survey;

/**
 * Flow:
 *  - GET  /survey           -> forward tới /WEB-INF/index.jsp (form)
 *  - POST /survey (submit)  -> tạo Survey, lưu tạm vào session, redirect (PRG)
 *  - GET  /survey?done=1    -> lấy Survey từ session, đặt vào request, forward /WEB-INF/thanks.jsp
 *
 * Ưu điểm: JSP không chứa Java (dùng EL), tránh F5 resubmit, thanks.jsp trong WEB-INF không bị mở trộm.
 */
public class SurveyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET: hiện form hoặc hiện trang cảm ơn (sau PRG)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Nếu vừa redirect sau khi submit (PRG)
        if ("1".equals(req.getParameter("done"))) {
            Survey survey = (Survey) req.getSession().getAttribute("survey");
            if (survey == null) {                       // Không có dữ liệu -> quay về form
                resp.sendRedirect(req.getContextPath() + "/survey");
                return;
            }
            req.getSession().removeAttribute("survey"); // Flash: dùng 1 lần
            req.setAttribute("survey", survey);
            req.getRequestDispatcher("/WEB-INF/thanks.jsp").forward(req, resp);
            return;
        }

        // Mặc định: mở form thật trong WEB-INF
        req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
    }

    // POST: nhận form, validate, tạo bean, PRG
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 1) Lấy dữ liệu từ form (Tên field phải KHỚP với form của bạn)
        String firstName  = n(req.getParameter("firstName"));
        String lastName   = n(req.getParameter("lastName"));
        String email      = n(req.getParameter("email"));
        String dob        = n(req.getParameter("dob"));
        String heardFrom  = n(req.getParameter("heardFrom"));
        String contactVia = n(req.getParameter("contactVia"));     // <select name="contactVia">
        String comments   = n(req.getParameter("comments"));
        boolean updates   = req.getParameter("updates") != null;   // <input type="checkbox" name="updates">
        boolean emailAnn  = req.getParameter("emailAnnounce") != null; // nếu bạn có checkbox này

        // 2) Validate tối thiểu
        if (firstName.isEmpty() || lastName.isEmpty() || email.isEmpty()) {
            req.setAttribute("message", "Vui lòng nhập First Name, Last Name và Email.");

            // Giữ lại giá trị đã nhập để user đỡ phải gõ lại
            req.setAttribute("firstName", firstName);
            req.setAttribute("lastName", lastName);
            req.setAttribute("email", email);
            req.setAttribute("dob", dob);
            req.setAttribute("heardFrom", heardFrom);
            req.setAttribute("contactVia", contactVia);
            req.setAttribute("comments", comments);
            req.setAttribute("updates", updates);
            req.setAttribute("emailAnnounce", emailAnn);

            req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
            return;
        }

        // 3) Tạo bean & lưu tạm vào session (flash)
        Survey survey = new Survey(firstName, lastName, email, dob, heardFrom, contactVia, comments, updates);
        // Nếu muốn lưu thêm cờ emailAnn thì mở rộng Survey hoặc setAttribute lẻ cho JSP
        req.getSession().setAttribute("survey", survey);

        // 4) PRG: redirect để tránh F5 resubmit
        resp.sendRedirect(req.getContextPath() + "/survey?done=1");
    }

    private String n(String s) { return s == null ? "" : s.trim(); }
}
