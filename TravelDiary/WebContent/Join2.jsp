<%@page import="wpjsp.service.JoinSer"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="wpjsp.service.JoinService"%>
<%@ page import="wpjsp.model.Member"%>
<%@ page import="java.sql.*"%>



<%
	request.setCharacterEncoding("euc-kr");
%>


<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />


<html>
<head>
<title>����</title>


</head>
<body>
<jsp:setProperty name="member" property="*" />

<%

	out.println("<script>alert('������ �Ϸ�Ǿ����ϴ�.'); </script>");
	
	//�޾ƿ� ���� DB�� ����
//	JoinService joinservice = JoinService.getInstance();	
//	joinservice.Join(member);

	JoinSer joinservice = JoinSer.getInstance();	
	joinservice.Join(member);

//	response.sendRedirect("First.jsp");	
%>

<%= member.getMember_name() %> �� ȯ���մϴ� ���Ѵٸ� �������� <br>
ID : <%= member.getMember_id() %> <br>
EMAIl : <%= member.getMember_email() %> <br>
��й�ȣ ã�� ���� : <%= member.getMember_pwinfo() %> <br>
��й�ȣ ã�� �亯 : <%= member.getMember_pwan() %> <br>

<input type = "button" value = "Main" onclick = "location.href='LoginJudge.jsp';" >





</body>
</html>
