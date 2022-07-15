<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%-- LOGIN REQUIREMENT  -------------------------------------------------%>
	<%!
		int committee_id;
		String committeeType;
		Connection connection;
		String manSQL, volSQL;
		boolean checkManagement = false, checkVoluntary = false, isManager = false;
		ResultSet resultManagement, resultVoluntary;
	%>
	<%
	//user has not logged in
	if(session.getAttribute("committeeID") == null) {
		
		//redirect user to login page
		response.sendRedirect("login.jsp");
	}
	else {
		
		// Get client
		committee_id = (int)session.getAttribute("committeeID");
	}
	%>
<%------------------------------------------------- LOGIN REQUIREMENT  --%>

<%-- CHECK MANAGEMENT/VOLUNTARY ---------------------------------------------%>
	<%
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

		
		if (checkManagement) {
			String position = resultManagement.getString("managementposition");
			
			if (position.equalsIgnoreCase("Pengerusi") || position.equalsIgnoreCase("Naib Pengerusi")){
				isManager = true;
				System.out.println("Manager? : " + isManager);
			}
			else {
				isManager = false;
				System.out.println("Manager? : " + isManager);
			}
			
		}
		
		if (checkVoluntary) {

				committeeType="Voluntary";
				System.out.println("Manager? : Voluntary");
			
		}
		
		
/*		if(isManager){
			response.sendRedirect("indexcommitteemanager.jsp");
		}
*/		
		%>

<%-- CHECK MANAGEMENT/VOLUNTARY ---------------------------------------------%>

	<%-- DATABASE --%>
	<sql:setDataSource	var="qurbanDatabase" driver="oracle.jdbc.driver.OracleDriver"
						url="jdbc:oracle:thin:@localhost:1521:xe"
						user="netgreen"
						password="system" />
						
	<%
		if(checkManagement){
	
	%>
	<%-- SQL QUERY - DISPLAY MANAGEMENT --%>
	<sql:query dataSource="${qurbanDatabase}" var="resultMan">
	   SELECT * FROM committee JOIN management USING (committeeid) WHERE committeeid = <%=committee_id%>
	</sql:query>
	<%
		} else if (checkVoluntary) {
	%>	
	<%-- SQL QUERY - DISPLAY VOLUNTARY --%>
	<sql:query dataSource="${qurbanDatabase}" var="resultVol">
	   SELECT * FROM committee JOIN voluntary USING (committeeid) WHERE committeeid = <%=committee_id%>
	</sql:query>
	
	<% 
		}
	
	%>	
	
	
	<% if(checkManagement) { %>
	
		<c:forEach var="management" items="${resultMan.rows}">

		<div class="header" style="width=100%; padding:10px ; background-color: #4dff88;">
			<div>
				<span style="position: absolute; right: 20px; top:25px; font-size: 20px">NETGREEN</span>
				<span><c:out value="${management.committeefullname}"/></span>
			</div>
			<div>
				<span>
					<c:out value="${management.managementposition}"/> (PENGURUSAN)
					<% if(isManager) {%>
					<c:out value=" (PENGURUS)"/>
					<% } %>
				</span>
				<form method="post"><button style="margin-left:20px;" formaction="LoginHandler?action=logout">Log Keluar</button></form>
			</div>
		</div>
		</c:forEach>
	<% } else if(checkVoluntary) { %>
	
		<c:forEach var="voluntary" items="${resultVol.rows}">

		<div class="header" style="width=100%; padding:10px ; background-color: #4dff88;">
			<div>
				<span style="position: absolute; right: 20px; top:25px; font-size: 20px">NETGREEN</span>
				<span><c:out value="${voluntary.committeefullname}"/></span>
			</div>
			<div>
				<span>
					<c:out value="${voluntary.voluntaryrole}"/> (SUKARELAWAN)
				</span>
				<form method="post"><button style="margin-left:20px;" formaction="LoginHandler?action=logout">Log Keluar</button></form>
			</div>
		</div>
		</c:forEach>
	<% } %>
	
		<h1>SISTEM TEMPAHAN KORBAN</h1>
		<h3>Tindakan</h3>
		
		<a href="">Akaun</a><br>
		
	<% if (checkManagement) { %>
		
		<a href="">Senarai Tempahan</a><br>
		<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
		<a href="">Senarai Klien</a><br>
		
		<% if (isManager) { %>
		<a href="committee-list.jsp" >Senarai AJK</a><br>
		<% } %>
		
	<% } %>


</body>
</html>