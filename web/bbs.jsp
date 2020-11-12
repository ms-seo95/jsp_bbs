<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="bbs.Bbs"%>
<%@page import="bbs.BbsDAO"%>
<%@page import="java.util.ArrayList"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 1L);
%>
<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=deivce-width", initial-scale="1">
	<link rel="stylesheet" href="./css/bootstrap.css">

	<%-- <a> 태그의 색상을 변경 --%>
	<style type="text/css">
		a, a:hover {
			color: #000000;
			text-decoration: none;
		}
	</style>

	<title>BBS</title>
</head>
<body>
	<%
		// userID
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		// page
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" 
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" 
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			<!-- <span class="icon-bar"></span> -->
			</button>
			<!-- 메뉴의 홈페이지 이름 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			
			<!-- userID의 세션 값이 null일 경우에만 로그인 및 회원가입이 가능하게 설정 -->
			<%
				if (userID == null) {
			%>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			
			<%		
				} else {
			%>
			
			<!-- 로그인이 되어있는 경우 회원관리라는 옵션을 넣어 보이게 함 -->	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; bolder: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);

						for (int i = 0; i < list.size(); i++) {
							if (list.get(i).getBbsID() < 0) continue;	// 삭제한 게시글의 경우 표시X
					%>
					<tr>
						<td style="background-color: #eeeeee; text-align: center;"><%=list.get(i).getBbsID()%></td>
						<td style="background-color: #eeeeee; text-align: center;"><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getUserID()%></a></td>
						<td style="background-color: #eeeeee; text-align: center;"><%=list.get(i).getBbsTitle()%></td>
						<td style="background-color: #eeeeee; text-align: center;">
							<%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분"%>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if (bbsDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	
</body>
</html>