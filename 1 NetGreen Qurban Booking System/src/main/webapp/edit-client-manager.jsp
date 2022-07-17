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
<title>Kemaskini Akaun</title>
</head>
<body>
		<%!
		// MANAGER ONLY
		int committee_id; // mananager's committee id
		int ID_client; // committee to view
		Connection connection;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
	
		ID_client = (int)request.getAttribute("ID_client");
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
	%>
	
	<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>

<%-- SIDEBAR MANAGEMENT DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="committeeResult">
		SELECT * FROM management WHERE committeeid = <%=committee_id%>
	</sql:query>
<%----------------------------------------------------- SIDEBAR MANAGEMENT DETAILS --%>	

	<c:forEach var="committee" items="${committeeResult.rows}">
		<c:out value="${committee.committeefullname}"/><br>
		<c:out value="${committee.managementposition}"/>
	</c:forEach>
	
	<%-- HEADER --%>
	<h2>NETGREEN</h2><br><br>
	
	<%-- NAVIGATION BAR --%>
	<a href="index-committee.jsp" onclick="location.href='index-committee.jsp'">Laman Utama</a><br>
    <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'">Senarai Tempahan</a><br>
    <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'">Senarai Maklumat Haiwan</a><br>
    <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'">Senarai AJK</a><br>
    <a href="client-list.jsp" onclick="location.href='client-list.jsp'">Senarai Klien</a><br>
    <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'">  Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">  Log Keluar</a><br>
    
    <%-- CLIENT DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="clientResult">
		SELECT * FROM client WHERE clientid = <%=ID_client%>
	</sql:query>
	<%--------------------------------------- CLIENT DETAILS --%>
    
    <h3>KEMASKINI MAKLUMAT AKAUN (SUKARELAWAN)</h3><br><br>
    
    <form method="post">
    	<table>
    	<c:forEach var="client" items="${clientResult.rows}">
    	 <%
    		try {
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare Statement
			PreparedStatement showSQL = connection.prepareStatement
			( "SELECT * FROM client WHERE clientid = ?");
			
			// ? value
			showSQL.setInt(1, ID_client);
			
			// Execute SQL
			ResultSet result = showSQL.executeQuery();
		
			
			while (result.next()) {
		
			//--- Scriplet continued at the bottom
	 	%>
    		<tr>
    			<th>ID Akaun:</th>
    			<td>
    				<c:out value="${client.clientid}"/>
    				<input type="hidden" name="clientID" value="<%=ID_client%>">
    			</td>
    		</tr>
    		<tr>
    			<th>Nama Penuh:</th>
    			<td><input type="text" name="clientFullName" value='<%=result.getString("clientFullName")%>'></td>
    		</tr>
    		<tr>
    			<th>No Telefon:</th>
    			<td><input type="text" name="clientPhoneNum" value='<%=result.getString("clientPhoneNum")%>'></td>
    		</tr>
    		<tr>
    			<th>Tarikh Lahir:</th>
    			<td><input type="date" name="clientBirthDate" value='<%=result.getString("clientBirthDate")%>'></td>
    		</tr>
			<tr>
    			<th>Alamat:</th>
    			<td><input type="text" name="clientAddress" value='<%=result.getString("clientAddress")%>'></td>
    		</tr>
    		<tr>
    			<th>Email:</th>
    			<td><input type="text" name="clientEmail" value='<%=result.getString("clientEmail")%>'></td>
    		</tr>
    		<tr>
    			<th>Kata Laluan:</th>
    			<td><input type="password" name="clientPassword" value='<%=result.getString("clientPassword")%>'></td>
    		</tr>
    		
    		<%
					}
    			} catch(Exception e){
    				e.printStackTrace();
    			}
    		
    		%>
    	</c:forEach>
    	</table><br>
    	
		<button name="back" formaction="ClientHandler?action=viewClient&ID=<%=ID_client%>">BATAL</button>
		<button type="submit" name="update" formaction="ClientHandler?action=updateClientCom&ID=<%=ID_client%>">SIMPAN</button>
 	</form>
    
    
	
	
	
</body>
</html>