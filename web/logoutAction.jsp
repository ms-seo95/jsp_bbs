<%@page import="sun.font.Script"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
	
<%@page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Logout</title>
	</head>
	<body>
		<%	
			session.invalidate();	// 세션을 빼앗아 로그아웃 시킴
		%>
		
		<script type="text/javascript">
			location.href = "main.jsp";
		</script>
	</body>
</html>