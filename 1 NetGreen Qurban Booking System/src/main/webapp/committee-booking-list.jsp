<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.ConnectionManager" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Senarai Tempahan</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>

<style>
	body {
			padding: 0;
			margin: 0;
			font-family: Arial, Helvetica, sans-serif;
		}
		
	
	table {
			position: absolute;
			
			left: 50%;
			top: 50%;
			transform: translate(-50%, -50%); */
			border-collapse: collapse;
			width: 70%;
			height: 100px;
			border: 1px solid #bdc3c7;
			box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
			margin-left: 110px;
		}
		input {
			width: 100%;
			padding: 12px 20px;
			margin: 8px 0;
			display: inline-block;
			border: 1px solid #ccc;
			border-radius: 4px;
			box-sizing: border-box;
		}
		th,
		td {
			padding: 10px;
			text-align: center;
			border-bottom: 1px solid #ddd;
		}
		.header{
			background-color: #037247;
			color: rgb(8, 8, 8);
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
			padding: 15px 20px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
			margin: 4px 2px;
			cursor: pointer;
			-webkit-transition-duration: 0.4s; 
			transition-duration: 0.4s;
			font-family: Arial, Helvetica, sans-serif;
            border-radius: 5px;
			
		}
		#buttonhome{
			position: absolute;
			font-size: 16px;
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
  width: 250px;
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
		int committee_id;
		int counter;
		boolean isManager;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
		counter = 0;
		
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
		<div class="header">
			<div>
				<span style="position: absolute; right: 20px; top:7px; font-size: 16px; color: white;">NETGREEN</span>
				<span></span>
			</div>
		</div>

		
		<div class="wrapper">
			<div class="sidebar">
				<h2>PENGURUSAN</h2>
					<c:forEach var="committee" items="${committeeResult.rows}">
						<p style="position:relative;Left:18px;color: rgb(253, 253, 253); font-weight: bold;">
						<c:out value="${committee.committeefullname}"/>
						</p>
						<p style="position:relative;Left:18px;color: rgb(253, 253, 253);">
						<c:out value="${committee.managementposition}"/>
						</p>
					</c:forEach>
				<ul>
					<li><a href="index-committee.jsp" onclick="location.href='index-committee.jsp'"><i class="fas fa-home"></i>Halaman Utama</a></li>
					<li><a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'"><i class="fas fa-address-book"></i>Senarai Tempahan</a></li>
					<li><a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'"><i class="fas fa-address-book"></i>Senarai Maklumat Haiwan</a></li>
					<% if (isManager) { %>
					<li><a href="committee-list.jsp" onclick="location.href='committee-list.jsp'"><i class="fas fa-address-book"></i>Senarai AJK</a></li>
					<li><a href="client-list.jsp" onclick="location.href='client-list.jsp'"><i class="fas fa-address-book"></i>Senarai Klien</a></li>
					<% } %> 
					<li><a href="view-committee-account.jsp"><i class="fas fa-user"></i> Akaun</a></li>
					<li><a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i> Log Keluar</a></li>
		
				</ul> 
			</div>
		</div>
		
	<%-- SEARCH FUNCTION --%>
	<div style="width: 300px; position: absolute; right: 150px; top: 140px">
	<form action="" method="get">
		<input type="text" class="form-control" name="query" placeholder="Cari tempahan mengikut nama/tarikh..">
	 	<button name="search" formaction="committee-booking-list.jsp" class="button" style="position: absolute; top: 5px; right:-100px; padding: 15px; padding-top: 7px; padding-bottom: 7px;">CARI</button>
	</form>
	<form action="" method="get">
		<input type="hidden" name="query" value="">
	 	<button name="q" formaction="committee-booking-list.jsp" class="button" style="position: absolute; top: 50px; right:-100px; padding: 15px; background-color: #db0f31; color: white;  padding: 7px">RESET</button>
	</form>	
	</div>

	<%-- BOOKING DETAILS 
	<sql:query dataSource="${qurbanDatabase}" var="bookingResult">
		SELECT * 
		FROM payment
		JOIN booking
		USING (bookingid)
		JOIN client
		USING (clientid)
		ORDER BY bookingid
	</sql:query> --%>
	
	
	<div class="title">
	<h2>SENARAI TEMPAHAN</h2>
	</div>
	
	
	<div class="tablecontainer">
	<form method="post">
	<table style="position: fixed; top: 500px;">
		<tr>
			<th>No.</th>
			<th>Tarikh Tempah</th>
			<th>Harga Tempahan (RM)</th>
			<th>Nama Klien</th>
			<th></th>
		</tr>
		
	<%
		Statement showStat;
		ResultSet result;
		Connection connection = ConnectionManager.getConnection();
		showStat = connection.createStatement();
		
		String query = request.getParameter("query");
		String data;
			
		if(query != null) {
			data = 	"SELECT bookingid, bookingdate, clientid, committeeid, clientfullname, paymenttotal, TO_CHAR(bookingdate, 'YYYY-MM-DD') FROM payment JOIN booking USING (bookingid) JOIN client USING (clientid) WHERE " +
					"clientfullname LIKE '%" + query + "%' " + 
					"OR LOWER(clientfullname) LIKE '%" + query + "%' " +
					"OR TO_CHAR(bookingdate, 'YYYY-MM-DD') LIKE '%" + query + "%' ";
		} else {
			data = "SELECT * FROM payment JOIN booking USING (bookingid) JOIN client USING (clientid) ORDER BY bookingid"; // All data
		}
		
		result = showStat.executeQuery(data);
		
		while(result.next()) {
			
	%>
	

	
<%-- <c:forEach var="booking" items="${bookingResult.rows}"> --%>	
		<% counter++; %>
		<tr>
			<td><c:out value="<%=counter%>"/></td>
			<td>
			<%-- 	<c:out value="${booking.bookingdate}"/> --%>
					<c:out value='<%=result.getString("bookingdate")%>'/>
			</td>
			<td>
			<%--	<fmt:formatNumber type = "number" maxFractionDigits = "2" value = "${booking.paymenttotal}" /> --%>
					<fmt:formatNumber type = "number" maxFractionDigits = "2" value = '<%=result.getDouble("paymenttotal")%>' />
			</td>
			<td>
			<%--	<c:out value="${booking.clientfullname}"/></td> --%>
					<c:out value='<%=result.getString("clientfullname")%>'/>
			<td>
            		<button class="button" formaction="BookingHandler?action=viewBookingCommittee&bookingID=<c:out value='<%=result.getInt("bookingid")%>'/>&committeeID=<%=committee_id %>" style="background-color: #2c752f; color: #fff;">Lihat&nbsp;&nbsp;<i class="bi bi-eye-fill"></i></button>
					<button class="button" formaction="BookingHandler?action=deleteBooking&bookingID=<c:out value='<%=result.getInt("bookingid")%>'/>&committeeID=<%=committee_id %>" style="background-color: #db0f31; color: white;" onclick="checkDelete()">Padam</button>
			</td>
		</tr>
<%-- 	</c:forEach> --%>
	<%	
		}
	%>
	</table>
	</form>
	</div>
	
		<p style="position: fixed; top: 200px; right: 150px;">Bilangan tempahan yang dijumpai: <%=counter%></p>
		
			<% counter=0; %>
	
		<script>
	function checkDelete() {
		var result = confirm('Anda pasti buang tempahan ini?');
		if (result == false) {
			event.preventDefault();
		}
	}
	
	</script>
</body>
</html>