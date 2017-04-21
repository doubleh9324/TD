package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Member;

public class ConvertNumToIdService {
	
		private static ConvertNumToIdService instance = new ConvertNumToIdService();

		public static ConvertNumToIdService getInstance() {
			return instance;
		}

		private ConvertNumToIdService() {	}

		public String getMemberId(int idnum) 
			throws Exception 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "hh";
			String dbPass = "1215";
			Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

				
			try {		
				String reId = null;
				MemberDao memberDao = null;
				
				memberDao = MemberDao.getInstnace();
				reId = memberDao.getMemberId(conn, idnum);
					
				return reId;
				
			} catch (SQLException e) {
				throw new Exception("ConvertNumToIdService" + e.getMessage(), e);
			} finally {
				JdbcUtil.close(conn);
			}
		}
	}
