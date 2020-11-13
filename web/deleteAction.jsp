<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@page import="sun.font.Script"%>
<%@ page import="java.io.PrintWriter" %> <!-- JS 문장을 작성하기 위해 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

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

				// bbsID
				int bbsID = 0;
				if (request.getParameter("bbsID") != null) {	// 게시물이 존재하는 경우
					bbsID = Integer.parseInt(request.getParameter("bbsID"));
				}
				if (bbsID == 0) {	//  게시물이 존재하지 않을 경우
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('존재하지 않는 게시물입니다.')");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
					script.flush();
				}

				Bbs bbs = new BbsDAO().getBbs(bbsID);
				if (!userID.equals(bbs.getUserID())) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('권한이 없습니다.')");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
					script.flush();
				} else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.delete(bbsID);

					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 삭제에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
						script.flush();
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('삭제가 완료되었습니다.')");
						script.println("location.href='bbs.jsp'");
						script.println("</script>");
						script.flush();
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		%>
	</body>
</html>