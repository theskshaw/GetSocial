import getdb.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class Upload
 */
@WebServlet("/Upload")
public class Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
		Connection cn=GetDatabase.getCn();
		String sql="select * from gid";
		PreparedStatement ps=cn.prepareStatement(sql);
		ResultSet rs=ps.executeQuery();
		String full="";
		HttpSession p=request.getSession(false);
		String uname=(String)p.getAttribute("uname");
		if(rs.next()){
			full=rs.getString(1);
		}
		String lpart=full.substring(3,full.length());
		int number=Integer.parseInt(lpart);
		number=number+1;
		String newid="img"+number+"";
		
		ServletFileUpload sf=new ServletFileUpload(new DiskFileItemFactory());
		List<FileItem> a=sf.parseRequest(request);
		String name="";
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy hh:mm");
		String string  = dateFormat.format(new Date());
		for(FileItem item:a){
			//System.out.println(item.getName());
			name=gn(item.getName());
			item.write(new File("D:/photo/"+name));}
		
		sql="insert into images values(?,?,?,?)";
		ps=cn.prepareStatement(sql);
		ps.setString(1, full);
		ps.setString(2, uname);
		ps.setString(3, name);
		ps.setString(4, string);
		
		ps.execute();
		
		sql="update gid set gid=?";
		ps=cn.prepareStatement(sql);
		ps.setString(1, newid);
		ps.execute();
		response.sendRedirect("home.jsp");
		}
		
		catch(Exception e){
			System.out.println(e);
		}
	}
		private String gn(String name) {
			// TODO Auto-generated method stub
			String p=name.substring(name.lastIndexOf('\\')+1);
			return p;
		}
}
