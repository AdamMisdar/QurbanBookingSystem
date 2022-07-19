
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
<title>KEMASKINI AKAUN</title>
<link rel="stylesheet" href="style2.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
</head>
<body>

		<%!
		// MANAGER ONLY
		int committee_id; // mananager's committee id
		int ID_committee; // committee to view
		Connection connection;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
	
		ID_committee = (int)request.getAttribute("ID_committee");
		
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

    
    
    <%-- VOLUNTARY DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="voluntaryResult">
		SELECT * FROM voluntary WHERE committeeid = <%=ID_committee%>
	</sql:query>
	<%--------------------------------------- VOLUNTARY DETAILS --%>
	
	<%-- MANAGER LIST ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="managerRes">
		SELECT * FROM management 
		WHERE managementposition = 'Pengerusi'
		OR managementposition = 'Naib Pengerusi'
	</sql:query>
	<%--------------------------------------- MANAGER LIST  --%>

        <input type="checkbox" id="check">
    <!--header area start-->
    <header>
      <label for="check">
        <i class="fas fa-bars" id="sidebar_btn"></i>
      </label>
      <div class="left_area">
        <h3>NETGREEN </h3>
      </div>
      <div class="right_area">
        <a href="#" class="logout_btn">Masjid Al-Khairiah</a>
      </div>
    </header>
    <!--header area end-->
    <!--mobile navigation bar start-->
    <div class="mobile_nav">
      <div class="nav_bar">
        <img src="logo.png" class="mobile_profile_image" alt="">
        <i class="fa fa-bars nav_btn"></i>
      </div>
      <div class="mobile_nav_items">
        <a href="#index-committee.jsp" onclick="location.href='index-committee.jsp'"><i class="fas fa-home"></i><span>Laman Utama</span></a>
        <a href="#committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'"><i class="fas fa-clipboard-list"></i><span>Senarai Tempahan</span></a>
        <a href="#animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'"><i class="fas fa-list-alt"></i><span>Senarai Haiwan</span></a>
        <a href="#committee-list.jsp" onclick="location.href='committee-list.jsp'"><i class="fas fa-users-cog"></i><span>Senarai AJK</span></a>
        <a href="#client-list.jsp" onclick="location.href='client-list.jsp'"><i class="fas fa-users"></i><span>Senarai Klien</span></a>
        <a href="#view-client-account.jsp"><i class="fas fa-user-alt"></i><span>Akaun</span></a>
        <a href="#LoginHandler?action=logout" onclick="checkerlogout()" id="logout" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i><span> Log Keluar</span></a>
      
      </div>
     
    </div>
    <!--mobile navigation bar end-->
    <!--sidebar start-->
    <div class="sidebar">
      <div class="profile_info">
        <img src="logo.png" class="profile_image" alt="">
        <c:forEach var="committee" items="${resultCommittee.rows}">
						<p>NAME:<c:out value="${committee.committeefullname}"/></p>
						<p>POSITION:<c:out value="${committee.managementposition}"/></p>
		</c:forEach>
      </div>
      <a href="#index-committee.jsp" onclick="location.href='index-committee.jsp'"><i class="fas fa-home"></i><span>Laman Utama</span></a>
        <a href="#committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'"><i class="fas fa-clipboard-list"></i><span>Senarai Tempahan</span></a>
        <a href="#animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'"><i class="fas fa-list-alt"></i><span>Senarai Haiwan</span></a>
        <a href="#committee-list.jsp" onclick="location.href='committee-list.jsp'"><i class="fas fa-users-cog"></i><span>Senarai AJK</span></a>
        <a href="#client-list.jsp" onclick="location.href='client-list.jsp'"><i class="fas fa-users"></i><span>Senarai Klien</span></a>
        <a href="#view-client-account.jsp"><i class="fas fa-user-alt"></i><span>Akaun</span></a>
        <a href="#LoginHandler?action=logout" onclick="checkerlogout()" id="logout" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i> Log Keluar</a>
      
    </div>

    
