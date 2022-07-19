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
<title>Senarai AJK</title>
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
    
    <%-- THIS COMMITTEE LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="thisCom">
		SELECT * FROM committee WHERE committeeid = <%=committee_id %>
	</sql:query>
	<%----------------------------------------------------- COMMITTEE LIST --%>	
	
    <%-- COMMITTEE LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="result">
		SELECT * FROM committee ORDER BY committeeid
	</sql:query>
	<%----------------------------------------------------- COMMITTEE LIST --%>	
	
	<%-- MANAGEMENT LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="managementResult">
		SELECT * FROM management ORDER BY committeeid
	</sql:query>
	<%----------------------------------------------------- MANAGEMENT LIST --%>
	
	<%-- VOLUNTARY LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="voluntaryResult">
		SELECT * FROM voluntary ORDER BY committeeid
	</sql:query>
	<%----------------------------------------------------- VOLUNTARY LIST --%>	
	
	<c:if test="">
	</c:if>	
    
    <h1>SENARAI AJK</h1>
    
    <button name="register" onclick="location.href='staff-choice.jsp'">DAFTAR AJK BARU</button>
    <br><br><br>
    
    <form method="post">
    <table>
    	<tr>
    		<th>No.</th>
    		<th>ID AJK</th>
    		<th>Nama AJK</th>
    		<th>Skop Kerja</th>
    		<th>No. Telefon</th>
    		<th>Tindakan</th>
    	</tr>
    	<%-- Management --%>
    	<c:forEach var="management" items="${managementResult.rows}">
    	<tr>
    		<% counter++; %>
    		<td><%=counter%></td>
    		<td><c:out value="${management.committeeID}"/></td>
    		<td><c:out value="${management.committeefullname}"/></td>
    		<td><c:out value="${management.managementposition}"/></td>
    		<td><c:out value="${management.committeephonenum}"/></td>
    		<td>
    			<button name="update" formaction="CommitteeHandler?action=viewManagement&ID=${management.committeeID}">KEMASKINI</button>
    			<c:forEach var="thisCom" items="${thisCom.rows}">
    				<c:if test="${management.committeeid != thisCom.committeeid}">
    					<c:if test="${management.managementposition != 'Pengerusi'}">
    						<button name="delete" formaction="CommitteeHandler?action=deleteManagement&ID=${management.committeeID}">PADAM</button>
    					</c:if>
    				</c:if>
    			</c:forEach>
    		</td>
    	</tr>
    	</c:forEach>
    	<%-- Voluntary --%>
    	<c:forEach var="voluntary" items="${voluntaryResult.rows}">
    	<tr>
    		<% counter++; %>
    		<td><%=counter%></td>
    		<td><c:out value="${voluntary.committeeID}"/></td>
    		<td><c:out value="${voluntary.committeefullname}"/></td>
    		<td><c:out value="${voluntary.voluntaryrole} (SUKARELAWAN)"/></td>
    		<td><c:out value="${voluntary.committeephonenum}"/></td>
    		<td>
    			<button name="update" formaction="CommitteeHandler?action=viewVoluntary&ID=${voluntary.committeeID}">KEMASKINI</button>
				<button name="delete" formaction="CommitteeHandler?action=deleteVoluntary&ID=${voluntary.committeeID}">PADAM</button>
    		</td>
    	</tr>
    	</c:forEach>
    </table>
    </form>
</body>
</html>