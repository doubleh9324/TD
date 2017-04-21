package wpjsp.service;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.model.Bulletin;

import wpjsp.jdbc.JdbcUtil;

public class ReadJournalService {
	
		private static ReadJournalService instance = new ReadJournalService();

		public static ReadJournalService getInstance() {
			return instance;
		}

		private ReadJournalService() {	}

		public Bulletin read(int journalNum) 
			throws Exception 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "hh";
			String dbPass = "1215";
			Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				
			
			try {		
				BulletinDao bulletinDao = null;
				Bulletin journal = null;
				
				bulletinDao = BulletinDao.getInstnace();
				bulletinDao.plusHitsCount(conn, journalNum);
				journal = bulletinDao.readJournal(conn, journalNum);
				
				return journal;
				
				
			} catch (SQLException e) {
				throw new Exception("ReadJournalService error: " + e.getMessage(), e);
			} finally {
				JdbcUtil.close(conn);
				
			}
			

	}


}
