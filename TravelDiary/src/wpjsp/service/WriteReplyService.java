package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.dao.ReplyDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;
import wpjsp.model.Reply;

public class WriteReplyService {
	
	private static WriteReplyService instance = new WriteReplyService();

	public static WriteReplyService getInstance() {
		return instance;
	}

	private WriteReplyService() {	}

	public void write(Reply reply) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			ReplyDao replyDao = null;
			replyDao = ReplyDao.getInstnace();
			
			replyDao.newReply(conn, reply);
			
		} catch (SQLException e) {
			throw new Exception("writeReplyService error: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}

	}
}
