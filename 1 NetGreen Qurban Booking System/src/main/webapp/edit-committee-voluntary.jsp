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
		int ID_committee; // committee to view
		Connection connection;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
	
		ID_committee = (int)request.getAttribute("ID_committee");
		
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
    
    
    <%-- VOLUNTARY DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="voluntaryResult">
		SELECT * FROM voluntary WHERE committeeid = <%=ID_committee%>
	</sql:query>
	<%--------------------------------------- VOLUNTARY DETAILS --%>
	
	<%-- MANAGER LIST ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="managerRes">
		SELECT * FROM management 
		WHERE managementposition = 'Pengerusi'
		OR managementposition = 'Naib Pengerusi'
	</sql:query>
	<%--------------------------------------- MANAGER LIST  --%>
		
    
    <h3>KEMASKINI MAKLUMAT AKAUN (SUKARELAWAN)</h3><br><br>
    
    <form method="post">
    	<table>
    	<c:forEach var="voluntary" items="${voluntaryResult.rows}">
    	 <%
    		try {
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare Statement
			PreparedStatement showSQL = connection.prepareStatement
			( "SELECT * FROM voluntary WHERE committeeid = ?");
			
			// ? value
			showSQL.setInt(1, ID_committee);
			
			// Execute SQL
			ResultSet result = showSQL.executeQuery();
		
			
			while (result.next()) {
		
			//--- Scriplet continued at the bottom
	 	%>
    		<tr>
    			<th>ID Akaun:</th>
    			<td>
    				<c:out value="${voluntary.committeeid}"/>
    				<input type="hidden" name="committeeID" value="<%=ID_committee%>">
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
    			<th>Skop Kerja:</th>
    			<td><input type="text" name="voluntaryRole" value='<%=result.getString("voluntaryrole")%>' readonly></td>
    		</tr>
    		<tr>
    			<th>Kadar Setiap Jam:</th>
    			<td><input type="number" name="hourlyRate" value='<%=result.getDouble("hourlyrate")%>' readonly></td>
    		</tr>
    		
    		<%
					}
    			} catch(Exception e){
    				e.printStackTrace();
    			}
    		
    		%>
    		<tr>
    			<th>Pengurus:</th>
    			<td>
    				<select name="managerID">
    				<c:forEach var="voluntary" items="${voluntaryResult.rows}">
    					<c:forEach var="managerlist" items="${managerRes.rows}">
    						<c:if test="${managerlist.committeeid == voluntary.managerid}">
    							<option value="${managerlist.committeeid}" selected><c:out value="${managerlist.committeefullname}"/></option>
    						</c:if>
    						<c:if test="${managerlist.committeeid != voluntary.managerid}">
    							<option value="${managerlist.committeeid}"><c:out value="${managerlist.committeefullname}"/></option>
    						</c:if>
    					</c:forEach>
    				</c:forEach>
    				</select>
    			</td>
    		</tr>
    	
    		
    	</c:forEach>
    	</table><br>
    	
		<button name="back" formaction="CommitteeHandler?action=viewVoluntary&ID=<%=ID_committee%>">BATAL</button>
		<button type="submit" name="update" formaction="CommitteeHandler?action=updateVoluntaryManagerOnly&ID=<%=ID_committee%>">SIMPAN</button>
 	</form>
</body>
</html>