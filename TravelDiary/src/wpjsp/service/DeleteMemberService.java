package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Member;

public class DeleteMemberService {
	
	private static DeleteMemberService instance = new DeleteMemberService();

	public static DeleteMemberService getInstance() {
		return instance;
	}

	private DeleteMemberService() {	}

	public void deleteMember(int memberNum) 
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
			MemberDao.deleteMember(conn, memberNum);
			
		} catch (SQLException e) {
			throw new Exception("UpdateMemberInfoService error " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
