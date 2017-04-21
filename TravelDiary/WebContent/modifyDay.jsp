<%@page import="wpjsp.service.GetDiaryInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.service.ReadDaySer"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.service.ReadJournalService"%>
<%@page import="wpjsp.model.JournalListView"%>
<%@page import="wpjsp.model.Bulletin"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script type="text/javascript">
	function checkF(){
		var title = document.getElementById("title").value;
		var day = document.getElementById("day").value;
		
		if(title == ""){
			window.alert("������ �Է����ּ���");
		} else if(day == ""){
			window.alert("������ �Է����ּ���");
		} else
			document.moform.submit();
	}
	
	//�������� �ε�Ǹ� get������� �޾ƿ� dvol�� input dvol�� ������ �ҷ��ͼ� select �ʱ�ȭ , ��¥ ����
	$(document).ready(function(){
		var dvol = $("#dvol").val();
		
	    $("#seldiary").val(dvol).prop("selected", true);
	    
	    $("#day_time").datepicker({
	    	dateFormat: 'dd/mm/yy',
	    	//input sday�� ����� ������ �ּ� ,�ִ� ��¥ ����
	    	minDate : new Date(document.getElementById("sday").value),
	    	maxDate : new Date(document.getElementById("eday").value)
	    });
	});
	
function pickdate(obj){
	
	$(obj).datepicker().datepicker("show");
}	
</script>
	<style type="text/css">
/*Custom*/
.d-title {
	width: 80%;
}

.selloc{
	width: 15%;
}

.selloca{
	width: 25%;
}

.write-wrap{
	padding: 10px 10px 10px 10px;
}

.write-wrap .button{
	right:0;
}


.daypick{
	width:30%;
}

table th{
padding : 0 0 0 10px;
width:20%}

table td{
padding : 0 0 0 10px;}

#write{
width : 80%;}

textarea {

}

</style>

</head>
<body>
<!-- start : page - modify day -->

	<!-- start : Container -->
	<div id="modifyday" class="container color white ppagebox">	
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>Modify Day</span></h2>

			</div>

		</div>
		
<%
	int dnum = Integer.parseInt(request.getParameter("dnum"));
	int dvol = Integer.parseInt(request.getParameter("dvol"));
	int userNum = Integer.parseInt(request.getParameter("userNum"));
	Days day = new Days();
	String sday = null;
	String eday = null;
	
	SimpleDateFormat dateform = new SimpleDateFormat("dd/MM/yyyy");
	
	GetDiaryInfoSer diaryinfoSer = GetDiaryInfoSer.getInstance();
	Diary diaryinfo = diaryinfoSer.getDiaryInfo(dvol, userNum);
	
	ReadDaySer readdaySer = ReadDaySer.getInstance();
	day = readdaySer.read(dnum, userNum);
%>


<div class="container write-wrap" style="border:none;">
<form action="modifyDay2.jsp" method="post" name = "moform">
<input type="hidden" value="<%= day.getDay_num() %>" id="dnum" name="dnum">
	<table class="write" style="width:100%;">
	<tr>
		<th>Title</th>
		<td colspan="2">
			<input type="text" value="<%= day.getDay_title() %>" 
			name="day_title" id="title"  style="width:100%; size: 20">
		</td>
	</tr>
	<tr>
		<th>Diary</th>
		<td>

	<input id="dvol" type="hidden" value="<%=dvol %>" name="dvol">
	
		<select id="seldiary" name="dvol" style="width:100%" disabled>
				<option value=1><%= diaryinfo.getDiary_title() %></option>
		</select>
		</td>
		<td>
		<input id="sday" type="hidden" value="<%= diaryinfo.getStart_day() %>">
		<input id="eday" type="hidden" value="<%= diaryinfo.getEnd_day() %>">
		<input type="text" value="<%= dateform.format(day.getDay_time()) %>" name="day_time" id="day_time"
		style="width:30%; height:100%; text-align: center" onClick="javascript:pickdate(this)"><br>
		</td>
	</tr>
	<tr>
		<th>Text</th>
		<td colspan="2">
		<textarea rows="" cols="" name="day" id="day" style="width:100%;height:300px;"><%= day.getDay() %></textarea></td>
	</tr>
	</table>

<center><button class="button btn-danger" onclick="javascript:checkF();"><span>Modify!</span></button></center>
</form>
</div>

		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!--  end : page - modify day -->
</body>
</html>