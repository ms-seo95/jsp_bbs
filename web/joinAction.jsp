<%@page import="sun.font.Script"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- JS 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userPasswordCheck"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Join</title>
	</head>
	<body>
		<%
			try{
				// 세션을 활용하여 이미 로그인한 경우 회원가입을 막음
				String userID = null;
				if (session.getAttribute("userID") != null) {
					userID = (String) session.getAttribute("userID");
				}
				if (userID != null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("이미 로그인되어 있습니다.");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
					script.flush();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		
			if (user.getUserID() == null || user.getUserPassword() == null || 
				user.getUserPasswordCheck() == null || user.getUserName() == null ||
				user.getUserGender() == null || user.getUserEmail() == null) {
									
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
			}else {
				if (!user.getUserPassword().equals(user.getUserPasswordCheck())) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('비밀번호가 일치하지 않습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
				try{
					UserDAO userDAO = new UserDAO();
					PrintWriter script = response.getWriter();
					
					int result = userDAO.join(user);
					if (result == -1) {
						script.println("<script>");
						script.println("alert('이미 존재하는 아이디입니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						session.setAttribute("userID", user.getUserID());
						script.println("<script>");
						script.println("location.href = 'main.jsp'");
						script.println("</script>");
					}
					
					script.flush();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		%>
	</body>
</html>