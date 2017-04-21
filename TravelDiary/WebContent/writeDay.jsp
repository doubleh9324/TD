<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="wpjsp.model.Member"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.model.DiaryListView"%>
<%@page import="wpjsp.service.GetDiaryListSer"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>

		
	<title>�� �̾߱� ����</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>



<script type="text/javascript">
function checkF(){
	var title = document.getElementById("title").value;
	var day = documant.getElementById("day").value;
	
	if(title == ""){
		window.alert('������ �Է����ּ���');
		return false;
	} else if(day == ""){
		window.alert('������ �Է����ּ���');
		return false;
	} else
		return true;
}

function setday() {

	//select�� dvol ã�ƿͼ� day���� �缳��
	var dvol = $("dvol").val();
	var ndvol = $("#seldiary option:selected").val();
	
	if(dvol != ndvol){
		window.location = "writeDay.jsp?dvol="+ndvol;
	}
}

function pickdate(obj){
	
	$(obj).datepicker().datepicker("show");

}
	
//�������� �ε�Ǹ� get������� �޾ƿ� dvol�� input dvol�� ������ �ҷ��ͼ� select �ʱ�ȭ 
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
<!-- start : page - write day -->

	<!-- start : Container -->
	<div id="diarylist" class="container color yellow ppagebox">

	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>New Day</span></h2>

			</div>	

		</div>
<div class="container write-wrap" style="border:none;">
<form action = "writeDay2.jsp" method = "post" onsubmit="return checkF();">
<table class="write" style="width:100%;">

	<tr>
		<th>Title</th>
		<td colspan="2">
			<input type="text" name="day_title" id="title" style="width:100%; size: 20">
		</td>
	</tr>
	<tr>
		<th>Diary</th>
		<td>
<%
		String userId = (String)session.getAttribute("USERID");
		int dvol = Integer.parseInt(request.getParameter("dvol"));
		int ndvol = 0;
		//id�� ��� ���� ��������
		GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
		Member memberInfo = getmemberinfo.getMemberInfo(userId);
		
		int userNum = memberInfo.getMember_num();
		
		GetDiaryListSer diarylistSer = GetDiaryListSer.getInstance();
		DiaryListView viewdata = diarylistSer.getmDiaryList(1, userNum);
		
		SimpleDateFormat dateform = new SimpleDateFormat("yyyy, MM, dd");
		
%>
			<input id="dvol" type="hidden" value="<%=dvol %>">
			<input id="ndvol" type="hidden">
			
			
<%
		String sday = null;
		String eday = null;
		
		//������ ���̾�� ������
		if(dvol!=0){
			for(Diary diaryList : viewdata.getDiaryList()){
				if(diaryList.getDiary_volum()==dvol){
					sday = dateform.format(diaryList.getStart_day());
					eday = dateform.format(diaryList.getEnd_day());
				}
			}
		}
%>
			<select id="seldiary" name="dvol" onchange="javascript:setday()" style="width:100%">
				<option value=0>����</option>
<%				
				for(Diary diaryList : viewdata.getDiaryList()){
%>
					<option value=<%=diaryList.getDiary_volum()%>><%=diaryList.getDiary_title()%></option>

<% 					
				}
%>
					</select>
		</td>
		<td>
		
		<input id="sday" type="hidden" value="<%= sday %>">
		<input id="eday" type="hidden" value="<%= eday %>">
		<input type="text" value="��¥" name="day_time" id="day_time" 
		style="width:30%; height:100%; text-align: center" onClick="javascript:pickdate(this)"><br>
		</td>
	</tr>
	<tr>
		<th>Text</th>
		<td colspan="2">
		<textarea rows="" cols="" name="day" id="day" style="width:100%;height:300px;"></textarea></td>
	</tr>
</table>
<center><span><input class="button btn-warning" type="submit" value="New!"></span></center>

</form>
</div>


		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!-- end : page - write day -->
</body>
</html>