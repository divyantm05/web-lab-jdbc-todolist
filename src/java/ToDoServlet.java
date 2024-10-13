import com.db.DBConnector;
import com.pojo.Task;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/todoServlet"})
public class ToDoServlet extends HttpServlet {
    DBConnector dBConnector = new DBConnector();

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action.equals("add")) {
            String task = req.getParameter("task");
            try {
                dBConnector.insert(task);  
                res.sendRedirect("todoServlet");  
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else if (action.equals("remove")) {
            int taskId = Integer.parseInt(req.getParameter("taskId"));
            try {
                dBConnector.remove(taskId);  
                res.sendRedirect("todoServlet");  
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Task> tasks = new ArrayList<>();
        try {
            tasks = getAllTasks();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        request.setAttribute("tasks", tasks);  
        request.getRequestDispatcher("index.jsp").forward(request, response); 
    }

    public List<Task> getAllTasks() throws SQLException {
        List<Task> tasks = new ArrayList<>();
        ResultSet rs = dBConnector.getRecords();
        while (rs.next()) {
            tasks.add(new Task(rs.getInt("id"), rs.getString("task")));
        }
        return tasks;
    }
}
