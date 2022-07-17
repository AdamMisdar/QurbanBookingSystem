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
<title>KEMASKINI AKAUN</title>
</head>
<body>	
	<%!
		// MANAGER ONLY
		int committee_id; // mananager's committee id
		Connection connection;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
	
	
		boolean isManager = (boolean)session.getAttribute("isManager");

		
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
    <% if (isManager) { %>
    <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'">Senarai AJK</a><br>
    <a href="client-list.jsp" onclick="location.href='client-list.jsp'">Senarai Klien</a><br>
    <% } %>
    <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'">  Akaun</a><br>
    <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'">  Log Keluar</a><br>
    
    
    <%-- MANAGEMENT DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="managementResult">
		SELECT * FROM management WHERE committeeid = <%=committee_id%>
	</sql:query>
	<%--------------------------------------- MANAGEMENT DETAILS --%>

		
    
    <h3>KEMASKINI MAKLUMAT AKAUN (PENGURUSAN)</h3><br><br>
    
    <form method="post">
    	<table>
    	<c:forEach var="management" items="${managementResult.rows}">
    	 <%
    		try {
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare Statement
			PreparedStatement showSQL = connection.prepareStatement
			( "SELECT * FROM management WHERE committeeid = ?");
			
			// ? value
			showSQL.setInt(1, committee_id);
			
			// Execute SQL
			ResultSet result = showSQL.executeQuery();
		
			
			while (result.next()) {
				
				if(result.getString("managementposition").equalsIgnoreCase("Pengerusi")) {
					//request.setAttribute("isPengerusi", "yes");
					%><input type="hidden" name="isPengerusi" value="yes"><%
					System.out.println("yes pengerusi");
				}
				else {
					//request.setAttribute("isPengerusi", "no");
					%><input type="hidden" name="isPengerusi" value="no"><%
				}
		
			//--- Scriplet continued at the bottom
	 	%>
    		<tr>
    			<th>ID Akaun:</th>
    			<td>
    				<c:out value="${management.committeeid}"/>
    				<input type="hidden" name="committeeID" value="<%=committee_id%>">
    			</td>
    		</tr>
    		<tr>
    			<th>Nama Penuh:</th>
    			<td><input type="text" name="committeeFullName" value='<%=result.getString("committeefullname")%>'></td>
    		</tr>
    		<tr>
    			<th>No Telefon:</th>
    			<td><input type="text" name="committeePhoneNum" value='<%=result.getString("committeephonenum")%>'></td>
    		</tr>

    		
    		<tr>
    			<th>Tarikh Lahir:</th>
    			<td><input type="date" name="committeeBirthDate" value='<%=result.getString("committeebirthdate")%>'></td>
    		</tr>

			<tr>
    			<th>Alamat:</th>
    			<td><input type="text" name="committeeAddress" value='<%=result.getString("committeeaddress")%>'></td>
    		</tr>
    		<tr>
    			<th>Email:</th>
    			<td><input type="text" name="committeeEmail" value='<%=result.getString("committeeemail")%>'></td>
    		</tr>
    		<tr>
    			<th>Kata Laluan:</th>
    			<td><input type="password" name="committeePassword" value='<%=result.getString("committeepassword")%>'></td>
    		</tr>
    		<tr>
    			<th>Jawatan:</th>
    			<td><input type="text" name="managementPosition" value='<%=result.getString("managementposition")%>' readonly></td>
    		</tr>
    		
    		<%
					}
    			} catch(Exception e){
    				e.printStackTrace();
    			}
    		
    		%>		
			<%-- MANAGER LIST ---------------------------------------%>
				<sql:query dataSource="${qurbanDatabase}" var="managerRes">
					SELECT * FROM management 
					WHERE committeeid = ${management.managerid}
				</sql:query>
			<%--------------------------------------- MANAGER LIST  --%>
    		<tr>	
    			<th>Pengurus:</th>
    			<td><td><input type="text" value="${managerRes.committeefullname}" readonly></td>
    		</tr>
    		
    	</c:forEach>
    	</table><br>
    	
		<button name="back" formaction="view-committee-management-account.jsp">BATAL</button>
		<button type="submit" name="update" formaction="CommitteeHandler?action=updateManagement&committeeID=<%=committee_id%>">SIMPAN</button>
 	</form>
</body>
</html>