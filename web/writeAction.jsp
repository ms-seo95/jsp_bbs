<%@page import="bbs.BbsDAO"%>
<%@page import="sun.font.Script"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
    
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- JS 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Write</title>
	</head>
	<body>
		<%
			try{
				// 세션을 활용하여 이미 로그인한 경우 회원가입을 막음
				String userID = null;
				if (session.getAttribute("userID") != null) {
					userID = (String) session.getAttribute("userID");
				}
				if (userID == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('로그인을 하세요.')");
					script.println("location.href = 'login.jsp'");
					script.println("</script>");
					script.flush();
				}
				else {
					if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {					
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('입력이 안 된 사항이 있습니다.')");
							script.println("history.back()");
							script.println("</script>");
							script.flush();
					}else {
						BbsDAO bbsDAO = new BbsDAO();
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
						if (result == -1) {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패했습니다..')");
							script.println("history.back()");
							script.println("</script>");
							script.flush();
						}
						else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'bbs.jsp'");
							script.println("</script>");
							script.flush();
						}
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		%>
	</body>
</html>