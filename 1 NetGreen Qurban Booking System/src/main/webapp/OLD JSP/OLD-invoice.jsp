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
<title>Invois</title>
</head>
<body>

	<%!
		int client_id;
		int booking_id;
		double paymentTotal;
	%>
	<%
		client_id = (int)session.getAttribute("clientID");
		booking_id = (int)request.getAttribute("bookingID");
		paymentTotal = (double)request.getAttribute("paymentTotal");
		
	%>
	
<%-- DATABASE -----------------------------------------------------------%>
	<sql:setDataSource	var="qurbanDatabase" driver="oracle.jdbc.driver.OracleDriver"
						url="jdbc:oracle:thin:@localhost:1521:xe"
						user="netgreen"
						password="system" />
<%----------------------------------------------------------- DATABASE --%>

<%-- CLIENT DETAILS -----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="clientResult">
		SELECT * FROM client WHERE clientid = <%=client_id%>
	</sql:query>
<%----------------------------------------------------- CLIENT DETAILS --%>
	<c:forEach var="client" items="${clientResult.rows}">
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
	
	
	
	<%-- GET PRICE --%>
	<%! 
		Connection connection;
		PreparedStatement cowPriceSQL, goatPriceSQL, camelPriceSQL;
		ResultSet resultCow, resultGoat, resultCamel;
		double cowPrice, goatPrice, camelPrice;
	%>
	<%
		try {
			connection = ConnectionManager.getConnection();
			cowPriceSQL = connection.prepareStatement("SELECT animalprice FROM animaldetails WHERE animaltype = 'Lembu' ");
			goatPriceSQL = connection.prepareStatement("SELECT animalprice FROM animaldetails WHERE animaltype = 'Kambing' ");
			camelPriceSQL = connection.prepareStatement("SELECT animalprice FROM animaldetails WHERE animaltype = 'Unta' ");
			
			resultCow = cowPriceSQL.executeQuery();
			while(resultCow.next()){
				cowPrice = (resultCow.getDouble("animalprice"))/7;
			}
			
			resultGoat = goatPriceSQL.executeQuery();
			while(resultGoat.next()){
				goatPrice = resultGoat.getDouble("animalprice");
			}
			
			resultCamel = camelPriceSQL.executeQuery();
			while(resultCamel.next()){
				camelPrice = (resultCamel.getDouble("animalprice"))/7;
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	%>

	
	
	<sql:query dataSource="${qurbanDatabase}" var="animalOrderResult">
		SELECT * FROM animalorder WHERE bookingid = <%=booking_id%>
	</sql:query>
	
	<sql:query dataSource="${qurbanDatabase}" var="bookingResult">
		SELECT * FROM booking WHERE bookingid = <%=booking_id%>
	</sql:query>
	
	<h1>INVOIS</h1>
	<br><br>
	
	<%-- BOOKING DETAILS -------------------------%>
<form method="post">
	<table style="width: 100%; text-align: left;">
	<c:forEach var="booking" items="${bookingResult.rows}">
		<tr>
			<th>ID Booking: </th>
			<td><c:out value="${booking.bookingid}"/></td>
		</tr>
		<tr>
			<th>Tarikh: </th>
			
			<td><c:out value="${booking.bookingdate}"/></td>
		</tr>
	</c:forEach>	
	</table>
	
	<%-- CLIENT DETAILS -------------------------%>
	
	<h3>Nama Pelanggan</h3>
	<table style="width: 100%; border: 2px solid black; text-align: center;">
		<tr>
			<th>Nama</th>
			<th>Email</th>
			<th>No Telefon</th>
			<th>Alamat</th>
		</tr>
	<c:forEach var="client" items="${clientResult.rows}">
		<tr>
			<td><c:out value="${client.clientfullname}"/></td>
			<td><c:out value="${client.clientemail}"/></td>
			<td><c:out value="${client.clientphonenum}"/></td>
			<td><c:out value="${client.clientaddress}"/></td>
		</tr>
	</c:forEach>	
	</table>
	
	<%-- ANIMAL ORDER DETAILS -------------------------%>
	
	<h3>Senarai Korban</h3>
	<table style="width: 100%; border: 2px solid black; text-align: center;">
		<tr>
			<th>Nama Korban</th>
			<th>Bahagian</th>
			<th>Harga Sebahagian</th>
		</tr>
	<c:forEach var="animalOrder" items="${animalOrderResult.rows}">
		<tr>
			<td><c:out value="${animalOrder.dependentname}"/></td>
			<td><c:out value="${animalOrder.animalparttype}"/></td>
			<td>
				<c:if test="${animalOrder.animalparttype == 'Lembu'}">
				<%=cowPrice%>
				</c:if>
				<c:if test="${animalOrder.animalparttype == 'Kambing'}">
				<%=goatPrice%>
				</c:if>
				<c:if test="${animalOrder.animalparttype == 'Unta'}">
				<%=camelPrice%>
				</c:if>
			</td>	
		</tr>
	</c:forEach>
		<tr>
			<td></td>
			<td></td>
			<td>_________________</td>
		</tr>
		<tr>
			<td></td>
			<th>Jumlah (RM)</th>
			<th><%=paymentTotal%><input type="hidden" name="paymentTotal" value="<%=paymentTotal%>"></th>
		</tr>
	</table>
	
	<input type="hidden" name="bookingID" value="<%=booking_id%>">
	<button name="back" formaction="BookingHandler?action=toBooking">Kembali ke Tempahan</button>
	<button type="submit" formaction="BookingHandler?action=toPayment">Terus ke Bayaran</button>
	
</form>


</body>
</html>