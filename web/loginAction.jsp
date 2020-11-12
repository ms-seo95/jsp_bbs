<%@page import="sun.font.Script"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- JS 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Login</title>
	</head>
	<body>
		<%	
			try{
				// 세션을 활용하여 이미 로그인한 경우 로그인을 막음
				String userID = null;
				if (session.getAttribute("userID") != null) {
					userID = (String) session.getAttribute("userID");
				}
				if (userID != null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 로그인되어 있습니다.')");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
					script.flush();
				}
				
				UserDAO userDAO = new UserDAO();
				PrintWriter script = response.getWriter();
				
				int result = userDAO.login(user.getUserID(), user.getUserPassword());
				if (result == 1) {
					session.setAttribute("userID", user.getUserID());
					script.println("<script>");
					script.println("l" +
							"ocation.href = 'main.jsp'");
					script.println("</script>");
				}
				else if (result == 0) {
					script.println("<script>");
					script.println("alert('비밀번호가 일치하지 않습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else if (result == -1) {
					script.println("<script>");
					script.println("alert('존재하지 않는 아이디입니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else if (result == -2) {
					script.println("<script>");
					script.println("alert('데이터베이스 오류가 발생했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
				script.flush();
			}catch(Exception e) {
				e.printStackTrace();
			}
		%>
	</body>
</html>