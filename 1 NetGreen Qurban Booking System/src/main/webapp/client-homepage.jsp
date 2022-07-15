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
<title>Laman Utama</title>
</head>
<body>
	<%!
		int client_id;
	%>

<%-- LOGIN REQUIREMENT  -------------------------------------------------%>

	<%
	//user has not logged in
	if(session.getAttribute("clientID") == null) {
		
		//redirect user to login page
		response.sendRedirect("login.jsp");
	}
	else {
		
		// Get client
		client_id = (int)session.getAttribute("clientID");
	}
	%>
<%------------------------------------------------- LOGIN REQUIREMENT  --%>

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
				<form method="post"><button style="margin-left:20px;" formaction="LoginHandler?action=logout">Log Keluar</button></form>
			</div>
		</div>

		<h1>SISTEM TEMPAHAN KORBAN</h1>
		<h3>Selamat Datang, <c:out value="${client.clientfullname}"/></h3>
		
		<p>Sudahkah anda berkorban?</p>
	</c:forEach>
	
<form method="post">
	<%
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
	%>
	<input type="hidden" name="bookingDate" value="<%= dateToday %>">
	<input type="hidden" name="clientID" value="<%= client_id %>">
	<button name="tobookinglist" formaction="BookingHandler?action=toBookingList">Senarai Tempahan Korban</button>
	
	<button type="submit" formaction="BookingHandler?action=createBooking">Buat Tempahan Korban</button>
</form>

</body>
</html>