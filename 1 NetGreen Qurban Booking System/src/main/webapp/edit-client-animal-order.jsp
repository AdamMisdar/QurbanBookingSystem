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
<title>KEMASKINI TEMPAHAN HAIWAN</title>
</head>
<body>
	<%!
		int client_id;
		int booking_id;
		Connection connection;
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
		
		int animalOrderID = (int)request.getAttribute("animalOrderID");
		
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
    <a href="location.href='BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>'" onclick="location.href='BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>'">Buat Tempahan</a><br>
    <a href="view-client-account.jsp" onclick="location.href='view-client-account.jsp'">Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">Log Keluar</a><br><br><br> <%-- TOLONG BUAT ALERT/CONFIRM FUNCTION --%>
    
    <%-- CLIENT DETAILS --%>
	<c:forEach var="client" items="${clientResult.rows}">
	NAMA: <c:out value="${client.clientfullname}" /><br>
	ID Akaun: <%=client_id%>
	</c:forEach>
    
	
	<br><h3>KEMASKINI MAKLUMAT TEMPAHAN</h3><br>
	
	<form method="post">
		<table>
		<%
    		try {
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare Statement
			PreparedStatement showSQL = connection.prepareStatement
			( "SELECT * FROM animalorder JOIN animaldetails USING (animaldetailsid) WHERE animalorderid = ?");
			
			// ? value
			showSQL.setInt(1, animalOrderID);
			
			// Execute SQL
			ResultSet result = showSQL.executeQuery();
			
			while (result.next()) {
		
			//--- Scriplet continued at the bottom
	 	%>
			<tr>
				<th>Nama Tanggungan</th>
				<td><input type="text" name="dependentName" value="<%=result.getString("dependentname")%>"></td>
			</tr>
			<tr>
				<th>Bahagian</th>
				<td><%=result.getString("animaltype")%></td>
			</tr>
					<%
				} // end of while loop
			 }// try
			 
			catch(Exception e){
				e.printStackTrace();
			} 
		%>
		</table>
		<input type="hidden" name="animalOrderID" value="<%=animalOrderID%>">
		<br><br>
		<button name="cancel" formaction="AnimalOrderHandler?action=cancelUpdate&bookingID=<%=booking_id%>">BATAL</button>
		<button type="submit" formaction="AnimalOrderHandler?action=updateAnimalOrder&bookingID=<%=booking_id%>">SIMPAN</button>
		
	</form>

</body>
</html>