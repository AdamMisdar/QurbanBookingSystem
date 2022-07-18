
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.ConnectionManager" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Senarai Tempahan</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>


<style>
    body{
    margin: 0;
    padding: 0;
    font-family: "Roboto", sans-serif;
    background-color: #e0f1ee;
  }
  header{
    z-index: 1;
    position: fixed;
    background: #023f35;
    padding: 20px;
    width: calc(100% - 0%);
    top: 0;
    height: 30px;
  }
  p{
    color:white;
    text-align: center;
    font-size: 15px;
    font-weight: 700;
  }
  .left_area h3{
    color: rgb(255, 255, 255);
    margin: 0;
    text-transform: uppercase;
    font-size: 22px;
    font-weight: 900;
    position: relative;
    display: inline-block;
    left: 50px;
  }
  
  .left_area span{
    color: #19B3D3;
  }
  
  .logout_btn{
    padding: 5px;
    background: transparent;
    text-decoration: none;
    float: right;
    margin-top: -30px;
    margin-right: 40px;
    border-radius: 2px;
    font-size: 18px;
    font-weight: 600;
    color: #fff;
    transition: 0.5s;
    transition-property: background;
  }
  
  .logout_btn:hover{
    background: transparent;
    color: rgb(146, 226, 209);
  }
  
  .sidebar{
    z-index: 1;
    top: 0;
    background: #023028;
    margin-top: 70px;
    padding-top: 30px;
    position: fixed;
    left: 0;
    width: 200px;
    height:calc(100% - 7%);;
    transition: 0.5s;
    transition-property: left;
    padding: 6px 14px;
    overflow: hidden;
    
  }
  
  .profile_info{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  
  .sidebar .profile_info .profile_image{
    width: 100px;
    height: 100px;
    border-radius: 100px;
    margin-bottom: 10px;
  }
  
  .sidebar .profile_info h4{
    color: #ccc;
    margin-top: 0;
    margin-bottom: 20px;
  }
  
  .sidebar a{
    color: #fff;
    display: block;
    width: 100%;
    line-height: 60px;
    text-decoration: none;
    padding-left: 20px;
    box-sizing: border-box;
    transition: 0.5s;
    transition-property: background;
    border-radius: 5px ;
    margin: 1px 5px;
  }
  
  
  .sidebar a:hover{
    background: #038d86;
  }
  
  .sidebar i{
    padding-right: 10px;
  }
  
  label #sidebar_btn{
    z-index: 1;
    color: #fff;
    position: fixed;
    cursor: pointer;
    left: 25px;
    font-size: 20px;
    margin: 5px 0;
    transition: 0.5s;
    transition-property: color;
  }
  
  label #sidebar_btn:hover{
    color: #19B3D3;
  }
  
  #check:checked ~ .sidebar{
    left: -185px;
  }
  
  #check:checked ~ .sidebar a span{
    display: none;
  }
  
  #check:checked ~ .sidebar a{
    font-size: 20px;
    margin-left: 140px;
    width: 100%;
    border: solid 0px white;
    padding-left: 40px;
    margin-top: 5px;
  }
  
  
  .content{
    width: (100% - 250px);
    margin-top: 100px;
    padding: 20px;
    margin-left: 250px;
    background-position: center;
    background-size: cover;
    height: 100%;
    transition: 0.5s;
    position: relative;

  
  }
  .content-container{
    background-color: #e7f0ee;
     position: relative;
    flex-direction: column;
    height: 80%;
    width: 70%;
    margin: auto;
    padding-top:100px;
  }
  
  #check:checked ~ .content{
    margin-left: 60px;
  }
  
  #check:checked ~ .sidebar .profile_info{
    display: none;
  }
  
  #check{
    display: none;
  }
  
  .mobile_nav{
    display: none;
  }
  
  .content .card p{
    background: #fff;
    padding: 15px;
    margin-bottom: 10px;
    font-size: 14px;
    opacity: 0.8;
  }

  #logout{
    margin-top: 300px;
    border: solid 0.5px white;
  }
  #logout:hover{
    background: #c00d00;
  }
  #center{
    text-align: center;
  }
  .content h1{
    margin: 10px 20px;
    color: #009879;
    position: relative;
    display: flex;
    justify-content: center;
    margin-top: 50px;

}
.content h2{
  margin: 10px 20px;
  color: #009879;
  position: relative;
  display: flex;
  justify-content: center;
  margin-top: 50px;

}
.content p{
    margin: 10px 20px;
    color: #011813;
    position: relative;
    display: flex;
    justify-content:center;
    margin-top: 5px;
    font-weight: 700;
}


  .container-booking{
    background-color: rgb(184, 223, 211);
    position: relative;
    grid-area: container-booking;
    width: 100%;
    border-radius: 20px;
  }


  .container-price{
    background-color: rgb(184, 223, 211);
    grid-area: container-price;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    overflow: hidden;
    padding: 100px;
    border-radius: 20px;
  }

  

  .container-list{
    background-color: rgb(184, 223, 211);
    grid-area: container-list;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    overflow: hidden;
    padding: 50px;
    border-radius: 20px;
    
  }

