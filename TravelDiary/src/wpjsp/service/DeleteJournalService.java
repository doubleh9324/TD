package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.jdbc.JdbcUtil;

public class DeleteJournalService {
	
	private static DeleteJournalService instance = new DeleteJournalService();

	public static DeleteJournalService getInstance() {
		return instance;
	}

	private DeleteJournalService() {	}

	public void deleteJournal(int journalNum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			BulletinDao bulletindao = null;
			bulletindao = BulletinDao.getInstnace();
			
			bulletindao.deleteJournal(conn, journalNum);
			
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
