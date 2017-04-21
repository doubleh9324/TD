package wpjsp.service;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;


import wpjsp.dao.MemberDao;
import wpjsp.model.Member;

import wpjsp.jdbc.JdbcUtil;

public class UpdateMemberInfoService {
	private static UpdateMemberInfoService instance = new UpdateMemberInfoService();

	public static UpdateMemberInfoService getInstance() {
		return instance;
	}

	private UpdateMemberInfoService() {	}

	public void UpdateMemberInfo(Member member) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			MemberDao MemberDao = null;
			
			MemberDao = wpjsp.dao.MemberDao.getInstnace();
			MemberDao.Member_update(conn, member);
			
		} catch (SQLException e) {
			throw new Exception("UpdateMemberInfoService error " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
}
