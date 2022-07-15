<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Tempahan Baru</title>
</head>
<body>

	<%! 
		int booking_id;
		int client_id;
	%>
	<%
		client_id = (int)session.getAttribute("clientID");
		booking_id = (int)request.getAttribute("bookingID");
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
	
	
	
	
	<h1>Tempahan Baru</h1>
	<p>Booking ID : <%=booking_id%></p>
	<p>Client ID : <%=client_id%></p>

	<%-- SQL QUERY - DISPLAY ALL ANIMAL DETAILS --%>
	<sql:query dataSource="${qurbanDatabase}" var="result">
	   SELECT animaltype, animalprice FROM animaldetails
	</sql:query>
	
	
	
	<%-- Add Animal Order Section --%>
	<form method="post">
	<table style="width: 100%; border: 2px solid black; padding: 20px; text-align: left;">
		
			<tr>
				<th>Informasi Korban</th>
				<th></th>
			</tr>
			<tr>
				<td>Jenis Haiwan: </td>
				<td>	
					<select name="animalPartType">
						<c:forEach var="animal" items="${result.rows}">
							<option value="${animal.animaltype}"><c:out value="${animal.animaltype}"/></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>Nama Korban: </td>
				<td><input type="text" id="dependentName" name="dependentName" value="" placeholder="Nama Korban"></td>
			</tr>
	</table>
	
	<button type="reset">Kosongkan</button>
	
	<input type="hidden" name="bookingID" value="<%=booking_id%>">
	<input type="hidden" name="clientID" value="<%=client_id%>">
	
	<input type="hidden" name="action" value="addAnimalOrder">
	<button type="submit" formaction="AnimalOrderHandler" onclick="addConfirm()">Tambah</button>
	
	</form><br><br>	
	
	
	
	
	
	
	
	<%-- Animal Details Table --%>
	<h3>Harga Haiwan Korban</h3>
	<table style="width: 500px; border: 2px solid black;  padding: 20px; text-align: left;">
			<tr>
				<th>Jenis Haiwan</th>
				<th>Harga 1 Bahagian Haiwan (RM)</th>
			</tr>
		<c:forEach var="animalDetails" items="${result.rows}">
			<tr>
				<td><c:out value="${animalDetails.animalType}" /></td>
				<td>
				<c:if test="${animalDetails.animalType == 'Lembu'}">
					<c:out value="${animalDetails.animalprice/7} (seekor RM ${animalDetails.animalprice})"/>
					<input type="hidden" name="cowPrice" value="${animalDetails.animalprice/7}">
				</c:if>
				<c:if test="${animalDetails.animalType == 'Unta'}">
					<c:out value="${animalDetails.animalprice/7} (seekor RM ${animalDetails.animalprice})"/>
					<input type="hidden" name="camelPrice" value="${animalDetails.animalprice/7}">
				</c:if>
				<c:if test="${animalDetails.animalType == 'Kambing'}">
					<c:out value="${animalDetails.animalprice}"/>
					<input type="hidden" name="goatPrice" value="${animalDetails.animalprice}">
				</c:if>
				</td>
			</tr>
		</c:forEach>	
	</table><br><br>

	
	
	<%-- SQL QUERY - DISPLAY ANIMAL ORDERS ACCORDING TO BOOKING ID --%>
	<sql:query dataSource="${qurbanDatabase}" var="resultOrder">
	   SELECT * FROM animalorder WHERE bookingid = <%=booking_id%>
	</sql:query>
	
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
	
	<%-- Calculate total price --%>
	<%!
		double totalPayment = 0.0;
	%>
	
	<%-- Animal Order List --%>
	<h3>Senarai Nama dan Tempahan Haiwan</h3>
	
<form method="post">
	<table style="width: 100%; border: 2px solid black;  padding: 20px; text-align: center;">
		<tr>
			<th>Nama Korban</th>
			<th>Jenis Haiwan (Bahagian)</th>
			<th>Harga (1 Bahagian) (RM) </th>
			<th></th>
		</tr>	
	<c:forEach var="animalOrder" items="${resultOrder.rows}">
		<tr>
			<td>
				<input type="hidden" name="animalOrderID" value="${animalOrder.animalorderid}">
				<c:out value="${animalOrder.dependentName}"/>
			</td>
			<td>
				<c:out value="${animalOrder.animalparttype}"/>
			</td>
			<td>
				<c:if test="${animalOrder.animalparttype == 'Lembu'}">
				<%=cowPrice%>
				<% totalPayment += cowPrice; %>
				</c:if>
				<c:if test="${animalOrder.animalparttype == 'Kambing'}">
				<%=goatPrice%>
				<% totalPayment += goatPrice; %>
				</c:if>
				<c:if test="${animalOrder.animalparttype == 'Unta'}">
				<%=camelPrice%>
				<% totalPayment += camelPrice; %>
				</c:if>
			</td>
			<td><button name="delete" formaction="AnimalOrderHandler?action=deleteAnimalOrder" onclick="deleteConfirm()">Buang</button></td>
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
			<th><%=totalPayment%><input type="hidden" id="paymentTotal" name="paymentTotal" value="<%=totalPayment%>"></th>
		</tr>
	</table>
	
		<input type="hidden" name="bookingID" value="<%=booking_id%>">
		<input type="hidden" name="clientID" value="<%=client_id%>">
	
		<button name="cancel" formaction="BookingHandler?action=cancelBooking" onclick="cancelConfirm()">Batalkan Tempahan</button>
		<button type="submit" formaction="BookingHandler?action=toInvoice" onclick="confirmBooking()">Ke Bayaran</button>
</form>
	
	

	<script>
		function cancelConfirm() {
			var result = confirm('Anda pasti batalkan tempahan?');
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
				alert('Nama korban tidak boleh kosong.');
				event.preventDefault();
			}
			
		}
	</script>
	
	<% totalPayment = 0.0; %> <%-- Reset value of Total Payment--%>
	
</body>
</html>