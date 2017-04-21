<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.model.DiaryListView"%>
<%@page import="wpjsp.service.GetDiaryListSer"%>
<%@page import="wpjsp.service.GetMemberInfoService"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<%
	request.setCharacterEncoding("euc-kr");
%>
<script type="text/javascript">

function logout(){
	var result = window.confirm('가니?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
}

$(function(){
	//var h = window.alert($(".dcover").css('height'));
	//if(h != $(".dcover").css('height'));
	{}
	});
</script>

</head>
<body>

<div id="mydiary" class="color yellow pagebox">

	<!-- start : Container -->
	<div class="container">
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>My Diary</span></h2>

			</div>	

		</div>
		<!-- end: Page Title -->
	
			<div id="filters">
				<ul class="option-set" data-option-key="filter">
					<li><a href="#filter" class="selected" data-option-value="*">All</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".internal">국내</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".foreign">해외</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".full">완성</a></li>
				</ul>
			</div>
<%
//페이지 수 저장 -- 메인에서  include할때 변수 수정해주기
	String DpageNumberStr = request.getParameter("page");
	
	int DpageNumber = 1;
	
	//넘어온 페이지 값이 없으면 1로 설정
	if (DpageNumberStr != null) {
		DpageNumber = Integer.parseInt(DpageNumberStr);
	}
	
		GetDiaryListSer getdiarylist = GetDiaryListSer.getInstance();
		DiaryListView viewDatad = getdiarylist.getmDiaryList(DpageNumber, userNum);
		
		SimpleDateFormat dateform = new SimpleDateFormat("yyyy/MM/dd");
%>

<%		
		if(viewDatad.isEmpty()){
%>
등록된 일기가 없습니다.
<% } else { 
		%>

	<!-- start : diary list -->
	<div id="diary-wrapper" class="row-fluid">

<%
	Diary diaryList = new Diary();
	for(int i=0 ;i<viewDatad.getDiaryTotalCount();i++){
		diaryList = viewDatad.getDiaryList().get(i);
		
		String basicClass = "span4 diary-item html5 css3 responsive ";
		String className = null;
		if(diaryList.getLocation().contains("i")){
			className = basicClass+"internal";
		} else if(diaryList.getLocation().contains("o")){
			className = basicClass+"foreign";
		}
%>
			
		<div id="diary" class="<%=className%>">
			<div class="picture">
			<a href="diarydays.jsp?dvol=<%= diaryList.getDiary_volum()%>&mnum=<%= userNum %>" 
			title="Title">
			<% String path = "upload/"+diaryList.getCover(); %>
			<img src=<%=path %> alt="" class="dcover"/>
			<div class="image-overlay-link"></div></a>
				<div class="item-description alt">
					<h5><a href="diarydays.jsp?dvol=<%= diaryList.getDiary_volum() %>">
					<%=diaryList.getDiary_title() %></a></h5>
					<p>
					<%=dateform.format(diaryList.getStart_day()) %>-<%=dateform.format(diaryList.getEnd_day()) %><br>
					<b><%=connum.getMemberId(diaryList.getMember_num())%></b> 
					vol.<%=diaryList.getDiary_volum() %> 
					</p>
				</div>
			</div>
		</div>

<% 			}
		} 
%>
	</div>
	<!-- end : diary list -->

<center>
<button class="button btn-warning" onclick="window.location='diaryList.jsp'">
<span>Other's Diary</span></button> 
<button class="button btn-warning" onclick="window.location='writeDiary.jsp'">
<span>New Diary</span></button>
</center>

		</div>	
		<!-- end : Wrapper -->

	</div>	
	<!-- end : Container -->

	
</div>

</body>
</html>