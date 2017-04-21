package wpjsp.service;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.model.Bulletin;

import wpjsp.jdbc.JdbcUtil;

public class WriteJournalService {
	private static WriteJournalService instance = new WriteJournalService();

	public static WriteJournalService getInstance() {
		return instance;
	}

	private WriteJournalService() {	}

	public void write(Bulletin journal) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			BulletinDao bulletinDao = BulletinDao.getInstnace();
			bulletinDao.New_journal(conn, journal);
			
		} catch (SQLException e) {
			throw new Exception("writeJournalService error: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
