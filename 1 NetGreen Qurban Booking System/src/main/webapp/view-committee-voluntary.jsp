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
<title>KEMASKINI AJK</title>
</head>
<body>	
	<%!
		// MANAGER ONLY
		int counter = 0;
		int committee_id;
		int ID_committee;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
	
		ID_committee = (int)request.getAttribute("ID_committee");
		
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
    
    
    <%-- VOLUNTARY DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="voluntaryResult">
		SELECT * FROM voluntary WHERE committeeid = <%=ID_committee%>
	</sql:query>
	<%--------------------------------------- VOLUNTARY DETAILS --%>	
    
    <h3>MAKLUMAT AKAUN (SUKARELAWAN)</h3><br><br>
    
    <form method="post">
    	<table>
    	<c:forEach var="voluntary" items="${voluntaryResult.rows}">
    		<tr>
    			<th>ID Akaun:</th>
    			<td><c:out value="${voluntary.committeeid}"/></td>
    		</tr>
    		<tr>
    			<th>Nama Penuh:</th>
    			<td><c:out value="${voluntary.committeefullname}"/></td>
    		</tr>
    		<tr>
    			<th>No Telefon:</th>
    			<td><c:out value="${voluntary.committeephonenum}"/></td>
    		</tr>
    		<tr>
    			<th>Tarikh Lahir:</th>
    			<td><c:out value="${voluntary.committeebirthdate}"/></td>
    		</tr>
    		<tr>
    			<th>Alamat:</th>
    			<td><c:out value="${voluntary.committeeaddress}"/></td>
    		</tr>
    		<tr>
    			<th>Email:</th>
    			<td><c:out value="${voluntary.committeeemail}"/></td>
    		</tr>
    		<tr>
    			<th>Kata Laluan:</th>
    			<td><input type="password" value="${voluntary.committeepassword}" readonly></td>
    		</tr>
    		<tr>
    			<th>Skop Kerja:</th>
    			<td><c:out value="${voluntary.voluntaryrole}"/></td>
    		</tr>
    		<tr>
    			<th>Kadar Setiap Jam:</th>
    			<td><c:out value="${voluntary.hourlyrate}"/></td>
    		</tr>
    		<tr>
    			<th>Pengurus:</th>
    				
				 <%-- VOLUNTARY DETAILS ---------------------------------------%>
				<sql:query dataSource="${qurbanDatabase}" var="managerResult">
					SELECT * FROM management WHERE committeeid = ${voluntary.managerid}
				</sql:query>
				<%--------------------------------------- VOLUNTARY DETAILS --%>
				<c:forEach var="manager" items="${managerResult.rows}">
    			<td><c:out value="${manager.committeefullname}"/></td>
    			</c:forEach>
    		</tr>
    	</c:forEach>
    	</table><br>
    	
		<button name="back" formaction="committee-list.jsp">KEMBALI</button>
		<button type="submit" name="update" formaction="CommitteeHandler?action=editVoluntary&ID=<%=ID_committee%>">KEMASKINI</button>
 	</form>

</body>
</html>