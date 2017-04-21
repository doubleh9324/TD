package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;

import wpjsp.dao.ReplyDao;
import wpjsp.jdbc.JdbcUtil;

public class DeleteReplyService {
	
	private static DeleteReplyService instance = new DeleteReplyService();

	public static DeleteReplyService getInstance() {
		return instance;
	}

	private DeleteReplyService() {	}

	public void deleteReply(int mnum, int jnum, int renum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/traveldiary?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "hh";
		String dbPass = "1215";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			ReplyDao replydao = ReplyDao.getInstnace();
			replydao.delete_reply(conn, mnum, jnum, renum);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
