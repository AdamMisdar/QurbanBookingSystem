<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Daftar Akaun</title>
</head>
<body>

	<h1>Daftar Akaun</h1>
	<p>Akaun Klien</p>

	<form method="post">
		<table style="text-align: left; width: 70%;">
			<tr>
				<th>Nama Penuh: </th>
				<td><input type="text" name="clientFullName" required></td>
			</tr>
			<tr>
				<th>Email :</th>
				<td><input type="email" name="clientEmail" required></td>
			</tr>
			<tr>
				<th>No. Telefon: </th>
				<td><input type="text" name="clientPhoneNum" required></td>
			</tr>
			<tr>
				<th>Alamat: </th>
				<td><input type="text" name="clientAddress" required></td>
			</tr>
			<tr>
				<th>Tarikh Lahir: </th>
				<td><input type="date" name="clientBirthDate" required></td>
			</tr>
			<tr>
				<th>Kata Laluan: </th>
				<td><input type="password" name="clientPassword" required></td>
			</tr>
			<tr>
				<th>Masukkan semula Kata Laluan: </th>
				<td><input type="password" name="clientReenterPassword" required></td>
			</tr>
		</table><br>
		
		<button type="submit" name="submit" formaction="ClientHandler?action=createClient" onclick="checkSubmit()">Daftar Akaun</button>

	</form><br><br>
	
	Sudah ada akaun? <a href="login.jsp">Log Masuk</a>
	

</body>
</html>