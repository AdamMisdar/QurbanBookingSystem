<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="qurban.connection.ConnectionManager" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Tambah Haiwan Baru</title>

	<style>

		body {
			padding: 0;
			margin: 0;
			font-family: Arial, Helvetica, sans-serif;
		}

		table{
			position: absolute;
			left: 50%;
			top: 45%;
			transform: translate(-50%, -50%);
			border-collapse: collapse;
			width: 500px;
			height: 100px;
			border: 1px solid #bdc3c7;
			box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
		}

		input {
			width: 100%;
			padding: 12px 20px;
			margin: 8px 0;
			display: inline-block;
			border: 1px solid #ccc;
			border-radius: 4px;
			box-sizing: border-box;
		}

		th,
		td {
			padding: 10px;
			text-align: left;
			border-bottom: 1px solid #ddd;
		}

		#header{
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
			position:relative; left:435px; top:2px;
			
		}

		.button:hover {
			box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
		}
	</style>
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

		<table>
			<tr style="background-color: #037247;">
				<th style="color:#fff;">Informasi</th>
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
				
			</tr>
		</table>

			<button class="button" style="background-color: #db0f31;" name="action" value="cancel" formaction="AnimalDetailsServlet">Batal</button>
			<input type="hidden" name="action" value="createAnimalDetails"> <%-- SERVLET REFERENCE --%>
			<button type="submit" class="button" style="background-color: #4CAF50;">Tambah</button>
	</form>
	
</body>
</html>