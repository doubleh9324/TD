
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="wpjsp.service.JoinService"%>
<%@ page import="wpjsp.model.Member"%>
<%@ page import="java.sql.*"%>



<%
	request.setCharacterEncoding("euc-kr");
%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript">
function formCheck(){
	
	//null check
	if(document.joinForm.member_name.value=="") window.alert("이름!")
	else if(document.joinForm.member_pwinfo.value=="") window.alert("질문작성")
	else if(document.joinForm.member_pwan.value=="") window.alert("답해죠")
	//중복 check
	else if(document.joinForm.result.value !="yes") window.alert("중복화깅~")
	//일치 check
	
	//비밀번호, 확인 창 비워주기
	else if(document.joinForm.ok.value != "~일치~") window.alert("비밀번호 다시~")
	else document.joinForm.submit()
	
}

function checkId(){
	var sid = document.joinForm.member_id.value
	window.open("checkID.jsp?member_id="+sid, "", "width=400 height=150")
}

function JoinPwC(){
	var pw = document.joinForm.member_pw.value
	var pwc =document.joinForm.PWC.value
	
	if(pw == pwc)
		document.getElementById("ok").value = "~일치~"
}
</script>

<style type="text/css">

body{
background-color:#3C5064;
font-family:돋움;
color:#E4E8EB;
font-size:12px;
}

input[type=submit], input[type=button]{
border:0px; 
background-color:transparent;
font-family:돋움;
color:#E4E8EB;
font-size:12px;
margin:5px; 
left:50%
}

input[type=text], input[type=password]{
border:1px solid #E4E8EB;
background-color:transparent;
font-family:돋움;
color:#E4E8EB;
font-size:12px;
text-align:center;
}

p{
text-align:center;
}

img{
display:block;
margin-left:auto;
margin-right:auto;
top:50%;
margin-top: 160px;
}

table.typeJoin {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
  	margin : 20px 10px;
  	width:450px;
}

table.typeJoin th {
	width: 800px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    text-align:center;
}

table.typeJoin td {
	width: 300px;
	padding: 10px;
	vertical-align:top;
	border-bottom: 1px double #ccc;
}


div{
	display:table-cell;
	vertical-align:middle;
	text-align:center;
	margin-top:100px;
	border: 2px double #FE786B;
	padding: 10px;
}




</style>



</head>
<body>
<center>
<div class = "container">
<h2>Join us!</h2>
	<form action="Join2.jsp" method="post" name = "joinForm" autocomplete="off">
	
	<table class="typeJoin">
		<tr>
			<th scope="row">이름</th>
			<td><input type="text" name="member_name" size="20"></td>
			<td>@</td>
		</tr>
		<tr>
			<th scope="row">ID</th>
			<td><input type="text" id = "member_id" name="member_id" size="20"></td> 
			<td><input type="button" id = "idcheck" name="idcheck" value="아이디 중복 확인 " onclick="javascript:checkId();"><br>
			<input type ="hidden" id = result value ="no"></td>
		</tr>
		<tr>
			<th scope="row">PW</th>
			<td><input type="password" name="member_pw" size="20"></td>
			<td>@</td>
		</tr>
		<tr>
			<th scope="row">PW확인</th>
			<td><input type="password" name="PWC" onKeyUp="JoinPwC()"size="20"></td>
			<td><input type="text" id="ok" value="같은 비밀번호 입력" readonly style="border: 0px;"></td> 
		</tr>
		<tr>
			<th scope="row">질문</th>
			<td><input type="text" name="member_pwinfo" size="20"></td>
			<td>@</td>
		</tr>
		<tr>
			<th scope="row">질문의 답</th>
			<td><input type="text" name="member_pwan" size="20"></td>
			<td>@</td>
		</tr>
		<tr>
		<th scope="row">Email</th>
		<td><input type="text" name="member_email" size="20"></td>
		<td></td>
		</tr>
	</table>	
	<input type="button" value="회원가입" onClick="javascript:formCheck()">
</form>
</div>
</center>





</body>
</html>
