import getdb.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Update
 */
@WebServlet("/Update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Update() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			Connection cn=GetDatabase.getCn();
			HttpSession p=request.getSession(false);
			String uname=(String)p.getAttribute("uname");
			String eid=request.getParameter("eid");
			String fname=request.getParameter("fname");
			String sql="update userdetails set emailid=?,name=? where username=?";
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1, eid);
			ps.setString(2, fname);
			ps.setString(3, uname);
			ps.execute();
			response.sendRedirect("profile.jsp");
			
		}
		catch(Exception e){
			System.out.println(e);
		}
	}

}