.content-table th{
  vertical-align:middle;
  background-color: #e3eeec;
  margin: center;
  width:50%;
  text-align: center;
}
   
.content-table {
  border-collapse: collapse;
  margin: 25px 0;
  font-size: 1.0em;
  width: 800px;
  border-radius: 5px 5px 0 0;
  overflow: hidden;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
  font-weight: 600;
  margin: auto;
  border-radius: 10px;
  box-shadow: 0px 0px 14px 2px rgba(158, 155, 155, 0.75);
}

.content-table thead tr {
  background-color: #009879;
  color: #ffffff;
  text-align: left;
  font-weight: bold;
  
}

.content-table th,
.content-table td {
  padding: 15px 15px;
  
}
.content-table td,th{
  border: 1px solid rgb(203, 204, 204);
}
.content-table tbody tr {
  border-bottom: 1px solid #dddddd;
 
  
}
.content-table tbody tr:nth-of-type(odd) {
  background-color: #f3f3f3;
  
}

.content-table tbody tr:nth-of-type(even) {
  background-color: #f3f3f3;
  
}
.content-table tbody tr:last-of-type {
  border-bottom: 2px solid #009879;
}
.content-table tbody tr:first-of-type {
  border-top: 2px solid #009879;
}

button{
    display: flex;
    background-color: rgb(0, 128, 85);
    width: 200px;
    height: 50px;
    text-align: justify;
    padding: auto;
    align-items: center;
    justify-content: center;
    position: relative;
    color: white;
    border: transparent;
    border-radius: 10px;
    margin: auto;
    margin-top:10px;
    font-size: 0.9em;
    
}
.buttoncancel {
  float: left;
  left: 550px;
  background-color: rgb(172, 34, 16);
}
.buttonsave {
  float:right;
  right: 550px;
}

.buttoncancel:hover{
  background-color: rgb(228, 34, 34);
  cursor: pointer;
}
.buttonsave:hover{
  background-color: rgb(4, 167, 77);
  cursor: pointer;
}
.buttonadd{
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}
.buttonadd:hover{
  background-color: #009879;
  cursor: pointer;
}
.buttonview{
  text-transform: uppercase;
}
.buttonview:hover{
  text-transform: uppercase;
  background-color: #01b18b;
  box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
  cursor: pointer;
}
.buttondelete{
  background-color:rgb(177, 6, 6) ;
  
}
.buttondelete:hover{
  text-transform: uppercase;
  background-color: #f11e17;
  box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
  cursor: pointer;
}



  
/*
  table{
              border-collapse: collapse; 
              border: 1px solid #0e75b9;
              box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
              margin-left: auto;
              margin-right: auto;
              
          }
  th,
  td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid rgb(145, 6, 6);
    width: 100%;
  }
  */

  .button {
    border: none;
    padding: 15px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    -webkit-transition-duration: 0.4s; 
    transition-duration: 0.4s;
    font-family: Arial, Helvetica, sans-serif;
    border-radius: 5px;
    
}
#buttonhome{
    position: absolute;
    font-size: 16px;
}

