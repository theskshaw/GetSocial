import getdb.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Post
 */
@WebServlet("/Post")
public class Post extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Post() {
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
		String sql="insert into discuss values(?,?,?)";
		PreparedStatement ps=cn.prepareStatement(sql);
		String s=request.getParameter("message");
		HttpSession p=request.getSession(false);
		String uname=(String)p.getAttribute("uname");
		PrintWriter out=response.getWriter();
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy hh:mm");
		String string  = dateFormat.format(new Date());
		//out.println(string);
		ps.setString(1, uname);
		ps.setString(2, s);
		ps.setString(3, string);
		ps.execute();
		s="";
		response.sendRedirect("discuss.jsp");
		//RequestDispatcher rd=request.getRequestDispatcher("discuss.jsp");
		//rd.include(request,response);
		//out.println(new Timestamp(date.getTime()));
		//out.println(s);
		}
		catch(Exception e){
			System.out.println(e);
		}
	}

}
