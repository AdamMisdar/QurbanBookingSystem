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
<title>Akaun</title>
</head>
<body>
	<%-- LOGIN REQUIREMENT--%>
    <%!
    	int client_id;
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
	

    <%-- DATABASE --%>
	<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
						
	<%-- SQL QUERY - CLIENT--%>
	<sql:query dataSource="${qurbanDatabase}" var="resultClient">
	   SELECT * FROM client WHERE clientid = <%=client_id%>
	</sql:query>
	
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
    
    <h1>MAKLUMAT AKAUN</h1><br><br>
    
    <table>
    	<c:forEach var="client" items="${resultClient.rows}">
    	<tr>
    		<td style="width: 100px;">Nama: </td>
    		<td><c:out value="${client.clientfullname}"/></td>
    	</tr>
    	<tr>
    		<td>No. Telefon: </td>
    		<td><c:out value="${client.clientphonenum}"/></td>
    	</tr>
    	<tr>
    		<td>Email: </td>
    		<td><c:out value="${client.clientemail}"/></td>
    	</tr>
    	<tr>
    		<td>Tarikh Lahir: </td>
    		<td><c:out value="${client.clientbirthdate}"/></td>
    	</tr>
    	<tr>
    		<td>Alamat</td>
    		<td><c:out value="${client.clientaddress}"/></td>
    	</tr>
    	<tr>
    		<td>Password: </td>
    		<td><input type="password"  value="${client.clientpassword}" readonly></td>
    	</tr>
    	</c:forEach>
    </table><br>
    
    <button name="update" onclick="location.href='edit-client-account.jsp'">KEMASKINI AKAUN</button>
    
  
    
    
    
    


</body>
</html>