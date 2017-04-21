package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.dao.ScrapDao;
import wpjsp.jdbc.JdbcUtil;

public class ScrapService {
	
	private static ScrapService instance = new ScrapService();

	public static ScrapService getInstance() {
		return instance;
	}

	private ScrapService() {	}
	
	//새로운 스크랩 실행
	public int scrapJournal(int memNum, int jourNum) throws Exception{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "hh";
			String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		int re = 0;
		try {	
			BulletinDao bulletindao = BulletinDao.getInstnace();
			bulletindao.plusScrapCount(conn, jourNum);
			
			ScrapDao scrapdao = ScrapDao.getInstance();
			re = scrapdao.scrap(conn, memNum, jourNum);
			
			return re;
		} catch (SQLException e) {
			throw new Exception("error scrapJournal" + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	
	public void unscrapJournal(int memNum, int[] jourNum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try {		
			ScrapDao scrapdao = ScrapDao.getInstance();;
			scrapdao.unscrap(conn, memNum, jourNum);
		} catch (SQLException e) {
			throw new Exception("error unscrapJournal " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	

}
