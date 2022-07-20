<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.ConnectionManager" %>
<%@ page import="java.io.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Senarai Klien</title>
</head>
<body>
	<%!
		// MANAGER ONLY
		int counter = 0;
		int committee_id;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
	%>
	
<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>
<%-- SIDEBAR MANAGEMENT DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="committeeResult">
		SELECT * FROM management WHERE committeeid = <%=committee_id%>
	</sql:query>
<%----------------------------------------------------- SIDEBAR MANAGEMENT DETAILS --%>	
	
	<c:forEach var="committee" items="${committeeResult.rows}">
			<c:out value="${committee.committeefullname}"/><br>
			<c:out value="${committee.managementposition}"/>
	</c:forEach>
	
	<%-- HEADER --%>
	<h2>NETGREEN</h2><br><br>
	
	<%-- NAVIGATION BAR --%>
	<a href="index-committee.jsp" onclick="location.href='index-committee.jsp'">Laman Utama</a><br>
    <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'">Senarai Tempahan</a><br>
    <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'">Senarai Maklumat Haiwan</a><br>
    <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'">Senarai AJK</a><br>
    <a href="client-list.jsp" onclick="location.href='client-list.jsp'">Senarai Klien</a><br>
    <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'">  Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">  Log Keluar</a><br>
    
    <br><br>
    
    <%-- CLIENT LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="clientList">
		SELECT * FROM client
	</sql:query>
	<%----------------------------------------------------- CLIENT LIST --%>
	
		
    <h1>SENARAI KLIEN</h1>
    
    <form method="post">
    	<table>
    		<tr>
    			<th>No.</th>
    			<th>ID Klien</th>
    			<th>Nama</th>
    			<th>No. Telefon</th>
    			<th>Tindakan</th>
    		</tr>
    		<%-- Klien --%>
    		<c:forEach var="client" items="${clientList.rows}">
    		<tr>
    			<% counter++; %>
    			<td><%=counter%></td>
    			<td><c:out value="${client.clientid}"/></td>
    			<td><c:out value="${client.clientfullname}"/></td>
    			<td><c:out value="${client.clientphonenum}"/></td>
    			<td>
    				<button name="update" formaction="ClientHandler?action=viewClient&ID=${client.clientid}">KEMASKINI</button>
					<button name="delete" formaction="ClientHandler?action=deleteClient&ID=${client.clientid}">PADAM</button>
    			</td>
    		</tr>
    		</c:forEach>
    		
    	</table>
    </form>
    

</body>
</html>