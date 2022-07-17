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
<title>Akaun AJK</title>
</head>
<body>
	<%!
		// MANAGER ONLY
		int committee_id; // mananager's committee id
		String committeeType;
		Connection connection;
		String manSQL, volSQL;
		boolean checkManagement = false, checkVoluntary = false, isManager = false;
		ResultSet resultManagement, resultVoluntary;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
		
		// Check Voluntary
		
		// Get connection
		connection = ConnectionManager.getConnection();
		
		// Go through database
		manSQL = "SELECT * FROM management JOIN committee USING (committeeid) WHERE committeeid = ?";
		volSQL = "SELECT * FROM voluntary JOIN committee USING (committeeid) WHERE committeeid = ?";

		PreparedStatement checkManSQL = connection.prepareStatement(manSQL);
		PreparedStatement checkVolSQL = connection.prepareStatement(volSQL);
		
		// Set ? values
		checkManSQL.setInt(1, committee_id);
		checkVolSQL.setInt(1, committee_id);
		
		// Execute
		resultManagement = checkManSQL.executeQuery();
		resultVoluntary = checkVolSQL.executeQuery();
		
		// Check
		if (resultManagement.next()) {
			checkManagement = true;
			System.out.println("Yes: Management");
		}
		else {
			checkManagement = false;
			System.out.println("No: Not Management");
		}
		
		if (resultVoluntary.next()) {
			checkVoluntary = true;
			System.out.println("Yes: Voluntary");
		}
		else {
			checkVoluntary = false;
			System.out.println("No: Not Voluntary");
		}
		
		if (checkVoluntary) {
			
			response.sendRedirect("view-committee-voluntary-account.jsp");
		}
		
	%>
	<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>

<%-- SIDEBAR COMMITTEE DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="committeeResult">
		SELECT * FROM committee WHERE committeeid = <%=committee_id%>
	</sql:query>
<%----------------------------------------------------- SIDEBAR MANAGEMENT DETAILS --%>	
	
	<c:forEach var="committee" items="${committeeResult.rows}">
			<c:out value="${committee.committeefullname}"/><br>
			<c:out value="${committee.managementposition}"/>
	</c:forEach>
	
	<%-- HEADER --%>
	<h2>NETGREEN</h2><br><br>
    
<%-- CHECK MANAGEMENT/VOLUNTARY ---------------------------------------------%>
	<%
		boolean isManager = (boolean)session.getAttribute("isManager");
	%>

<%-- CHECK MANAGEMENT/VOLUNTARY ---------------------------------------------%>
		<%-- NAVIGATION BAR --%>
	
	<a href="index-committee.jsp" onclick="location.href='index-committee.jsp'">Laman Utama</a><br>
    <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'">Senarai Tempahan</a><br>
    <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'">Senarai Maklumat Haiwan</a><br>
    <% if (isManager) { %>
    <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'">Senarai AJK</a><br>
    <a href="client-list.jsp" onclick="location.href='client-list.jsp'">Senarai Klien</a><br>
   	<% } %>
    <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'">  Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">  Log Keluar</a><br>
    
 <%-- MANAGEMENT ----------------------------------------------------------------------------------------------------- --%>
   	
   	 <%-- MANAGEMENT DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="managementResult">
		SELECT * FROM management WHERE committeeid = <%=committee_id%>
	</sql:query>
	<%--------------------------------------- MANAGEMENT DETAILS --%>	
    
    <h3>MAKLUMAT AKAUN (PENGURUSAN)</h3><br><br>
    
    <form method="post">
    	<table>
    	<c:forEach var="management" items="${managementResult.rows}">
    		<tr>
    			<th>ID Akaun:</th>
    			<td><c:out value="${management.committeeid}"/></td>
    		</tr>
    		<tr>
    			<th>Nama Penuh:</th>
    			<td><c:out value="${management.committeefullname}"/></td>
    		</tr>
    		<tr>
    			<th>No Telefon:</th>
    			<td><c:out value="${management.committeephonenum}"/></td>
    		</tr>
    		<tr>
    			<th>Tarikh Lahir:</th>
    			<td><c:out value="${management.committeebirthdate}"/></td>
    		</tr>
    		<tr>
    			<th>Alamat:</th>
    			<td><c:out value="${management.committeeaddress}"/></td>
    		</tr>
    		<tr>
    			<th>Email:</th>
    			<td><c:out value="${management.committeeemail}"/></td>
    		</tr>
    		<tr>
    			<th>Kata Laluan:</th>
    			<td><input type="password" value="${management.committeepassword}" readonly></td>
    		</tr>
    		<tr>
    			<th>Jawatan:</th>
    			<td><c:out value="${management.managementposition}"/></td>
    		</tr>
    		<c:if test="${management.managementposition != 'Pengerusi'}">
    		<tr>
    			<th>Pengurus:</th>
    			<td>
    				<%-- MANAGER LIST ---------------------------------------%>
						<sql:query dataSource="${qurbanDatabase}" var="resMan">
							SELECT * FROM management 
							WHERE committeeid = ${management.managerid}
						</sql:query>
					<%--------------------------------------- MANAGER LIST  --%>
					
    				<c:forEach var="manager" items="${resMan.rows}">
    					<c:out value="${manager.committeefullname}"/>
    				</c:forEach>
    				
    			</td>
    		</tr>
    		</c:if>
    	</c:forEach>
    	</table><br>
    	
		<button type="submit" name="update" formaction="CommitteeHandler?action=editManagementAcc&ID=<%=committee_id%>">KEMASKINI</button>
 	</form>


</body>
</html>