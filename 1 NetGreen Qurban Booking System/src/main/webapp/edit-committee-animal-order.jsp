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
		int committee_id;
		int booking_id;
		boolean isManager;
		Connection connection;
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
		
		int animalOrderID = (int)request.getAttribute("animalOrderID");
		
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
<%--------------------------------------- COMMITTEE MANAGEMENT DETAILS --%>

	<c:forEach var="committee" items="${committeeResult.rows}">
		<p style="position:relative; color: rgb(253, 253, 253); font-weight: bold; text-align:left; left: 18px">
			<c:out value="${committee.committeefullname}"/>
		</p>
		<p style="position:relative; color: rgb(253, 253, 253); text-align:left; left: 18px;">
			<c:out value="${committee.managementposition}"/>
		</p>
	</c:forEach>
		
	<%-- HEADER --%>
	<h2 style="position: absolute; right: 20px;">NETGREEN</h2><br><br>
	
	<%-- NAVIGATION BAR --%>
    <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'">Senarai Tempahan</a><br>
    <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'">Senarai Maklumat Haiwan</a><br>
     <% if (isManager) { %>
    <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'">Senarai AJK</a><br>
    <a href="client-list.jsp" onclick="location.href='client-list.jsp'">Senarai Klien</a><br>
     <% } %> 
    <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'">  Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">  Log Keluar</a><br>
  
     <%-- ANIMAL DETAILS ----------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="animalDetailsResult">
		SELECT * FROM animaldetails
	</sql:query>
	<%----------------------------------------  ANIMAL DETAILS --%>
    
    <%-- ANIMAL ORDER -------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="animalOrderResult">
		SELECT * FROM animalorder
		JOIN animaldetails USING (animaldetailsid) 
		WHERE bookingid = <%=booking_id %>
	</sql:query>
	<%------------------------------------------------  ANIMAL ORDER  --%>
	
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
		<button name="cancel" formaction="AnimalOrderHandler?action=cancelUpdateCommittee&bookingID=<%=booking_id%>">BATAL</button>
		<button type="submit" formaction="AnimalOrderHandler?action=updateAnimalOrderCommittee&bookingID=<%=booking_id%>">SIMPAN</button>
		
	</form>

</body>
</html>