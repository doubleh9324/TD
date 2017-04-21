<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="wpjsp.service.ReadDaySer"%>
<%@page import="wpjsp.model.Days"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "wpjsp.model.Member"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "wpjsp.jdbc.JdbcUtil"%>

<%@page buffer = "10000kb" %>


<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>Main</title>



<script type="text/javascript">
function logout(){
	var result = window.confirm('가니?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
	
}

function scrap(userNum, dnum){
	window.open("scrap.jsp?userNum="+userNum+"&dnum="+dnum,"", "width=200 height=200")
}

function deleteDay(dnum){
	var result = window.confirm('없앤다?');
	
	if(result){
		window.open("deleteDay.jsp?dnum="+dnum, "", "width=200 height=200")
		
		
	}else{}
	
	
}
</script>

</head>
<body>

<!-- start : page - read day -->

	<!-- start : Container -->
	<div id="days" class="container color white ppagebox" >
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
		
			<!-- start : Wrapper -->
			<div class="wrapper span12">
			
			<!-- start : Page Title -->
			<div id="page-title">
				
				<div id="page-title-inner">
				<h2><span>Day</span></h2>
				</div>
			</div>
			<!-- end : Page Title -->
		
		

<% 

	String userId = (String)session.getAttribute("USERID");
	
	//id로 멤버 정보 가져오기
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	Member memberInfo = getmemberinfo.getMemberInfo(userId);
	
	int userNum = memberInfo.getMember_num();
	
	Days day = new Days();
	int dnum;
	
	dnum = Integer.parseInt(request.getParameter("dnum"));
	
	ReadDaySer readdaySer = ReadDaySer.getInstance();
	day = readdaySer.read(dnum, userNum);
	
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
	int mnum = day.getMember_num();
	
%>

(<%= connum.getMemberId(userNum) %>) 님 앙영?

	<!-- start : 1st section - day view -->
	<div class="readpage-wrap" id="fixNextTag">

	<table class="table table-striped">
	<thead>
		<tr>
			<th> <%= day.getDay_num() %></th>
			<th> <%= day.getDay_title() %> </th>
			<th style="text-align: right"> <%= connum.getMemberId(day.getMember_num()) %>
		</tr>
	<thead>
	<tbody>
		<tr style="height:200px">
			<td colspan="3"> <%= day.getDay() %></td>
			
		</tr>
	</tbody>
	</table>
	</div>

	<!-- end : 1st section - day view -->
	
	<!-- start : 2st section - reply -->
	<jsp:include page="replylist.jsp" flush="false" >
		<jsp:param name = "userNum" value = "<%= userNum %>" />
		<jsp:param name = "mnum" value = "<%= mnum %>" />
	</jsp:include>
	
	<form action="writereply.jsp" id="writeReply" name="writeReply" method="post">
	<input type="hidden" name="dnum" value="<%= dnum %>" >
	<input type="hidden" name="userNum" value="<%= userNum %>" >
	<input type="text" name="reply" >
	<input class="btn-success" style="background-color: transparent; padding:0px;"type="submit" value="등록">
	</form>	
	
	<!-- end : 2st section - reply -->
	
	<!-- start : 3st section - button -->
<form name="form" method="post">

<% if(userNum == mnum){ %>
<center>
	<a onclick="javascript:window.location='modifyDay.jsp?dnum=<%=dnum%>&userNum=<%=userNum %>&dvol=<%= day.getDiary_volum() %>'" 
	class="button btn-success"><span>수정</span></a>
	<a onclick="deleteDay(<%=dnum%>)" class="button btn-success"><span>삭제</span></a>
</center>
<% } else {}%>
<center>
	<a onclick="javascript:window.location='daylist.jsp'" class="button btn-success"><span>일기목록</span></a>
	<a onclick="javascript:window.location='diarydays.jsp?dvol=<%= day.getDiary_volum() %>&mnum=<%=mnum%>'" class="button btn-success">
	<span>일기장 보기</span></a>
	<a onclick="javascript:window.location='writeDay.jsp?userNum=<%=userNum%>'" class="button btn-success">
	<span>일기쓰기</span></a>
	<button class="button btn-success" onclick="javascript:window.scrap(<%= userNum %>, <%= dnum %>)">
	<span>스크랩</span></button>
</center>
</form>

	<!-- end : 3st section - button -->

		</div>
		<!-- end : Wrapper -->
	
	</div>
	<!-- end : Container -->


<!-- end : page - read day -->

</body>
</html>
