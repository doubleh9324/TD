package wpjsp.service;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;


import wpjsp.dao.MemberDao;
import wpjsp.model.Member;

import wpjsp.jdbc.JdbcUtil;

public class LoginService {
	private static LoginService instance = new LoginService();

	public static LoginService getInstance() {
		return instance;
	}

	private LoginService() {	}

	public boolean Login(Member member) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		String rs;
			
		try {		
			MemberDao MemberDao = null;
			boolean PW;
			
			MemberDao = wpjsp.dao.MemberDao.getInstnace();
			
			String id = member.getMember_id();
			rs = MemberDao.MemberId_check(conn, id);

			PW = (member.getMember_pw()).equals(rs);
				
			if(PW)
			{	return true;	}
			else
			{	return false;	}

		} catch (SQLException e) {
			throw new Exception("error loginservice " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}


