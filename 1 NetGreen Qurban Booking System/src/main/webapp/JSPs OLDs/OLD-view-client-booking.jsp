<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.ConnectionManager" %>
<%@ page import="java.io.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Maklumat Tempahan</title>

</head>
<body>

	<%!
		int client_id;
		int booking_id;
	%>
	<%
		if (session.getAttribute("clientID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			client_id = (int)session.getAttribute("clientID");
		} 
	
		booking_id = (int)request.getAttribute("bookingID");
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
	%>
<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>

<%-- CLIENT DETAILS -----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="clientResult">
		SELECT * FROM client WHERE clientid = <%=client_id%>
	</sql:query>
<%----------------------------------------------------- CLIENT DETAILS --%>
	<%-- HEADER --%>
	<h2 style="position: absolute; right: 20px;">NETGREEN</h2><br><br>
	
	<%-- NAVIGATION BAR --%>
    <a href="index-client.jsp" onclick="location.href='index-client.jsp'">Laman Utama</a><br>
    <a href="client-booking-list.jsp" onclick="location.href='client-booking-list.jsp'">Senarai Tempahan</a><br>
    <a href="BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>" onclick="location.href='BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>'">Buat Tempahan</a><br>
    <a href="view-client-account.jsp" onclick="location.href='view-client-account.jsp'">Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">Log Keluar</a><br><br><br> <%-- TOLONG BUAT ALERT/CONFIRM FUNCTION --%>
		
	<%-- CLIENT DETAILS --%>
	<c:forEach var="client" items="${clientResult.rows}">
	NAMA: <c:out value="${client.clientfullname}" /><br>
	ID Akaun: <%=client_id%>
	</c:forEach>
	
	
	<div>
		<h2>MAKLUMAT TEMPAHAN</h2>
	</div>
	
		
	<%-- BOOKING DETAILS --%>
	<sql:query dataSource="${qurbanDatabase}" var="bookingResult">
		SELECT * FROM payment JOIN booking USING (bookingid) WHERE bookingid = <%=booking_id%>
	</sql:query>

	
	<table>
	<c:forEach var="booking" items="${bookingResult.rows}">
		<tr>
			<th>ID Tempahan</th>
			<td><c:out value="${booking.bookingid}" /></td>
		</tr>
		<tr>
			<th>Tarikh Tempahan</th>
			<td><c:out value="${booking.bookingdate}" /></td>
		</tr>
		<tr>
			<th>Jumlah Harga (RM)</th>
			<td><fmt:formatNumber type = "number" maxFractionDigits = "2" value = "${booking.paymenttotal}" /></td>
		</tr>
	</c:forEach>	
	</table>
	
	
	<%-- ANIMAL ORDER DETAILS --%>
	<h3>TEMPAHAN</h3>
	<sql:query dataSource="${qurbanDatabase}" var="animalOrderResult">
		SELECT * FROM animalorder JOIN animaldetails USING (animaldetailsid) WHERE bookingid = <%=booking_id%>
	</sql:query>
	
	<form method="post">
	<table>
	<c:forEach var="animalOrder" items="${animalOrderResult.rows}">
		<tr>
			<th>Nama Tanggungan</th>
			<th>Bahagian</th>
			<th>Harga 1 Bahagian</th>
			<th>Tindakan</th>
		</tr>
		<tr>
			<td><c:out value="${animalOrder.dependentname}" /></td>
			<td><c:out value="${animalOrder.animaltype}" /><input type="hidden" name="animalOrderID" value="${animalOrder.animalorderid}"></td>
			<td>
				<c:if test="${animalOrder.animalType == 'Lembu'}">
					<fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalOrder.animalprice/7}" />
				</c:if>
				<c:if test="${animalOrder.animalType == 'Unta'}">
					<fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalOrder.animalprice/7}" />
				</c:if>
				<c:if test="${animalOrder.animalType == 'Kambing'}">
					<fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalOrder.animalprice}" />
				</c:if>
			</td>
			<td><button name="view" formaction="AnimalOrderHandler?action=viewAnimalOrder&bookingID=<%=booking_id%>">KEMASKINI</button></td>
		</tr>
	</c:forEach>	
	</table>
	</form>
	<br><br>
	<button name="back" onclick="location.href='client-booking-list.jsp'">KEMBALI</button>
	



</body>
</html>