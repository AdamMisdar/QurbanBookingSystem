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
<title>Senarai Tempahan</title>
</head>
<body>
	<%!
		int client_id;
		int counter;
	%>
	<%
		client_id = (int)session.getAttribute("clientID");
		counter = 0;
		
	%>
<%-- DATABASE -----------------------------------------------------------%>
	<sql:setDataSource	var="qurbanDatabase" driver="oracle.jdbc.driver.OracleDriver"
						url="jdbc:oracle:thin:@localhost:1521:xe"
						user="netgreen"
						password="system" />
<%----------------------------------------------------------- DATABASE --%>

<%-- CLIENT DETAILS -----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="result">
		SELECT * FROM client WHERE clientid = <%=client_id%>
	</sql:query>
<%----------------------------------------------------- CLIENT DETAILS --%>
	<c:forEach var="client" items="${result.rows}">
		<div class="header" style="width=100%; padding:10px ; background-color: #4dff88;">
			<div>
				<span style="position: absolute; right: 20px; top:25px; font-size: 20px">NETGREEN</span>
				<span><c:out value="${client.clientfullname}"/></span>
			</div>
			<div>
				<span>ID Akaun: <c:out value="${client.clientid}"/></span>
			</div>
		</div>
	</c:forEach>
	
	
	
	<%-- BOOKING DETAILS --%>
	<sql:query dataSource="${qurbanDatabase}" var="bookingResult">
		SELECT * 
		FROM payment
		JOIN booking
		USING (bookingid)
		WHERE clientid = <%=client_id%>
		ORDER BY bookingid
	</sql:query>

	<h2>SENARAI TEMPAHAN</h2>
	
	<table style="width: 100%; border: 2px solid black; text-align: center;">
		<tr>
			<th>No.</th>
			<th>Tarikh Tempah</th>
			<th>Harga Tempahan</th>
			<th></th>
		</tr>
	
	<c:forEach var="booking" items="${bookingResult.rows}">
		<% counter++; %>
		<tr>
			<td><c:out value="<%=counter%>"/></td>
			<td><c:out value="${booking.bookingdate}"/></td>
			<td><c:out value="${booking.paymenttotal}"/></td>
			<td>
				<button>Lihat</button>
			</td>
		</tr>
	</c:forEach>
	</table>
	
	<button onclick="location.href='homepage.jsp'">Ke Laman Utama</button>
</body>
</html>