.button:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
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
          -webkit-transition-duration: 0.4s; 
          transition-duration: 0.4s;
          font-family: Arial, Helvetica, sans-serif;
          border-radius: 5px;
  }
  
  .center_button{
    text-align: center;
  }

  .button:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
  }

   /* Responsive CSS */
  
   @media screen and (max-width: 780px){
    .sidebar{
      display: none;
    }
  
    #sidebar_btn{
      display: none;
    }
  
    .content{
      margin-left: 0;
      margin-top: 0;
      padding: 10px 20px;
      transition: 0s;
    }
  
    #check:checked ~ .content{
      margin-left: 0;
    }
  
    .mobile_nav{
      display: block;
      width: calc(100% - 0%);
    }
  
    .nav_bar{
      background: #222;
      width: (100% - 0px);
      margin-top: 70px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
    }
  
    .nav_bar .mobile_profile_image{
      width: 50px;
      height: 50px;
      border-radius: 50%;
    }
  
    .nav_bar .nav_btn{
      color: #fff;
      font-size: 22px;
      cursor: pointer;
      transition: 0.5s;
      transition-property: color;
    }
  
    .nav_bar .nav_btn:hover{
      color: #19B3D3;
    }
  
    .mobile_nav_items{
      background: #2F323A;
      display: none;
    }
  
    .mobile_nav_items a{
      color: #fff;
      display: block;
      text-align: center;
      letter-spacing: 1px;
      line-height: 60px;
      text-decoration: none;
      box-sizing: border-box;
      transition: 0.5s;
      transition-property: background;
    }
  
    .mobile_nav_items a:hover{
      background: #19B3D3;
    }
  
    .mobile_nav_items i{
      padding-right: 10px;
    }
  
    .active{
      display: block;
    }
  }

  
        

