package connect_package;
import java.sql.Connection;
import java.sql.DriverManager;

public class connectDB {
		static Connection con=null;
		public static Connection getConnect()
		{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/sportssync","root","");
			System.out.println("Connection Established");
		} catch (Exception e) {
			System.out.println("Failed" + e.getMessage());
			e.printStackTrace();
		}
		return con;
		}
	}

