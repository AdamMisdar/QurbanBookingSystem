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
<title>Daftar Akaun</title>
</head>
<body>
<%-- DATABASE -----------------------------------------------------------%>
	<sql:setDataSource	var="qurbanDatabase" driver="oracle.jdbc.driver.OracleDriver"
						url="jdbc:oracle:thin:@localhost:1521:xe"
						user="netgreen"
						password="system" />
<%----------------------------------------------------------- DATABASE --%>

<%-- COMMITTEE DETAILS -----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="result">
		SELECT * 
		FROM management 
		JOIN committee
		USING (committeeid)
		WHERE managementposition = 'Pengerusi' OR managementposition = 'Naib Pengerusi'
	</sql:query>
<%----------------------------------------------------- COMMITTEE DETAILS --%>

	<h1>Daftar Akaun</h1>
	<p>Akaun AJK</p>
	
	<form method="post">
		<table style="text-align: left; width: 70%;">
			<tr>
				<th>Jenis AJK: </th>
				<td>
					<select name="committeeType">
						<option value="management">PENGURUSAN</option>
						<option value="voluntary">SUKARELAWAN</option>	
					</select>
				</td>
			</tr>
			<tr>
				<th>Jawatan/Peranan: </th>
				<td><input type="text" name="committeePosition" required></td>
			</tr>
			<tr>
				<th>Pengurus: </th>
				<td>
					<select name="managerID">
						<c:forEach var="committee" items="${result.rows}">
							<option value="${committee.committeeid}"><c:out value="${committee.committeefullname}"/></option>
						</c:forEach>
					</select>
					
				</td>
			</tr>
			<tr>
				<th>Nama Penuh: </th>
				<td><input type="text" name="committeeFullName" required></td>
			</tr>
			<tr>
				<th>Email :</th>
				<td><input type="email" name="committeeEmail" required></td>
			</tr>
			<tr>
				<th>No. Telefon: </th>
				<td><input type="text" name="committeePhoneNum" required></td>
			</tr>
			<tr>
				<th>Alamat: </th>
				<td><input type="text" name="committeeAddress" required></td>
			</tr>
			<tr>
				<th>Tarikh Lahir: </th>
				<td><input type="date" name="committeeBirthDate" required></td>
			</tr>
			<tr>
				<th>Kata Laluan: </th>
				<td><input type="password" name="committeePassword" required></td>
			</tr>
			<tr>
				<th>Masukkan semula Kata Laluan: </th>
				<td><input type="password" name="committeeReenterPassword" required></td>
			</tr>
		</table><br>
		
		<button type="submit" name="submit" formaction="CommitteeHandler?action=createCommittee" onclick="checkSumbit()">Daftar Akaun</button>

	</form><br><br>
	
	Bukan AJK? <a href="client-registration.jsp">Daftar sebagai Klien</a><br><br>
	Sudah ada akaun? <a href="login.jsp">Log Masuk</a>
	
	<script>
		function checkSubmit() {
			var alert = alert('Daftar Berjaya. Sila log masuk akaun anda.');
			
		}
	</script>

</body>
</html>