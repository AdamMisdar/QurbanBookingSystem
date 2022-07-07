<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="qurban.connection.ConnectionManager" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Tambah Haiwan Baru</title>
</head>
<body>

	<%-- Connect To Database (Nak Check Animal tu dah ada ke tak) --%>
	<%--
		try{
			Connection connection = ConnectionManager.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	--%>
	
	<%-- Start JSP --%>
	<h1 style="text-align: center; width: 100%;">TAMBAH HAIWAN BARU</h1>
	
	<form method="post" action="AnimalDetailsServlet">
	
		<table style="width: 500px;  align-items: center;">
			<tr style="background-color: rgb(179, 255, 179);">
				<th>Informasi</th>
				<th></th>
			</tr>
			<tr>
				<td>
					<label>Jenis Haiwan:</label>
				</td>
				<td>
				<%-- TAMBAH CONSTRAINT TO CHECK FOR EXISTING TYPE OF ANIMAL --%>
					<input type="text" name="animalType" value="" placeholder="Lembu/Kambing/Unta">
				</td>
			</tr>
			<tr>
				<td>
					<label>Harga Seekor:</label>
				</td>
				<td>
					<input type="number" name="animalPrice" value="" placeholder="Harga (RM)">
				</td>
			</tr>
			<tr>
				<td>
					<label>Nama Pembekal:</label>
				</td>
				<td>
					<input type="text" name="supplierName" value="" placeholder="...">
				</td>
			</tr>
			
		</table>
		<button class="" name="action" value="cancel" formaction="AnimalDetailsServlet">Batal</button>
		
		<input type="hidden" name="action" value="createAnimalDetails"> <%-- SERVLET REFERENCE --%>
		<button type="submit" class="">Tambah</button>
	</form>
	
</body>
</html>