</style>
</head>
<body>
	
	<%!
		int committee_id;
		int counter;
		boolean isManager;
	%>
	<%
		if (session.getAttribute("committeeID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			committee_id = (int)session.getAttribute("committeeID");
		}
		counter = 0;
		
		isManager = (boolean)session.getAttribute("isManager");
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
	%>
<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>

<%-- COMMITTEE MANAGEMENT DETAILS ---------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="committeeResult">
		SELECT * FROM management WHERE committeeid = <%=committee_id%>
	</sql:query>
<%----------------------------------------------------- COMMITTEE MANAGEMENT DETAILS --%>
		<div class="header">
			<div>
				<span style="position: absolute; right: 20px; top:7px; font-size: 16px; color:white;">NETGREEN</span>
				<span></span>
			</div>
		</div>
		

	
		<div class="wrapper">
			<div class="sidebar">
				<h2>PENGURUSAN</h2>
					<c:forEach var="committee" items="${committeeResult.rows}">
						<p style="position:relative; color: rgb(253, 253, 253); font-weight: bold; text-align:left; left: 18px">
						<c:out value="${committee.committeefullname}"/>
						</p>
						<p style="position:relative; color: rgb(253, 253, 253); text-align:left; left: 18px;">
						<c:out value="${committee.managementposition}"/>
						</p>
					</c:forEach>
				<ul>
                        <li>
                            <a href="index-committee.jsp" onclick="location.href='index-committee.jsp'">Laman Utama <span class="sr-only">(current)</span></a>
                        </li>
                        <li>
                            <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'">Senarai Tempahan</a>
                        </li>
                        <li>
                            <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'">Senarai Maklumat Haiwan</a>
                        </li>
                        <% if (isManager) { %>
                        <li>
                            <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'">Senarai AJK</a>
                        </li>
                        <li>
                            <a href="client-list.jsp" onclick="location.href='client-list.jsp'">Senarai Klien</a>
                        </li>      
                        <% } %>      
                        <li>
                            <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'"><i class="far fa-user"></i>  Akaun</a>
                        </li>
                        <li>
                            <a href="LoginHandler?action=logout" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i> Log Keluar</a>
                        </li>
				</ul> 
			</div>
		</div>
	

	<%-- BOOKING DETAILS --%>
	<sql:query dataSource="${qurbanDatabase}" var="bookingResult">
		SELECT * 
		FROM payment
		JOIN booking
		USING (bookingid)
		JOIN client
		USING (clientid)
		ORDER BY bookingid
	</sql:query>

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
        <a href="index-committee.jsp" onclick="location.href='index-committee.jsp'"><i class="fas fa-home"></i><span>Laman Utama</span></a>
        <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'"><i class="fas fa-clipboard-list"></i><span>Senarai Tempahan</span></a>
        <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'"><i class="fas fa-list-alt"></i><span>Senarai Haiwan</span></a>
        <% if (isManager) { %>
        <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'"><i class="fas fa-users-cog"></i><span>Senarai AJK</span></a>
        <a href="client-list.jsp" onclick="location.href='client-list.jsp'"><i class="fas fa-users"></i><span>Senarai Klien</span></a>
        <% } %>
        <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'"></i><span>Akaun</span></a>
        <a href="LoginHandler?action=logout" onclick="checkerlogout()" id="logout" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i><span> Log Keluar</span></a>
       
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
      <a href="index-committee.jsp" onclick="location.href='index-committee.jsp'"><i class="fas fa-home"></i><span>Laman Utama</span></a>
        <a href="committee-booking-list.jsp" onclick="location.href='committee-booking-list.jsp'"><i class="fas fa-clipboard-list"></i><span>Senarai Tempahan</span></a>
        <a href="animal-details-list.jsp" onclick="location.href='animal-details-list.jsp'"><i class="fas fa-list-alt"></i><span>Senarai Haiwan</span></a>
        <% if (isManager) { %>
        <a href="committee-list.jsp" onclick="location.href='committee-list.jsp'"><i class="fas fa-users-cog"></i><span>Senarai AJK</span></a>
        <a href="client-list.jsp" onclick="location.href='client-list.jsp'"><i class="fas fa-users"></i><span>Senarai Klien</span></a>
        <% } %>
        <a href="view-committee-account.jsp" onclick="location.href='view-committee-account.jsp'"></i><span>Akaun</span></a>
        <a href="LoginHandler?action=logout" onclick="checkerlogout()" id="logout" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i><span> Log Keluar</span></a>
      
      
    </div>

	<div class="content">
        <h1>SENARAI TEMPAHAN</h1>
        <div class="content-container">

	<form method="post">
	<table class="content-table">
		<tr>
			<th>No.</th>
			<th>Tarikh Tempah</th>
			<th>Harga Tempahan (RM)</th>
			<th>Nama Klien</th>
			<th></th>
		</tr>
	
	<c:forEach var="booking" items="${bookingResult.rows}">
		<% counter++; %>
		<tr>
			<td><c:out value="<%=counter%>"/></td>
			<td><c:out value="${booking.bookingdate}"/></td>
			<td><fmt:formatNumber type = "number" maxFractionDigits = "2" value = "${booking.paymenttotal}" /></td>
			<td><c:out value="${booking.clientfullname}"/></td>
			<td>
                <button class="buttonview"  formaction="BookingHandler?action=viewBookingCommittee&bookingID=${booking.bookingid}" >Lihat</i></button>
				<button class="buttondelete" formaction="BookingHandler?action=deleteBooking&bookingID=${booking.bookingid}" onclick="checkDelete()">PADAM</button>
			</td>
		</tr>
        </c:forEach>
        </table>
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
	function checkDelete() {
		var result = confirm('Anda pasti buang tempahan ini?');
		if (result == false) {
			event.preventDefault();
		}
	}
	
	</script>
</body>
</html>