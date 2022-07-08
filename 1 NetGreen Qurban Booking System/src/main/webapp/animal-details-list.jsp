<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Senarai Haiwan</title>
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
	<h1 style="text-align: center; width: 100%">SENARAI HAIWAN</h1>
	
	<%-- ADD NEW ANIMAL DETAILS BUTTON --%>
	<button class="" onclick="location.href='createAnimalDetails.jsp'">TAMBAH HAIWAN BARU</button><br><br>
	
	<%-- LIST OF ANIMAL DETAILS --%>
	<table style="text-align: center; width: 100%" id="listAnimalDetails">
			<tr style="background-color: rgb(179, 255, 179);">
				<th style="width: 200px;">ID</th>
				<th style="width: 200px;">Jenis Haiwan</th>
				<th style="width: 200px;">Harga Seekor (RM)</th>
				<th style="width: 200px;">Nama Pembekal</th>
				<th style="width: 200px;">Tindakan</th>
			</tr>
		<c:forEach var="animalDetails" items="${result.rows}">
			<tr>
				<td>
					<c:out value="${animalDetails.animaldetailsid}"/>
				</td>
				<td>
					<c:out value="${animalDetails.animaltype}"/>
				</td>
				<td>
					<c:out value="${animalDetails.animalprice}"/>
				</td>
				<td>
					<c:if test="${animalDetails.suppliername  == null}">
						<c:out value="Tiada Pembekal"/>
					</c:if>	
					<c:if test="${animalDetails.suppliername  == ''}">
						<c:out value="Tiada Pembekal"/>
					</c:if>	
					<c:if test="${animalDetails.suppliername != null}">
						<c:out value="${animalDetails.suppliername}"/>
					</c:if>
				</td>
				<td> <%-- TINDAKAN --%>
					<form method="post"> <%-- UPDATE/KEMASKINI BUTTON --%>
						<input type="hidden" name="animalDetailsID" value="${animalDetails.animaldetailsid}">
						<button class="" formaction="editAnimalDetails.jsp">KEMASKINI</button>
					</form>
					<form method="post"> <%-- DELETE/PADAM BUTTON --%>
						<input type="hidden" name="animalDetailsID" value="${animalDetails.animaldetailsid}"> 	<%-- Set Animal Details ID --%> <%-- SERVLET REFERENCE --%>
						<input type="hidden" name="action" value="deleteAnimalDetails"> 						<%-- Set 'action' to 'deleteAnimalDetails' --%> <%-- SERVLET REFERENCE --%>
						<button class="" formaction="AnimalDetailsServlet">PADAM</button>
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>