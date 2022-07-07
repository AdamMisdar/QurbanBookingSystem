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
	<%-- Connect To Database --%>
	<%
			
		
			// Get Connection
			Connection connection = ConnectionManager.getConnection();
			
			// Get values
			int animalDetailsID = Integer.parseInt(request.getParameter("animalDetailsID"));
			
			// Prepare Statement
			PreparedStatement checkSQL = connection.prepareStatement
			( "SELECT * FROM animaldetails WHERE animalDetailsID = ?");
			
			// ? value
			checkSQL.setInt(1, animalDetailsID);
			
			// Execute SQL
			ResultSet result = checkSQL.executeQuery();
			
			while (result.next()) {
		
			//--- Scriplet continued at the bottom
	%> 
	
	<%-- Start JSP --%>
	<h1 style="text-align: center; width: 100%;">KEMASKINI HAIWAN</h1>
	
	<form method="post">
	
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
					<c:out value='<%=result.getString("animaltype")%>'></c:out>
				</td>
			</tr>
			<tr>
				<td>
					<label>Harga Seekor:</label>
				</td>
				<td> 
					<input type="number" name="animalPrice" value='<%=result.getDouble("animalprice")%>' placeholder="Harga (RM)">
				</td>
			</tr>
			<tr>
				<td>
					<label>Nama Pembekal:</label>
				</td>
				<td>
					<c:choose>
						<c:when test='${result.getString("suppliername") == ""}'>
							<input type="text" name="supplierName" value='' placeholder="...">
						</c:when>
						<c:otherwise>
							<input type="text" name="supplierName" value='<%=result.getString("suppliername")%>' placeholder="...">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
		<input type="hidden" name="animalDetailsID" value='<%=result.getString("animaldetailsid")%>'> <%-- SERVLET REFERENCE --%>
		
		<% 	// Continuation of Scriplet
			}
		%>
		<button class="" name="action" value="cancel" formaction="AnimalDetailsServlet">Batal</button>
		
		<input type="hidden" name="action" value="updateAnimalDetails"> <%-- SERVLET REFERENCE --%>
		<button type="submit" class="" formaction="AnimalDetailsServlet">Kemaskini</button>
	</form>
	

	
</body>
</html>