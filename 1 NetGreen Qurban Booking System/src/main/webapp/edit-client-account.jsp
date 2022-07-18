
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>KEMASKINI AKAUN</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" charset="utf-8"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<style>
    body{
    margin: 0;
    padding: 0;
    font-family: "Roboto", sans-serif;
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
    height: 100%;
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
    background-color: #f0f3f2;
    align-items: center;
    justify-content: center;
    position: relative;
    display: flex;
    flex-direction: column;
    height: 80%;
    width: 100%;
    margin: auto;
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

#cancelbutton{
  background-color: #ec0707;
  margin: 10px;
  width: 160px;
  height: 40px;
  border-radius: 10px;
  border: transparent;
  color: white;
  float:left;
}
#cancelbutton:hover{
  background-color: #a5091e;
  cursor: pointer;
}

#confirmbutton{
  background-color: #06a888;
  margin: 10px;
  width: 160px;
  height: 40px;
  border-radius: 10px;
  border: transparent;
  color: white;
  float:right;
  
  
}
#confirmbutton:hover{
  background-color: #04755f;
  cursor: pointer;
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
<body>
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
        <a href="#index-client.jsp"><i class="fas fa-fa-home"></i><span>Laman Utama</span></a>
        <a href="#client-booking-list.jsp"><i class="fas fa-fa-list"></i><span>Senarai Tempahan</span></a>
        <a href="#create-booking.jsp"><i class="fas fa-fa-plus"></i><span>Buat Tempahan</span></a>
        <a href="#view-client-account.jsp"><i class="fas fa-th"></i><span>Akaun</span></a>
        <a href="#LoginHandler?action=logout"><i class="fa fa-sign-out-alt"></i><span>Log Keluar</span></a>
      </div>
    </div>
    <!--mobile navigation bar end-->
    <!--sidebar start-->
    <div class="sidebar">
      <div class="profile_info">
        <img src="logo.png" class="profile_image" alt="">
        <h4>Jessica</h4>
        <h4><%=client_id%></h4>
      </div>
      <a href="#index-client.jsp"><i class="fas fa-home"></i><span>Laman Utama</span></a>
      <a href="#client-booking-list.jsp"><i class="fas fa-list"></i><span>Senarai Tempahan</span></a>
      <a href="#create-booking.jsp"><i class="fas fa-plus"></i><span>Buat Tempahan</span></a>
      <a href="#view-client-account.jsp"><i class="fas fa-user"></i><span>Akaun</span></a>
      <a href="#LoginHandler?action=logout" onclick="checkerlogout()" onclick="location.href='LoginHandler?action=logout'" id="logout"><i class="fa fa-sign-out-alt"></i><span>Log Keluar</span></a>
      
    </div>


    
	<%-- LOGIN REQUIREMENT--%>
    <%!
    	int client_id;
    	Connection connection;
    %>
    <%
    	if (session.getAttribute("clientID")==null) {
    		response.sendRedirect("login.jsp");
    	}
    	else {
    		client_id = (int)session.getAttribute("clientID");
    	}

		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
	%>
	
	
	<%-- ACCOUNT DETAILS --%>
				
    ID Akaun: <%=client_id%>
    
    <h1>KEMASKINI AKAUN</h1><br><br>
   
    <div class="content">
        <h1>KEMASKINI AKAUN</h1>
        <div class="content-container">
        <div class="content-table">
        <form method="post">
            <table class="content-table">
                
                <%
                    try {
                    // Get Connection
                    connection = ConnectionManager.getConnection();
                    
                    // Prepare Statement
                    PreparedStatement showSQL = connection.prepareStatement
                    ( "SELECT * FROM client WHERE clientid = ?");
                    
                    // ? value
                    showSQL.setInt(1, client_id);
                    
                    // Execute SQL
                    ResultSet result = showSQL.executeQuery();
                    
                    while (result.next()) {
                
                    //--- Scriplet continued at the bottom
                 %>
                
                <tr>
                    <td>Nama Penuh: </td>
                    <td><input type="text" name="clientFullName" value='<%=result.getString("clientfullname")%>'></td>
                </tr>
                <tr>
                    <td>No. Telefon: </td>
                    <td><input type="text" name="clientPhoneNum" value='<%=result.getString("clientphonenum")%>'></td>
                </tr>
                <tr>
                    <td>Email: </td>
                    <td><input type="email" name="clientEmail" value='<%=result.getString("clientemail")%>'></td>
                </tr>
                <tr>
                    <td>Tarikh Lahir: </td>
                    <td><input type="date" name="clientBirthDate" value='<%=result.getString("clientbirthdate")%>'></td>
                </tr>
                <tr>
                    <td>Alamat</td>
                    <td><input type="text" name="clientAddress" value='<%=result.getString("clientaddress")%>'></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td><input type="password" name="clientPassword" value='<%=result.getString("clientpassword")%>'></td>
                </tr>
            </table><br>
                
                <%
                        } // end of while loop
                     }// try
                     
                    catch(Exception e){
                        e.printStackTrace();
                    }
                %>
            
            <button name="cancel" id="cancelbutton" onclick=""  formaction="view-client-account.jsp">BATAL</button>
            <button type="submit" id="confirmbutton" onclick="" name="submit" formaction="ClientHandler?action=updateClient&clientID=<%=client_id%>">KEMASKINI</button>
            </form>
        </div>
        </div>
    </div>
    <script>
        
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

        function checkerlogout(){
            var result=confirm('Log Keluar?')
            if (result==false){
                event.preventDefault();
            }
        }
    

        
    </script>
</body>

</html>