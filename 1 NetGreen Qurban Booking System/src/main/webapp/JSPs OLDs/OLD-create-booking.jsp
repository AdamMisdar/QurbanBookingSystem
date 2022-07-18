<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.*" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %> <%-- SQL --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Tempahan Baru</title>
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

		h3 {
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
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            -webkit-transition-duration: 0.4s; 
            transition-duration: 0.4s;
            font-family: Arial, Helvetica, sans-serif;
            border-radius: 5px;
		}
		
		.center_button{
			text-align: center;
		}

		.button:hover {
			box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
		}

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
		position: absolute;
		top:0px;
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
	<%! 
		int booking_id;
		int client_id;
	%>
	<%
		if (session.getAttribute("clientID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			client_id = (int)session.getAttribute("clientID");
		}
		booking_id = (int)request.getAttribute("bookingID");
	%>
		
<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>

<%-- CLIENT DETAILS -----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="resultClient">
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
					<c:forEach var="client" items="${resultClient.rows}">
						<p style="position:relative;Left:18px;color: rgb(253, 253, 253); font-weight: bold;">
						<c:out value="${client.clientfullname}"/>
						</p>
						<p style="position:relative;Left:18px;color: rgb(253, 253, 253);"> ID Akaun: 
						<c:out value="${client.clientid}"/>
						</p>
					</c:forEach>
					<%-- tolong buat confirmation, bila dia tekan, dia akan cancel booking dia, so nk teruskan? --%>
				<ul>
					<li><a href="" onclick="location.href='BookingHandler?action=cancelBooking&bookingID=<%=booking_id%>&path=home'"><i class="fas fa-home"></i>Halaman Utama</a></li>
					<li><a href="" onclick="location.href='BookingHandler?action=cancelBooking&bookingID=<%=booking_id%>&path=account'"><i class="fas fa-user"></i>Profil</a></li>
					<li><a href=""><i class="fas fa-address-book"></i>Buat Tempahan</a></li>
					<li><a href="" onclick="location.href='BookingHandler?action=cancelBooking&bookingID=<%=booking_id%>&path=bookinglist'"><i class="fas fa-address-book"></i>Senarai Tempahan</a></li>
		
				</ul> 
			</div>
		</div>

	<div class="title">
	<h3 style="color: white;">TEMPAHAN BARU</h3>
	</div>
	

	<p style="text-align: center;"><b>ID Tempahan : </b><%=booking_id%></p>
	<p style="text-align: center;"><b>ID Akaun: </b><%=client_id%></p>

	<%-- SQL QUERY - DISPLAY ALL ANIMAL DETAILS --%>
	<sql:query dataSource="${qurbanDatabase}" var="resultAnimal">
	   SELECT * FROM animaldetails ORDER BY animaltype
	</sql:query>
	

	<%-- Add Animal Order Section --%>
	<div>
	<form method="post">
	<table style="padding: 20px; text-align: left;">
		
			<tr>
				<th>Informasi Korban</th>
				<th></th>
			</tr>
			<tr>
				<td>Jenis Haiwan: </td>
				<td>	
					<select name="animalDetailsID">
						<c:forEach var="animal" items="${resultAnimal.rows}">
							<option value="${animal.animaldetailsid}"><c:out value="${animal.animaltype}"/></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>Nama Tanggungan: </td>
				<td><input type="text" id="dependentName" name="dependentName" value="" placeholder="Nama Tanggungan"></td>
			</tr>
	</table>
	<br>
	<div class="center_button">
		<button class="button" style="background-color: #DB0F31;" type="reset">Kosongkan</button>
		
		<input type="hidden" name="bookingID" value="<%=booking_id%>">
		<input type="hidden" name="clientID" value="<%=client_id%>">
		
		<input class="button" type="hidden" name="action" value="addAnimalOrder">
		<button class="button" style="background-color: #4CAF50;" type="submit" formaction="AnimalOrderHandler" onclick="addConfirm()">Tambah</button>
	</div>
	</form>
	</div><br>
	
	
	
	
	
	
	<%-- Animal Details Table --%>
	<div>
	<h3  style="font-size:20px;">HARGA HAIWAN KORBAN</h3>
	<table style="padding: 20px; text-align: left;">
			<tr>
				<th>Jenis Haiwan</th>
				<th>Harga 1 Bahagian Haiwan (RM)</th>
			</tr>
		<c:forEach var="animalDetails" items="${resultAnimal.rows}">
			<tr>
				<td><c:out value="${animalDetails.animalType}" /></td>
				<td>
				<c:if test="${animalDetails.animalType == 'Lembu'}">
					<fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalDetails.animalprice/7}" /> (seekor RM <fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalDetails.animalprice}" />)
				</c:if>
				<c:if test="${animalDetails.animalType == 'Unta'}">
					<fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalDetails.animalprice/7}" /> (seekor RM <fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalDetails.animalprice}" />)
				</c:if>
				<c:if test="${animalDetails.animalType == 'Kambing'}">
					<fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalDetails.animalprice}" />
				</c:if>
				</td>
			</tr>
		</c:forEach>	
	</table>
	</div><br>
	
	<%-- SQL QUERY - DISPLAY ANIMAL ORDERS ACCORDING TO BOOKING ID --%>u
	<%! 
		double totalPayment = 0.0;
		Connection connection;
		PreparedStatement orderListSQL;
		ResultSet resultOrder;
		String strSQL;
	%>

	
	<%-- Animal Order List --%>
	<h3 style="font-size:20px;">SENARAI NAMA DAN TEMPAHAN HAIWAN</h3>
	
