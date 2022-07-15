<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%!
	Connection connection;
	ResultSet result;
	String SQL;
%>
<%-- LOGIN REQUIREMENT  -------------------------------------------------%>
	<%!
		int committee_id;
		String committeeType;
		String manSQL, volSQL;
		boolean checkManagement = false, checkVoluntary = false, isManager = false;
		ResultSet resultManagement, resultVoluntary;
	%>
	<%
	//user has not logged in
	if(session.getAttribute("committeeID") == null) {
		
		//redirect user to login page
		response.sendRedirect("login.jsp");
	}
	else {
		
		// Get client
		committee_id = (int)session.getAttribute("committeeID");
	}
	%>
<%------------------------------------------------- LOGIN REQUIREMENT  --%>

	<%-- DATABASE --%>
	<sql:setDataSource	var="qurbanDatabase" driver="oracle.jdbc.driver.OracleDriver"
						url="jdbc:oracle:thin:@localhost:1521:xe"
						user="netgreen"
						password="system" />
	
	<%-- SQL QUERY - DISPLAY MANAGEMENT --%>
	<sql:query dataSource="${qurbanDatabase}" var="resultMan">
	   SELECT * FROM committee JOIN management USING (committeeid) WHERE committeeid = <%=committee_id%>
	</sql:query>

	SEMUA AJK

	<br><br>
	<table style="width: 100%; border: 2px solid black; text-align: left;">
		<tr>
			<th>ID AJK</th>
			<th>Nama</th>
			<th>Email</th>
			<th>No Telefon</th>
			<th>Address</th>
			<th>Nama Pengurus</th>	
		</tr>
		<%
	try {
		connection = ConnectionManager.getConnection();
		
		SQL="SELECT c.committeeid, c.committeeemail, c.committeefullname, c.committeephonenum, c.committeeaddress, m.committeefullname FROM committee c LEFT OUTER JOIN committee m ON c.managerid = m.committeeid ORDER BY committeeid";
		
		PreparedStatement allSQL = connection.prepareStatement(SQL);
		
		result = allSQL.executeQuery();
		
		while(result.next()) {
			

%>

		<tr>
			<td><c:out value="<%=result.getString(1)%>"/></td>
			<td><c:out value="<%=result.getString(2)%>"/></td>
			<td><c:out value="<%=result.getString(3)%>"/></td>
			<td><c:out value="<%=result.getString(4)%>"/></td>
			<td><c:out value="<%=result.getString(5)%>"/></td>
			<td><c:out value="<%=result.getString(6)%>"/></td>
		</tr>
	<% 				
		}
				
	} catch (Exception e) {
		e.printStackTrace();
	}
		%>
	
	
	</table>
	
	<a href="committee-homepage.jsp">Ke Laman Utama</a>
	
	
</body>
</html>