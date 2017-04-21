package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import wpjsp.dao.BulletinDao;
import wpjsp.dao.ScrapDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;
import wpjsp.model.JournalListView;

public class GetScrapListService {
	
	private static GetScrapListService instance =	new GetScrapListService();

	public static GetScrapListService getInstance() {
		return instance;
	}

	private GetScrapListService() {}

	private static final int MESSAGE_COUNT_PER_PAGE = 10	;
	
	//개인 스크랩 목록 가져오기
	public JournalListView getScrapList(int pageNumber, int idnum)
			throws Exception
	{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "hh";
			String dbPass = "1215";
			Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		int currentPageNumber = pageNumber;
		try {
			
			ScrapDao scrapDao =	ScrapDao.getInstance();
			int journalTotalCount = scrapDao.sselectCount(conn, idnum);

			List<Bulletin> journalList = null;
			int firstRow = 0;
			int endRow = 0;
			if (journalTotalCount > 0) {
				firstRow = (pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				journalList = scrapDao.scrapSelectList(conn, idnum,firstRow, endRow);
			} else {
				currentPageNumber = 0;
				journalList = Collections.emptyList();
			}
			return new JournalListView(journalList,
					journalTotalCount, currentPageNumber,
					MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new Exception("GetScrapListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
