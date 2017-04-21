package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import wpjsp.dao.ReplyDao;
import wpjsp.dao.ScrapDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;
import wpjsp.model.JournalListView;
import wpjsp.model.Reply;
import wpjsp.model.ReplyListView;

public class GetReplyListService {

	private static GetReplyListService instance =	new GetReplyListService();

	public static GetReplyListService getInstance() {
		return instance;
	}

	private GetReplyListService() {}

	private static final int MESSAGE_COUNT_PER_PAGE = 50	;
	
	//댓글 목록 가져오기
	public ReplyListView getReplyList(int pageNumber, int jnum)
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
				ReplyDao replyDao = ReplyDao.getInstnace();
				int replyTotalCount = replyDao.rselectCount(conn, jnum);
				
				List<Reply> replyList = null;
				int firstRow = 0;
				int endRow = 0;
				if(replyTotalCount > 0){
					firstRow = (pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
					endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
					replyList = replyDao.replySelectList(conn, jnum,firstRow, endRow);
				} else {
					currentPageNumber = 0;
					replyList = Collections.emptyList();
				}
				return new ReplyListView(replyList,
						replyTotalCount, currentPageNumber,
						MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
			} catch (SQLException e) {
				throw new Exception("GetReplyListService error : " + e.getMessage(), e);
			} finally {
				JdbcUtil.close(conn);
			}	
	}
	
	public Reply getReply(int jnum, int renum)
			throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try{
			ReplyDao replyDao = ReplyDao.getInstnace();
			
			Reply reply = new Reply();
			reply = replyDao.getReply(conn, jnum, renum);
			return reply;
		} catch (SQLException e) {
			throw new Exception("GetReplyListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}	

	}
	
	
}
