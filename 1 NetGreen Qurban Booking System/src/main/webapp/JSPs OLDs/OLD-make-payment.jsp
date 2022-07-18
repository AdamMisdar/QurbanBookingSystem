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
	<title>Bayaran</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>

	<style>

		body {
			padding: 0;
			margin: 0;
			font-family: Arial, Helvetica, sans-serif;
		}

		#center{
			text-align: center;
		}
	
		table{
                border-collapse: collapse; 
                border: 1px solid #bdc3c7;
                box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
                margin-left: auto;
                margin-right: auto;
                width: 70%;
                height: auto;
            }
	
		th,
		td {
			padding: 12px;
			text-align: center;
			border-bottom: 1px solid #ddd;
		}
	
		.header{
			background-color: #037247;
			color: #fff;
            padding: 20px;
		}

		h2 {
			font-weight: 600;
			text-align: center;
			color: rgb(5, 5, 5);
			padding: 10px 0px;
            font-size: 30px;
		}
		
		.title {
			color: #0c0c0c;
			border: #035317 2px solid;
			height: 50px;
			width: 90vh;
			margin: auto;
			margin-top: 30px;
			margin-bottom: 20px;
			margin-right: 300px;
			padding : auto;
			border-radius: 10px;
			background-color: #037247;
            }

        .title h2{
            color: white;
        }

		@media only screen and (max-width: 768px) {
			table{
				width: 90%;
			}
		}
	
		.button {
			border: none;
			width: 150px;
			color: white;
			padding: 15px 32px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 14px;
			margin: 4px 2px;
			cursor: pointer;
			-webkit-transition-duration: 0.4s; /* Safari */
			transition-duration: 0.4s;
			font-family: Arial, Helvetica, sans-serif;
			position: relative; 
			margin-left:68%;
			margin-top: 25%;
			border-radius: 5px;
			
		}
	
		.button:hover {
			box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
		}

		@import url('https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap');

		*{
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		list-style: none;
		text-decoration: none;
		font-family: 'Josefin Sans', sans-serif;
		}
		
		body{
		background-color: #f3f5f9;
		}

		.wrapper{
		display: flex;
		position: relative;
		}

		.wrapper .sidebar{
		width: 200px;
		height: 100%;
		background: #037247;
		padding: 30px 0px;
		position: fixed;
		}

		.wrapper .sidebar h2{
		color: #fff;
		text-transform: uppercase;
		text-align: center;
		margin-bottom: 30px;
		}

		.wrapper .sidebar ul li{
		padding: 15px;
		border-bottom: 1px solid #bdb8d7;
		border-bottom: 1px solid rgba(0,0,0,0.05);
		border-top: 1px solid rgba(255,255,255,0.05);
		}    

		.wrapper .sidebar ul li a{
		color: #fafafa;
		display: block;
		}

		.wrapper .sidebar ul li a .fas{
		width: 25px;
		}

		.wrapper .sidebar ul li:hover{
		background-color: #5a595e;
		}
			
		.wrapper .sidebar ul li:hover a{
		color: #fff;
		}

		.wrapper .sidebar .social_media{
		position: absolute;
		bottom: 0;
		left: 50%;
		transform: translateX(-50%);
		display: flex;
		}

		.wrapper .sidebar .social_media a{
		display: block;
		width: 40px;
		background: #565558;
		height: 40px;
		line-height: 45px;
		text-align: center;
		margin: 0 5px;
		color: #ffffff;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		}

		.wrapper .main_content{
		width: 100%;
		margin-left: 200px;
		}

		.wrapper .main_content .header{
		padding: 20px;
		background: #fff;
		color: #717171;
		border-bottom: 1px solid #e0e4e8;
		}

		.wrapper .main_content .info{
		margin: 20px;
		color: #717171;
		line-height: 25px;
		}

		.wrapper .main_content .info div{
		margin-bottom: 20px;
		}

		@media (max-height: 500px){
		.social_media{
			display: none !important;
		}
		}
		</style>
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
	<sql:query dataSource="${qurbanDatabase}" var="clientResult">
		SELECT * FROM client WHERE clientid = <%=client_id%>
	</sql:query>
<%----------------------------------------------------- CLIENT DETAILS --%>
		<div class="header">
			<div>
				<span style="position: absolute; right: 20px; top:7px; font-size: 16px">NETGREEN</span>
				<span></span>
			</div>
		</div>
		

	
		<div class="wrapper">
			<div class="sidebar">
				<h2>KLIEN</h2>
					<c:forEach var="client" items="${clientResult.rows}">
						<p style="position:relative; color: rgb(253, 253, 253); font-weight: bold; text-align:left; left: 18px">
						<c:out value="${client.clientfullname}"/>
						</p>
						<p style="position:relative; color: rgb(253, 253, 253); text-align:left; left: 18px;"> ID Akaun: 
						<c:out value="${client.clientid}"/>
						</p>
					</c:forEach>
				<ul>
					<li><a href="" onclick="location.href='BookingHandler?action=cancelBooking&bookingID=<%=booking_id%>&path=home'"><i class="fas fa-home"></i>Halaman Utama</a></li>
					<li><a href="" onclick="location.href='BookingHandler?action=cancelBooking&bookingID=<%=booking_id%>&path=account'"><i class="fas fa-user"></i>Profil</a></li>
					<li><a href="" onclick="location.href='BookingHandler?action=toBooking?bookingID=<%=booking_id%>'"><i class="fas fa-address-book"></i>Buat Tempahan</a></li>
					<li><a href="" onclick="location.href='BookingHandler?action=cancelBooking&bookingID=<%=booking_id%>&path=bookinglist'"><i class="fas fa-address-book"></i>Senarai Tempahan</a></li>
		
				</ul> 
			</div>
		</div>
	
	<div class="title" style="text-align: center;">
        <h1 style="color: white; font-weight: 700;">BAYARAN</h1>
    
    </div><br><br>
	 <table>
	 <tr>
		<td>Booking ID : </td><td><%=booking_id %></td>
	</tr>
	</table>
	<p id="center">Sila muat naik resit pembayaran anda</p>
	<p id="center">PDF/PNG/JPEG sahaja diterima</p><br>
	
	<form method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>Jumlah Bayaran: RM </th>
				<th>
				<fmt:formatNumber type = "number" maxFractionDigits = "2" value = "<%=totalPayment%>" />
				<input type="hidden" name="paymentTotal" value="<%=totalPayment%>">
				</th>
			</tr>
			<tr>
				<td>Tarikh Pembayaran: </td>
				<td><%= dateToday %><input type="hidden" name="paymentDate" value="<%=dateToday%>"></td>
			</tr>
			<tr>
				<td>Resit Pembayaran: </td>
				<td><input type="file" accept="image/pdf" id="paymentReceipt" name="paymentReceipt" value=""></td>
			</tr>
		</table>
			<input type="hidden" name="bookingID" value="<%=booking_id%>">
		
		<button class="button" style="background-color: #4CAF50; transform: translate(0px,-300px);" type="submit" name="submit" formaction="PaymentHandler?action=addPayment" onclick="checkFile()">Bayar</button>
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