<form method="post">
	<table style="padding: 20px; text-align: center;">
		<tr>
			<th>Nama Tanggungan</th>
			<th>Jenis Haiwan (Bahagian)</th>
			<th>Harga 1 Bahagian Haiwan (RM) </th>
			<th></th>
		</tr>	
		<%
		try {
			connection = ConnectionManager.getConnection();
			
			strSQL = "SELECT * FROM animalorder JOIN animaldetails USING (animaldetailsid) WHERE bookingid = ?";
			orderListSQL = connection.prepareStatement(strSQL);
			orderListSQL.setInt(1, booking_id);
			
			resultOrder = orderListSQL.executeQuery();
			
			while(resultOrder.next()){
		%>
		<tr>
			<td>
				<input type="hidden" name="animalOrderID" value='<%=resultOrder.getInt("animalorderid")%>'>
				<%=resultOrder.getString("dependentname")%>
			</td>
			<td>
				<%=resultOrder.getString("animaltype")%>
			</td>
			<td><%
					if((resultOrder.getString("animaltype")).equalsIgnoreCase("Lembu")) { %>		
						<fmt:formatNumber type = "number" maxFractionDigits = "2" value ='<%=resultOrder.getDouble("animalprice")/7%>' /> 	<%
						
						totalPayment += (resultOrder.getDouble("animalprice")/7);	
					
					} else if ((resultOrder.getString("animaltype")).equalsIgnoreCase("Kambing")) { %>		
						<fmt:formatNumber type = "number" maxFractionDigits = "2" value ='<%=resultOrder.getDouble("animalprice")%>' />		<%
					
						totalPayment += resultOrder.getDouble("animalprice");
					
					} else if ((resultOrder.getString("animaltype")).equalsIgnoreCase("Unta")) { %> 
						<fmt:formatNumber type = "number" maxFractionDigits = "2" value ='<%=resultOrder.getDouble("animalprice")/7%>' />	<%
						
						totalPayment += (resultOrder.getDouble("animalprice")/7);
					}
					%>
					
			</td>
			<td><button class="button" style="background-color: #DB0F31; padding: 7px 20px;" name="delete" formaction="AnimalOrderHandler?action=deleteAnimalOrder" onclick="deleteConfirm()">Buang</button></td>
		</tr>
		<%		
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<tr>
			<td></td>
			<th>Jumlah (RM)</th>
			<th>
				<fmt:formatNumber type = "number" maxFractionDigits = "2" value ='<%=totalPayment%>' />
				<input type="hidden" id="paymentTotal" name="paymentTotal" value="<%=totalPayment%>">
			</th>
		</tr>
	</table>
	<br>
		<input type="hidden" name="bookingID" value="<%=booking_id%>">
		<input type="hidden" name="clientID" value="<%=client_id%>">
	<div  class="center_button">
		<button class="button" name="cancel" style="background-color: #DB0F31;" formaction="BookingHandler?action=cancelBooking" onclick="cancelConfirm()">Batalkan Tempahan</button>
		<button class="button" type="submit" style="background-color: #4CAF50;" formaction="BookingHandler?action=toInvoice" onclick="confirmBooking()">Ke Bayaran</button>
	</div>
</form><br><br>
	
	

	<script>
		
		function cancelConfirm() {
			var result = confirm('Anda pasti batalkan tempahan ini?');
			if (result == false) {
				event.preventDefault();
			}
		}

		
		function deleteConfirm() {
			var result = confirm('Anda pasti buang tempahan ini?');
			if (result == false) {
				event.preventDefault();
			}
		}
		
		function confirmBooking() {
			var totalPayment = document.getElementById('paymentTotal').value;
			if (totalPayment == 0) {
				alert('Tempahan memerlukan sekurang-kurangnya satu bahagian korban.')
				event.preventDefault();
			}
			else {
				var result = confirm('Sila pastikan semua maklumat adalah betul sebelum meneruskan pembayaran.');
				if (result == false) {
				event.preventDefault();
				}
			}
		}
		
		function addConfirm() {
			var name = document.getElementById('dependentName').value;
			
			if (name == '' || name == null) {
				alert('Nama tanggungan tidak boleh kosong.');
				event.preventDefault();
			}
			
		}
	</script>
	
	<% totalPayment = 0.0; %> <%-- Reset value of Total Payment--%>
	
</body>
</html>