<div class="content">
    <h1>KEMASKINI MAKLUMAT AKAUN (SUKARELAWAN)</h1>
    <div class="content-container">
    <form method="post">
    	<table class="content-table">
    	<c:forEach var="voluntary" items="${voluntaryResult.rows}">
  
    	 <%
    		try {
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare Statement
			PreparedStatement showSQL = connection.prepareStatement
			( "SELECT * FROM voluntary WHERE committeeid = ?");
			
			// ? value
			showSQL.setInt(1, ID_committee);
			
			// Execute SQL
			ResultSet result = showSQL.executeQuery();
		
			
			while (result.next()) {
		
			//--- Scriplet continued at the bottom
	 	%>

    		<tr>
    			<th>ID Akaun:</th>
    			<td>
    				<c:out value="${voluntary.committeeid}"/>
    				<input type="hidden" name="committeeID" value="<%=ID_committee%>">
    			</td>
    		</tr>
    		<tr>
    			<th>Nama Penuh:</th>
    			<td><input type="text" name="committeeFullName" value='<%=result.getString("committeefullname")%>'></td>
    		</tr>
    		<tr>
    			<th>No Telefon:</th>
    			<td><input type="text" name="committeePhoneNum" value='<%=result.getString("committeephonenum")%>'></td>
    		</tr>

    		
    		<tr>
    			<th>Tarikh Lahir:</th>
    			<td><input type="date" name="committeeBirthDate" value='<%=result.getString("committeebirthdate")%>'></td>
    		</tr>

			<tr>
    			<th>Alamat:</th>
    			<td><input type="text" name="committeeAddress" value='<%=result.getString("committeeaddress")%>'></td>
    		</tr>
    		<tr>
    			<th>Email:</th>
    			<td><input type="text" name="committeeEmail" value='<%=result.getString("committeeemail")%>'></td>
    		</tr>
    		<tr>
    			<th>Kata Laluan:</th>
    			<td><input type="password" name="committeePassword" value='<%=result.getString("committeepassword")%>'></td>
    		</tr>
    		<tr>
    			<th>Skop Kerja:</th>
    			<td><input type="text" name="voluntaryRole" value='<%=result.getString("voluntaryrole")%>' readonly></td>
    		</tr>
    		<tr>
    			<th>Kadar Setiap Jam:</th>
    			<td><input type="number" name="hourlyRate" value='<%=result.getDouble("hourlyrate")%>' readonly></td>
    		</tr>
    		
          
    		<%
					}
    			} catch(Exception e){
    				e.printStackTrace();
    			}
    		
    		%>
       
    		<tr>
    			<th>Pengurus:</th>
    			<td>
    				<select name="managerID">
    				<c:forEach var="voluntary" items="${voluntaryResult.rows}">
    					<c:forEach var="managerlist" items="${managerRes.rows}">
    						<c:if test="${managerlist.committeeid == voluntary.managerid}">
    							<option value="${managerlist.committeeid}" selected><c:out value="${managerlist.committeefullname}"/></option>
    						</c:if>
    						<c:if test="${managerlist.committeeid != voluntary.managerid}">
    							<option value="${managerlist.committeeid}"><c:out value="${managerlist.committeefullname}"/></option>
    						</c:if>
    					</c:forEach>
    				</c:forEach>
    				</select>
    			</td>
    		</tr>
    	
    		
    	</c:forEach>
    	</table><br>
    	
		<button name="back" class="buttoncancel" onclick="checkercancel()" formaction="CommitteeHandler?action=viewVoluntary&ID=<%=ID_committee%>">BATAL</button>
		<button type="submit" name="update"   class="buttonsave" onclick="checkerupdate()" formaction="CommitteeHandler?action=updateVoluntaryManagerOnly&ID=<%=ID_committee%>">SIMPAN</button>
 	</form>
    </div>

</div>
<script>
    function checkerlogout(){
            var result=confirm('Log Keluar?')
            if (result==false){
                event.preventDefault();
            }
        }
        function checkercancel(){
            var result=confirm('Kembali?')
            if (result==false){
                event.preventDefault();
            }
        }

        function checkerupdate(){
            var result=confirm('Selesai?')
            if (result==false){
                event.preventDefault();
            }
        }
   </script>
    
</body>
</html>