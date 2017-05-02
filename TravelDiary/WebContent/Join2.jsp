<%@page import="wpjsp.service.JoinSer"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="wpjsp.model.Member"%>
<%@ page import="java.sql.*"%>



<%
	request.setCharacterEncoding("euc-kr");
%>


<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />


<html>
<head>
<title>가입</title>


</head>
<body>
<jsp:setProperty name="member" property="*" />

<%

	out.println("<script>alert('가입이 완료되었습니다.'); </script>");
	
	//받아온 정보 DB에 저장
//	JoinService joinservice = JoinService.getInstance();	
//	joinservice.Join(member);

	JoinSer joinservice = JoinSer.getInstance();	
	joinservice.Join(member);

//	response.sendRedirect("First.jsp");	
%>

<%= member.getMember_name() %> 님 환영합니다 원한다면 들어오시죠 <br>
ID : <%= member.getMember_id() %> <br>
EMAIl : <%= member.getMember_email() %> <br>
비밀번호 찾기 질문 : <%= member.getMember_pwinfo() %> <br>
비밀번호 찾기 답변 : <%= member.getMember_pwan() %> <br>

<input type = "button" value = "Main" onclick = "location.href='LoginJudge.jsp';" >





</body>
</html>
