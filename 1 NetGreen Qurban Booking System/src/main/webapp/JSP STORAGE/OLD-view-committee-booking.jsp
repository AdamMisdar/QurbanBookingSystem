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
<title>MAKLUMAT TEMPAHAN</title>
</head>
<body>
	<%!
		int committee_id;
		int booking_id;
		boolean isManager;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		} 
	
		booking_id = (int)request.getAttribute("bookingID");
		
		isManager = (boolean)session.getAttribute("isManager");
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
	%>
<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>
<%-- COMMITTEE MANAGEMENT DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="committeeResult">
		SELECT * FROM management WHERE committeeid = <%=committee_id%>
	</sql:query>
<%----------------------------------------------------- COMMITTEE MANAGEMENT DETAILS --%>

	
	<c:forEach var="committee" items="${committeeResult.rows}">
			<c:out value="${committee.committeefullname}"/>
			<c:out value="${committee.managementposition}"/>
	</c:forEach>
	
	
	<%-- HEADER --%>
	<h2 style="position: absolute; right: 20px;">NETGREEN</h2><br><br>
	
	<%-- NAVIGATION BAR --%>
	<a href="index-committee.jsp" onclick="location.href='index-committee.jsp'">Laman Utama</a><br>
    <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'">Senarai Tempahan</a><br>
    <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'">Senarai Maklumat Haiwan</a><br>
    <% if (isManager) { %>
    <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'">Senarai AJK</a><br>
    <a href="client-list.jsp" onclick="location.href='client-list.jsp'">Senarai Klien</a><br>
    <% } %> 
    <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'">  Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">  Log Keluar</a><br>
 
 	<br><br>
	<%-- BOOKING SQL --%>
	<sql:query dataSource="${qurbanDatabase}" var="bookingResult">
		SELECT *
		FROM payment
		JOIN booking
		USING (bookingid)
		JOIN client
		USING (clientid)
		WHERE bookingid = <%=booking_id%>
	</sql:query>
	
	<%-- BOOKING DETAILS --%>
	<div>
		<h2>MAKLUMAT TEMPAHAN</h2>
	</div>
	
	<br>
	<form method="post">
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
	</table><br><br>
	
	<h3>MAKLUMAT KLIEN</h3>
	
	<table>
		<c:forEach var="booking" items="${bookingResult.rows}">
			<tr>
				<th>Nama</th>
				<td><c:out value="${booking.clientfullname}" /></td>
			</tr>
			<tr>
				<th>Email</th>
				<td><c:out value="${booking.clientemail}" /></td>
			</tr>
			<tr>
				<th>No Telefon</th>
				<td><c:out value="${booking.clientphonenum}" /></td>
		</tr>
		</c:forEach>
	</table><br><br>	
	
	
	<%-- ANIMAL ORDER SQL --%>
	<sql:query dataSource="${qurbanDatabase}" var="animalOrderResult">
		SELECT *
		FROM animaldetails
		JOIN animalorder
		USING (animaldetailsid)
		JOIN booking
		USING (bookingid)
		WHERE bookingid = <%=booking_id%>
	</sql:query>
	
	<h3>TEMPAHAN HAIWAN</h3>
	
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
				<td>
					<button name=view formaction="AnimalOrderHandler?action=viewAnimalOrderCommittee&bookingID=<%=booking_id%>">KEMASKINI</button>
					<button class="button" formaction="AnimalOrderHandler?action=deleteAnimalOrder&animalOrderID=${booking.animalorderid}" style="background-color: #db0f31; color: white;" onclick="checkDelete()">PADAM</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	
	<br><br>
	<button name="back" onclick="location.href='committee-booking-list.jsp'">KEMBALI</button>




</body>
</html>