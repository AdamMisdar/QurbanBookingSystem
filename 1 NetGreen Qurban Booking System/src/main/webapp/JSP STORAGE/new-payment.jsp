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
<title>Bayaran</title>
</head>
<body>

	<%-- Getting All IDs and Auto Generated Variables --%>
	<%! 
		int booking_id;
		int client_id;
		double totalPayment;
	%>
	<%
		client_id = (int)session.getAttribute("clientID");
		booking_id = (int)request.getAttribute("bookingID");
		totalPayment = (double)request.getAttribute("paymentTotal");
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
	
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
	
	
	
	<h3>Booking ID : <%=booking_id %></h3>
	<h1>Bayaran</h1>
	<p>Sila muat naik resit pembayaran anda</p>
	<p>PDF/PNG/JPEG sahaja diterima</p><br>
	
	<form method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>Jumlah Bayaran: RM </th>
				<th><%=totalPayment%><input type="hidden" name="paymentTotal" value="<%=totalPayment%>"></th>
			</tr>
			<tr>
				<td>Tarikh Pembayaran: </td>
				<td><%= dateToday %><input type="hidden" name="paymentDate" value="<%=dateToday%>"></td>
			</tr>
			<tr>
				<td>Resit Pembayaran: </td>
				<td><input type="file" accept="image/pdf" id="paymentReceipt" name="paymentReceipt" value=""></td>
			</tr>
		</table><br><br>
			<input type="hidden" name="bookingID" value="<%=booking_id%>">
		
		<button type="submit" name="submit" formaction="PaymentHandler?action=addPayment" onclick="checkFile()">Bayar</button>
	</form>

	<%-- JAVASCRIPT ---------------------------------------------------------------------%>
	<script>
	// Check the existence of file, and the file extension
	function checkFile() {
		
		var file_upload = document.getElementById('paymentReceipt').value;
		
		if (file_upload == '' || file_upload == null) {
			alert('Sila muat naik fail resit anda.');
			event.preventDefault();
		}
		
		else {
		/*	var fileExtenion = file_upload.substring(file_upload.lastIndexOf('.')+1);
			if (fileExtension == "pdf" ||fileExtension == "png" || fileExtension == "jpg" || fileExtension == "jpeg" ) {	
				document.forms[0].submit();		
			}
			else {
				alert('Hanya format PDF/PNG/JPEG sahaja dibenarkan.');
				event.preventDefault();
			} */
			alert('Resit berjaya dimuat naik. \nTempahan berjaya.');
			
		}
			
	}
	</script>
	
	<%-- JQUERY --%>


</body>
</html>