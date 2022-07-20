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
<title>Senarai AJK</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>

	<style>

	body {
		padding: 0;
		margin: 0;
		font-family: Arial, Helvetica, sans-serif;
	}

	table{
                border-collapse: collapse; 
                border: 1px solid #bdc3c7;
                box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
                margin-left: 400px;
                margin-right: auto;
                margin-top: 20px;
                width: 60%;
            }

	th,
	td {
		padding: 12px;
		text-align: center;
		border-bottom: 1px solid #ddd;
	}

	.header{
			background-color: #037247;
			color: #fff;
            padding: 12px;
	}

	h1 {
			font-weight: 600;
			text-align: center;
			color: rgb(5, 5, 5);
			padding: 10px 0px;
            font-size: 30px;
			
			
		}
		.title {
			color: #ffffff;
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
            text-align: center;
			
		}
		.title h1{
			color: rgb(255, 255, 255);
		}

	@media only screen and (max-width: 768px) {
		table{
			width: 90%;
		}
	}

	.button {
		border: none;
		width: 150px;
		color: rgb(255, 255, 255);
		padding: 15px 32px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 14px;
		margin: 4px 2px;
		cursor: pointer;
		-webkit-transition-duration: 0.4s; /* Safari */
		transition-duration: 0.4s;
		font-family: Arial, Helvetica, sans-serif;
		border-radius: 5px;
		
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
		position: absolute;
		top:0px;
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
		// MANAGER ONLY
		int counter = 0;
		int committee_id;
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
	<%-- HEADER --%>

	<div class="header" style="height: 50px">
		<div>
			<span style="position: absolute; right: 20px; top:15px; font-size: 16px; height: 100px">NETGREEN</span>
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
                <li><a href="committee-list.jsp" onclick="location.href='committee-list.jsp'"><i class="fas fa-address-book"></i>Senarai AJK</a></li>
                <li><a href="client-list.jsp" onclick="location.href='client-list.jsp'"><i class="fas fa-address-book"></i>Senarai Klien</a></li>
                <li><a href="view-committee-account.jsp"><i class="fas fa-user"></i> Akaun</a></li>
                <li><a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i> Log Keluar</a></li>
    
            </ul> 
        </div>
    </div>
    
    <%-- THIS COMMITTEE LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="thisCom">
		SELECT * FROM committee WHERE committeeid = <%=committee_id %>
	</sql:query>
	<%----------------------------------------------------- COMMITTEE LIST --%>	
	
    <%-- COMMITTEE LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="result">
		SELECT * FROM committee ORDER BY committeeid
	</sql:query>
	<%----------------------------------------------------- COMMITTEE LIST --%>	
	
	<%-- MANAGEMENT LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="managementResult">
		SELECT * FROM management ORDER BY committeeid
	</sql:query>
	<%----------------------------------------------------- MANAGEMENT LIST --%>
	
	<%-- VOLUNTARY LIST  ----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="voluntaryResult">
		SELECT * FROM voluntary ORDER BY committeeid
	</sql:query>
	<%----------------------------------------------------- VOLUNTARY LIST --%>	
	
	<c:if test="">
	</c:if>
    
	<div class="title">
		<h1>SENARAI AJK</h1>
	</div>
    
    
    <button name="register" onclick="location.href='staff-choice.jsp'">DAFTAR AJK BARU</button>
    <br><br><br>
    
    <form method="post">
    <table>
    	<tr>
    		<th>No.</th>
    		<th>ID AJK</th>
    		<th>Nama AJK</th>
    		<th>Skop Kerja</th>
    		<th>No. Telefon</th>
    		<th>Tindakan</th>
    	</tr>
    	<%-- Management --%>
    	<c:forEach var="management" items="${managementResult.rows}">
    	<tr>
    		<% counter++; %>
    		<td><%=counter%></td>
    		<td><c:out value="${management.committeeID}"/></td>
    		<td><c:out value="${management.committeefullname}"/></td>
    		<td><c:out value="${management.managementposition}"/></td>
    		<td><c:out value="${management.committeephonenum}"/></td>
    		<td>
    			<button class="button" style="background-color: #4CAF50;" name="update" formaction="CommitteeHandler?action=viewManagement&ID=${management.committeeID}">KEMASKINI</button>
    			<c:forEach var="thisCom" items="${thisCom.rows}">
    				<c:if test="${management.committeeid != thisCom.committeeid}">
    					<c:if test="${management.managementposition != 'Pengerusi'}">
    						<button class="button" style="background-color: #ac2121;" name="delete" name="delete" formaction="CommitteeHandler?action=deleteManagement&ID=${management.committeeID}">PADAM</button>
    					</c:if>
    				</c:if>
    			</c:forEach>
    		</td>
    	</tr>
    	</c:forEach>
    	<%-- Voluntary --%>
    	<c:forEach var="voluntary" items="${voluntaryResult.rows}">
    	<tr>
    		<% counter++; %>
    		<td><%=counter%></td>
    		<td><c:out value="${voluntary.committeeID}"/></td>
    		<td><c:out value="${voluntary.committeefullname}"/></td>
    		<td><c:out value="${voluntary.voluntaryrole} (SUKARELAWAN)"/></td>
    		<td><c:out value="${voluntary.committeephonenum}"/></td>
    		<td>
    			<button class="button" style="background-color: #4CAF50;" name="update" formaction="CommitteeHandler?action=viewVoluntary&ID=${voluntary.committeeID}">KEMASKINI</button>
				<button class="button" style="background-color: #ac2121;" name="delete" formaction="CommitteeHandler?action=deleteVoluntary&ID=${voluntary.committeeID}">PADAM</button>
    		</td>
    	</tr>
    	</c:forEach>
    </table>
    </form>
</body>
</html>