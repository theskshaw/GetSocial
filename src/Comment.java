
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
 * Servlet implementation class Comment
 */
@WebServlet("/Comment")
public class Comment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Comment() {
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
		String imgid=request.getParameter("imgid");
		String com=request.getParameter("com");
		String uname=(String)p.getAttribute("uname");
		String sql="insert into comm values(?,?,?)";
		PreparedStatement ps=cn.prepareStatement(sql);
		ps.setString(1, imgid);
		ps.setString(2,com);
		ps.setString(3, uname);
		ps.execute();
		response.sendRedirect("home.jsp");
		}
		catch(Exception e){
			System.out.println(e);
		}
	}

}
