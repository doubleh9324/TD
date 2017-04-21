package wpjsp.service;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import wpjsp.dao.BulletinDao;
import wpjsp.model.Member;
import wpjsp.model.Bulletin;
import wpjsp.model.JournalListView;

import wpjsp.jdbc.JdbcUtil;

public class GetJournalListService {
	private static GetJournalListService instance =	new GetJournalListService();

	public static GetJournalListService getInstance() {
		return instance;
	}

	private GetJournalListService() {}

	private static final int MESSAGE_COUNT_PER_PAGE = 10	;
	
	//�� ��� ��������
	public JournalListView getJournalList(int pageNumber)
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
			
			BulletinDao bulletinDao =	BulletinDao.getInstnace();
			int journalTotalCount = bulletinDao.selectCount(conn);

			List<Bulletin> journalList = null;
			int firstRow = 0;
			int endRow = 0;
			if (journalTotalCount > 0) {
				firstRow = (pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				journalList = bulletinDao.journalSelectList(conn, firstRow, endRow);
			} else {
				currentPageNumber = 0;
				journalList = Collections.emptyList();
			}
			return new JournalListView(journalList,
					journalTotalCount, currentPageNumber,
					MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new Exception("GetJournalListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
