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
<title>KEMASKINI AKAUN</title>
</head>
<body>
	<%-- LOGIN REQUIREMENT--%>
    <%!
    	int client_id;
    	Connection connection;
    %>
    <%
    	if (session.getAttribute("clientID")==null) {
    		response.sendRedirect("login.jsp");
    	}
    	else {
    		client_id = (int)session.getAttribute("clientID");
    	}

		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
	%>
	
	
	<%-- HEADER --%>
	<h2 style="position: absolute; right: 20px;">NETGREEN</h2><br><br>
	
	<%-- NAVIGATION BAR --%>
    <a href="index-client.jsp" onclick="location.href='index-client.jsp'">Laman Utama</a><br>
    <a href="client-booking-list.jsp" onclick="location.href='client-booking-list.jsp'">Senarai Tempahan</a><br>
    <a href="create-booking.jsp" onclick="location.href='create-booking.jsp'">Buat Tempahan</a><br>
    <a href="view-client-account.jsp" onclick="location.href='view-client-account.jsp'">Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">Log Keluar</a><br><br><br> <%-- TOLONG BUAT ALERT/CONFIRM FUNCTION --%>
	
	<%-- ACCOUNT DETAILS --%>
				
    ID Akaun: <%=client_id%>
    
    <h1>KEMASKINI AKAUN</h1><br><br>
    
    <form method="post">
    <table>
    	<%
    		try {
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare Statement
			PreparedStatement showSQL = connection.prepareStatement
			( "SELECT * FROM client WHERE clientid = ?");
			
			// ? value
			showSQL.setInt(1, client_id);
			
			// Execute SQL
			ResultSet result = showSQL.executeQuery();
			
			while (result.next()) {
		
			//--- Scriplet continued at the bottom
	 	%>
    	<tr>
    		<td style="width: 100px;">Nama Penuh: </td>
    		<td><input type="text" name="clientFullName" value='<%=result.getString("clientfullname")%>'></td>
    	</tr>
    	<tr>
    		<td>No. Telefon: </td>
    		<td><input type="text" name="clientPhoneNum" value='<%=result.getString("clientphonenum")%>'></td>
    	</tr>
    	<tr>
    		<td>Email: </td>
    		<td><input type="email" name="clientEmail" value='<%=result.getString("clientemail")%>'></td>
    	</tr>
    	<tr>
    		<td>Tarikh Lahir: </td>
    		<td><input type="date" name="clientBirthDate" value='<%=result.getString("clientbirthdate")%>'></td>
    	</tr>
    	<tr>
    		<td>Alamat</td>
    		<td><input type="text" name="clientAddress" value='<%=result.getString("clientaddress")%>'></td>
    	</tr>
    	<tr>
    		<td>Password: </td>
    		<td><input type="password" name="clientPassword" value='<%=result.getString("clientpassword")%>'></td>
    	</tr>
    </table><br>
		<%
				} // end of while loop
			 }// try
			 
			catch(Exception e){
				e.printStackTrace();
			}
		%>
   
    <button name="cancel" formaction="view-client-account.jsp">BATAL</button>
    <button type="submit" name="submit" formaction="ClientHandler?action=updateClient&clientID=<%=client_id%>">KEMASKINI</button>
	</form>

</body>
</html>