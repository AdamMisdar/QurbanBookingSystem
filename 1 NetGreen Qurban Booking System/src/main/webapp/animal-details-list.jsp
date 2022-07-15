<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Senarai Haiwan</title>


	<style>

	body {
		padding: 0;
		margin: 0;
		font-family: Arial, Helvetica, sans-serif;
	}

	table {
		position: absolute;
		left: 50%;
		top: 45%;
		transform: translate(-50%, -50%);
		border-collapse: collapse;
		width: 800px;
		height: 100px;
		border: 1px solid #bdc3c7;
		box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
	}

	th,
	td {
		padding: 12px;
		text-align: center;
		border-bottom: 1px solid #ddd;
	}

	#header {
		background-color: #037247;
		color: #fff;
	}

	h1 {
		background-color: #037247;
		font-weight: 600;
		text-align: center;
		color: rgb(255, 255, 255);
		padding: 10px 0px;
	}

	@media only screen and (max-width: 768px) {
		table{
			width: 90%;
		}
	}

	.button {
		border: none;
		width: 150px;
		color: white;
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
		
	}

	.button:hover {
		box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
	}
	</style>
	
</head>
<body>
	<%-- DATABASE --%>
	<sql:setDataSource	var="qurbanDatabase" driver="oracle.jdbc.driver.OracleDriver"
						url="jdbc:oracle:thin:@localhost:1521:xe"
						user="netgreen"
						password="system" />
						

	<%-- SQL QUERY - DISPLAY ALL ANIMAL DETAILS --%>
	<sql:query dataSource="${qurbanDatabase}" var="result">
	   SELECT * FROM animaldetails ORDER BY animaldetailsid
	</sql:query>
	
	<%-- HEADER --%>
	<a href="committee-homepage.jsp">Ke Laman Utama</a>
	<h1 style="text-align: center; width: 100%">SENARAI HAIWAN</h1>
	
	<%-- ADD NEW ANIMAL DETAILS BUTTON --%>
	<button class="button" style="background-color: #4CAF50; width: 200px; position:relative; left:280px; top:2px;" onclick="location.href='createAnimalDetails.jsp'">TAMBAH HAIWAN BARU</button><br><br>
	
	<%-- LIST OF ANIMAL DETAILS --%>
        <table id="listAnimalDetails">
                <tr id="header">
				<th style="width: 200px;">Jenis Haiwan</th>
				<th style="width: 200px;">Harga Seekor (RM)</th>
				<th style="width: 200px;">Tindakan</th>
			</tr>
		<c:forEach var="animalDetails" items="${result.rows}">
			<tr>
				<td>
					<c:out value="${animalDetails.animaltype}"/>
				</td>
				<td>
					<c:out value="${animalDetails.animalprice}"/>
				</td>
				<td> <%-- TINDAKAN --%>
					<form method="post"> <%-- UPDATE/KEMASKINI BUTTON --%>
						<input type="hidden" name="animalDetailsID" value="${animalDetails.animaldetailsid}">
						<button class="button" style="background-color: #4CAF50;" formaction="editAnimalDetails.jsp">KEMASKINI</button>
					</form>
					<form method="post"> <%-- DELETE/PADAM BUTTON --%>
						<input type="hidden" name="animalDetailsID" value="${animalDetails.animaldetailsid}"> 	<%-- Set Animal Details ID --%> <%-- SERVLET REFERENCE --%>
						<input type="hidden" name="action" value="deleteAnimalDetails"> 						<%-- Set 'action' to 'deleteAnimalDetails' --%> <%-- SERVLET REFERENCE --%>
						<button class="button" style="background-color: #db0f31;" formaction="AnimalDetailsServlet" onclick="checkDelete()">PADAM</button>
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
	<script>
	function checkDelete() {
		var result = confirm('Anda pasti buang haiwan ini?');
		if (result == false) {
			event.preventDefault();
		}
	}
	
	</script>

	
</body>
</html>