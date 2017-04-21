package wpjsp.service;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;


import wpjsp.dao.MemberDao;
import wpjsp.model.Member;

import wpjsp.jdbc.JdbcUtil;

public class GetMemberInfoService {
	private static GetMemberInfoService instance = new GetMemberInfoService();

	public static GetMemberInfoService getInstance() {
		return instance;
	}

	private GetMemberInfoService() {	}

	public Member getMemberInfo(String userid) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

			
		try {		
			MemberDao memberDao = null;
			Member memberInfo = null;
			
			memberDao = wpjsp.dao.MemberDao.getInstnace();
			memberInfo = memberDao.MemberInfo(conn, userid);
				
			return memberInfo;
			
		} catch (SQLException e) {
			throw new Exception("�α��� ���� " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}


