package getdb;
import java.sql.*;
public class GetDatabase {
	static Connection cn=null;
	static String driver="com.ibm.db2.jcc.DB2Driver";
	static String url="jdbc:db2://localhost:50000/getprj";
	static String user="SHASHI";
	static String pass="Loveintheair2944";
	
	public static Connection getCn()
	{
		try{
			Class.forName(driver);
			cn=DriverManager.getConnection(url,user,pass);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		return cn;
	}
}
