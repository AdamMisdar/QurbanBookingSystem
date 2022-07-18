
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.ConnectionManager" %>
<%@ page import="java.io.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Maklumat Tempahan</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
    <style>
        body{
    margin: 0;
    padding: 0;
    font-family: "Roboto", sans-serif;
    background-color: #e7f0ee;
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
    height: calc(100% - 7%);
    transition: 0.5s;
    transition-property: left;
    
    
    padding: 6px 14px;
    
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
    margin-top: 60px;
    padding: 20px;
    margin-left: 250px;
    background: url(background.png) no-repeat;
    background-position: center;
    background-size: cover;
    height:80vh;
    transition: 0.5s;
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
    margin-top: 350px;
    border: solid 0.5px white;
  }
  #logout:hover{
    background: #c00d00;
  }
  .content h1{
      margin: 10px 20px;
      color: #009879;
      position: relative;
      display: flex;
      justify-content: center;
      margin-top: 50px;

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
  
  
.content-table {
  border-collapse: collapse;
  margin: 25px 0;
  font-size: 0.9em;
  min-width: 400px;
  border-radius: 5px 5px 0 0;
  overflow: hidden;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
  font-weight: 600;
  position: relative;
  
}
.content-table1 {
    border-collapse: collapse;
    font-size: 0.9em;
    min-width: 50%;
    min-height: auto;
    position: absolute;
    top: 50%;
    left: 50%;
    margin: auto;
    
    

  }
  .content-table2 {
    border-collapse: collapse;
    font-size: 0.9em;
    width: 50%;
    position: absolute;
    top: 50%;
    left: 50%;
    margin: auto;
   
  
  }
  form{
    margin: auto;
    align-items: center;
    justify-content: center;
    display: flex;
    background-color: #077260;
    width: 50%;
    height: 40%;
    position: relative;
    
    
    
  }
  .form1{
    margin: auto;
    align-items: center;
    justify-content: center;
    display: flex;
    background-color: #077260;
    width: 50%;
    height: 40%;
    position: relative;
  }

.content-table1 thead tr {
  background-color: #009879;
  color: #ffffff;
  text-align: left;
  font-weight: bold;
  
  
}

.content-table1 th,
.content-table1 td {
  padding: 15px 15px;
  
  
}
.content-table1 tbody tr {
  border-bottom: 1px solid #dddddd;
  
}
.content-table1 tbody tr:nth-of-type(odd) {
  background-color: #f3f3f3;
  
}

.content-table1 tbody tr:nth-of-type(even) {
  background-color: #f3f3f3;
  
}
.content-table1 tbody tr:last-of-type {
  border-bottom: 3px solid #01362c;
}
.content-table1 tbody tr:first-of-type {
  border-top: 3px solid #01362c;
}
.buttonupdate{
    background-color: rgb(0, 128, 85);
    width: 150px;
    height: 50px;
    border: transparent;
    border-radius: 10px;
    color: white;
    font-size: 13px;

}
.buttonupdate:hover{
    background-color: rgb(1, 83, 56);
    cursor: pointer;
}

.buttonback{
    display: flex;
    background-color: rgb(0, 128, 85);
    width: 150px;
    height: 50px;
    text-align: justify;
    padding: auto;
    align-items: center;
    justify-content: center;
    position: relative;
    flex-direction: row;
    color: white;
    border: transparent;
    border-radius: 10px;
    margin: auto;
    margin-top:20px;
    font-size: 13px;
}
.buttonback:hover{
    background-color: rgb(1, 83, 56);
    cursor: pointer;
}

.update{
  background-color: #06a888;
  margin: 10px;
  width: 200px;
  height: 40px;
  border-radius: 10px;
  border: transparent;
  color: white;
}
.update:hover{
  background-color: #04755f;
}


table {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    border-collapse: collapse;
    width: 70%;
    height: 100px;
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
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.header{
    background-color: #037247;
    color: rgb(8, 8, 8);
    padding: 20px;
}


h2 {
    font-weight: 600;
    text-align: center;
    color: rgb(5, 5, 5);
    padding: 10px 0px;
    font-size: 30px;
    
    
}

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

@import url('https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap');

  
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
		int client_id;
		int booking_id;
	%>
	<%
		if (session.getAttribute("clientID")==null) {
			response.sendRedirect("login.jsp");
		}
		else {
			client_id = (int)session.getAttribute("clientID");
		} 
	
		booking_id = (int)request.getAttribute("bookingID");
		
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
	%>
<%-- DATABASE -----------------------------------------------------------%>
<sql:setDataSource	var="qurbanDatabase" driver="org.postgresql.Driver"
						url="jdbc:postgresql://ec2-3-223-169-166.compute-1.amazonaws.com:5432/dfcvvjuvqh9c4k?sslmode=require"
						user="mledzxdxfykycr"
						password="9d9f02cdbcf786cb80ebf7cdbcabfa637a4c84994673ed9256a9e83e39131589" />
<%----------------------------------------------------------- DATABASE --%>

<%-- CLIENT DETAILS -----------------------------------------------------%>
	<sql:query dataSource="${qurbanDatabase}" var="clientResult">
		SELECT * FROM client WHERE clientid = <%=client_id%>
	</sql:query>
<%----------------------------------------------------- CLIENT DETAILS --%>

	<%-- BOOKING DETAILS --%>
	<sql:query dataSource="${qurbanDatabase}" var="bookingResult">
		SELECT * FROM payment JOIN booking USING (bookingid) WHERE bookingid = <%=booking_id%>
	</sql:query>

	<%-- ANIMAL ORDER DETAILS --%>
    
	<h3>TEMPAHAN</h3>
	<sql:query dataSource="${qurbanDatabase}" var="animalOrderResult">
		SELECT * FROM animalorder JOIN animaldetails USING (animaldetailsid) WHERE bookingid = <%=booking_id%>
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
    <a href="#index-client.jsp" onclick="location.href='index-client.jsp'"><i class="fas fa-home"></i><span>Laman Utama</span></a>
    <a href="location.href='BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>'" onclick="location.href='BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>'"><i class="fas fa-address-book"></i><span>Buat Tempahan</span></a>
    <a href="#client-booking-list.jsp" onclick="location.href='client-booking-list.jsp'"><i class="fas fa-list"></i><span>Senarai Tempahan</span></a>
    <a href="#view-client-account.jsp" onclick="location.href='view-client-account.jsp'"><i class="fas fa-user"></i><span>Akaun</span></a>
    <a href="#LoginHandler?action=logout"><i class="fa fa-sign-out-alt"></i><span>Log Keluar</span></a>
  </div>
</div>

<!--mobile navigation bar end-->
<!--sidebar start-->
<div class="sidebar">
  <div class="profile_info">
    <img src="logo.png" class="profile_image" alt="">
    <h4>Jessica</h4>
    <c:forEach var="client" items="${clientResult.rows}">
	NAMA: <c:out value="${client.clientfullname}" /><br>
	ID AKAUN: <%=client_id%>
	</c:forEach>
  </div>
    <a href="#index-client.jsp" onclick="location.href='index-client.jsp'"><i class="fas fa-home"></i><span>Laman Utama</span></a>
    <a href="location.href='BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>'" onclick="location.href='BookingHandler?action=createBooking&bookingDate=<%=dateToday%>&clientID=<%=client_id%>'"><i class="fas fa-address-book"></i><span>Buat Tempahan</span></a>
    <a href="#client-booking-list.jsp" onclick="location.href='client-booking-list.jsp'"><i class="fas fa-list"></i><span>Senarai Tempahan</span></a>
    <a href="#view-client-account.jsp" onclick="location.href='view-client-account.jsp'"><i class="fas fa-user"></i><span>Akaun</span></a>
  <a href="#LoginHandler?action=logout" onclick="checkerlogout()" onclick="location.href='LoginHandler?action=logout'" id="logout"><i class="fa fa-sign-out-alt"></i><span>Log Keluar</span></a>
  
  
</div>

<div class="content">
    <h1>MAKLUMAT TEMPAHAN</h1>
    <div class="content-container">
        <div class="form1">
        <table class="content-table1">
            <c:forEach var="booking" items="${bookingResult.rows}">
                <tr>
                    <th>ID Tempahan</th>
                    <td><c:out value="${booking.bookingid}" /></td>
                </tr>
                <tr>
                    <th>Tarikh Tempahan</th>
                    <td><c:out value="${booking.bookingdate}" /></td>
                </tr>
                <tr>
                    <th>Jumlah Harga (RM)</th>
                    <td><fmt:formatNumber type = "number" maxFractionDigits = "2" value = "${booking.paymenttotal}" /></td>
                </tr>
            </c:forEach>	
            </table>
        </div> 
            <form method="post">
                <table class="content-table1">
                <c:forEach var="animalOrder" items="${animalOrderResult.rows}">
                    <tr>
                        <th>Nama Tanggungan</th>
                        <th>Bahagian</th>
                        <th>Harga 1 Bahagian</th>
                        <th>Tindakan</th>
                    </tr>
                    <tr>
                        <td><c:out value="${animalOrder.dependentname}" /></td>
                        <td><c:out value="${animalOrder.animaltype}" /><input type="hidden" name="animalOrderID" value="${animalOrder.animalorderid}"></td>
                        <td>
                            <c:if test="${animalOrder.animalType == 'Lembu'}">
                                <fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalOrder.animalprice/7}" />
                            </c:if>
                            <c:if test="${animalOrder.animalType == 'Unta'}">
                                <fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalOrder.animalprice/7}" />
                            </c:if>
                            <c:if test="${animalOrder.animalType == 'Kambing'}">
                                <fmt:formatNumber type = "number" maxFractionDigits = "2" value ="${animalOrder.animalprice}" />
                            </c:if>
                        </td>
                        <td><button name="view"  class="buttonupdate" formaction="AnimalOrderHandler?action=viewAnimalOrder&bookingID=<%=booking_id%>">KEMASKINI</button></td>
                    </tr>
                </c:forEach>	
                </table>
                </form>
        
               
                <button name="back" class="buttonback" onclick="location.href='client-booking-list.jsp'">KEMBALI</button>
          
            


    </div>

</div>

    <script>
        function checkerlogout(){
                var result=confirm('Log Keluar?')
                if (result==false){
                    event.preventDefault();
                }
            }
    </script>

</body>
</html>