package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;

public class UpdateJournalService {
	private static UpdateJournalService instance = new UpdateJournalService();
		
	public static UpdateJournalService getInstance(){
		return instance;
	}
	
	private UpdateJournalService() {}
	
	public void update(Bulletin journal)
		throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try{
			BulletinDao bulletinDao = null;
			bulletinDao = BulletinDao.getInstnace();
			bulletinDao.Journal_update(conn, journal);
		} catch (SQLException e) {
			throw new Exception("updateJournslService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
	
	
}


