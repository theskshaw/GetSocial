
import getdb.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
			String uname=request.getParameter("u");
			String pword=request.getParameter("p");
			String sql="select password from login where username=?";
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1, uname);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				if(pword.equals(rs.getString(1))){
					HttpSession id=request.getSession();
					id.setAttribute("uname", uname);
					RequestDispatcher rd=request.getRequestDispatcher("home.jsp");
					rd.forward(request, response);
				}
				else
				{	
					PrintWriter out=response.getWriter();
					out.println("<script>");
					out.println("alert('Wrong login details.');");
					out.println("</script>");
					RequestDispatcher rd=request.getRequestDispatcher("login.html");
					rd.include(request, response);
					//response.sendRedirect("login.html");
				}
			}
			else{
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('User not registerd.');");
				out.println("</script>");
				RequestDispatcher rd=request.getRequestDispatcher("login.html");
				rd.include(request, response);
				//response.sendRedirect("login.html");
			}
			
		}
		catch(Exception e){
			System.out.println(e);
		}
	}

}
