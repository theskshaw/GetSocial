
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

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			String name=request.getParameter("fn");
			String uname=request.getParameter("un");
			String emailid=request.getParameter("eid");
			String pass=request.getParameter("ps");
			String rpass=request.getParameter("rps");
			PrintWriter out=response.getWriter();
			Connection cn=GetDatabase.getCn();
			if(!(pass.equals(rpass))){
				out.println("<h5 style='color:red'>Wrong Password</h5>");
			}
			else{
				
				String sql="select * from userdetails where username=?";
				PreparedStatement ps1=cn.prepareStatement(sql);
				ps1.setString(1, uname);
				ResultSet rs=ps1.executeQuery();
				if(rs.next()){
					out.println("<h5 style='color:red'>Username exists.</h5>");
				}
				else{
				String sql1="insert into userdetails values(?,?,?)";
				String sql2="insert into login values(?,?)";
				PreparedStatement ps=cn.prepareStatement(sql1);
				ps.setString(1, uname);
				ps.setString(2, emailid);
				ps.setString(3, name);
				ps.execute();
				ps=cn.prepareStatement(sql2);
				ps.setString(1, uname);
				ps.setString(2, pass);
				ps.execute();
				out.println("<h5 style='color:green'>User Registered!</h5>");
				//RequestDispatcher rd=request.getRequestDispatcher("login.html");
				//rd.include(request, response);
				}
			}
			
		}
		catch(Exception e){
			System.out.println(e);
		}
	}

}
