<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="qurban.connection.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laman Utama Netgreen Qurban</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/fontawesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans|Roboto" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
    	<%!
		int committee_id;
		String committeeType;
		Connection connection;
		String manSQL, volSQL;
		boolean checkManagement = false, checkVoluntary = false, isManager = false;
		ResultSet resultManagement, resultVoluntary;
		%>
		
<%-- LOGIN REQUIREMENT  -------------------------------------------------%>
		
			<%
	//user has not logged in
	if(session.getAttribute("committeeID") == null) {
		
		//redirect user to login page
		response.sendRedirect("login.jsp");
	}
	else {
		
		// Get client
		committee_id = (int)session.getAttribute("committeeID");
	}
	%>
<%------------------------------------------------- LOGIN REQUIREMENT  --%>
<%-- CHECK MANAGEMENT/VOLUNTARY ---------------------------------------------%>
	<%
		// Get connection
		connection = ConnectionManager.getConnection();
		
		// Go through database
		manSQL = "SELECT * FROM management JOIN committee USING (committeeid) WHERE committeeid = ?";
		volSQL = "SELECT * FROM voluntary JOIN committee USING (committeeid) WHERE committeeid = ?";

		PreparedStatement checkManSQL = connection.prepareStatement(manSQL);
		PreparedStatement checkVolSQL = connection.prepareStatement(volSQL);
		
		// Set ? values
		checkManSQL.setInt(1, committee_id);
		checkVolSQL.setInt(1, committee_id);
		
		// Execute
		resultManagement = checkManSQL.executeQuery();
		resultVoluntary = checkVolSQL.executeQuery();
		
		// Check
		if (resultManagement.next()) {
			checkManagement = true;
			System.out.println("Yes: Management");
		}
		else {
			checkManagement = false;
			System.out.println("No: Not Management");
		}
		
		if (resultVoluntary.next()) {
			checkVoluntary = true;
			System.out.println("Yes: Voluntary");
		}
		else {
			checkVoluntary = false;
			System.out.println("No: Not Voluntary");
		}
		
		if (checkManagement) {
			String position = resultManagement.getString("managementposition");
			System.out.println("Position: " + position);
			
			if (position.equalsIgnoreCase("Pengerusi") || position.equalsIgnoreCase("Naib Pengerusi")){
				isManager = true;
				System.out.println(isManager);
			}
			
		}
		
		if (checkVoluntary) {
			
			while(resultManagement.next()){
				committeeType="Voluntary";
			}
		}
		
		
		if(isManager){
			response.sendRedirect("indexcommitteemanager.jsp");
		}
	%>

<%-- CHECK MANAGEMENT/VOLUNTARY ---------------------------------------------%>
		      <%-- DATABASE --%>
	<sql:setDataSource	var="qurbanDatabase" driver="oracle.jdbc.driver.OracleDriver"
						url="jdbc:oracle:thin:@localhost:1521:xe"
						user="netgreen"
						password="system" />
						
	<%
		if(checkManagement){
	
	%>
	<%-- SQL QUERY - DISPLAY MANAGEMENT --%>
	<sql:query dataSource="${qurbanDatabase}" var="resultMan">
	   SELECT * FROM committee JOIN management USING (committeeid) WHERE committeeid = <%=committee_id%>
	</sql:query>
	<%
		} else if (checkVoluntary) {
	%>	
	<%-- SQL QUERY - DISPLAY VOLUNTARY --%>
	<sql:query dataSource="${qurbanDatabase}" var="resultVol">
	   SELECT * FROM committee JOIN voluntary USING (committeeid) WHERE committeeid = <%=committee_id%>
	</sql:query>
	
	<% 
		}
	
	%>	
			
		
	
		
        
        <nav class="navbar navbar-expand-lg navbar-light text-capitalize">
            <div class="container">
                
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#show-menu" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                   <div style="color: white;">
                   
                   <% if(checkManagement) { %>
                   <c:forEach var="man" items="${resultMan.rows}">
                   		<span>PENGURUSAN<br></span>
                		<span><c:out value="${man.managementposition}"/><br></span>
                		<span><c:out value="${man.committeefullname}"/></span>
                   </c:forEach>
                   <% } else if (checkVoluntary) { %>
                   <c:forEach var="committee" items="${resultVol.rows}">
                   		<span>SUKARELAWAN<br></span>
                		<span><c:out value="${committee.voluntaryrole}"/><br></span>
                		<span><c:out value="${committee.committeefullname}"/></span>
                   </c:forEach>
                   <% } %>
                	
                </div>

                <div class="collapse navbar-collapse" id="show-menu">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="#home">Laman Utama <span class="sr-only">(current)</span></a>
                        </li>
                       <%if (checkManagement) {%>
                        <li class="nav-item">
                            <a class="nav-link" href="#service">Senarai Tempahan</a>
                        </li>
                       	
                        <li class="nav-item">
                            <a class="nav-link" href="#service">Senarai Maklumat Haiwan</a>
                        </li>
                        <%}%>
                       
                        <li class="nav-item">
                            <a class="nav-link" href="#"><i class="far fa-user"></i></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="" onclick="location.href='LoginHandler?action=logout'"><i class="fas fa-sign-out-alt"></i></a>
                        </li>
                        
                   
                    </ul>
                </div>
            </div>
        </nav>
        
        <header id="home">
            <div class="overlay">
                <div class="container">
                    <div>
                        <h1><span>Qurban</span><br></h1>
                        <h2>Sudahkah anda berkorban?</h2>
                        <p>Laksanakanlah ibadah Qurban dengan ikhlas untuk meringankan komuniti yang memerlukan</p>
                        <button><a href="#" class="text-uppercase">tempah sekarang</a></button>
                    </div>
                </div>
            </div>
        </header>
        
        <div class="about-us" id="about">
            <div class="small-container">
                <h2 class="text-center">Servis Qurban <span></span></h2>
                <p class="text-center">Kenapa menggunakan servis kami?</p>
                <div>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-6 col-12 text-center">
                                <div class="item">
                                    <img src="imgs/staff.jpg">
                                    <h5 class="text-uppercase">ajk </h5>
                                </div>
                                <div class="item">
                                    <img src="imgs/clock.jpg">
                                    <h5 class="text-uppercase">Mudah & cepat</h5>
                                </div>
                                <div class="item">
                                    <img src="imgs/price.jpg">
                                    <div>
                                        <h5 class="text-uppercase">Harga</h5>
                                        <p>Harga haiwan mengikut pasaran</p>
                                    </div>
                                </div>
                                <div class="item">
                                    <img src="imgs/cow.jpg">
                                    <h5 class="text-uppercase">Baka</h5>
                                </div>
                            </div>
                            <div class="col-lg-6 col-12 text-right">
                                <h4 class="text-uppercase">Servis <span>NETGREEN</span></h4>
                                <p>Netgreen cuba memberi servis yang terbaik untuk semua pihak untuk menjalankan ibadah Qurban dengan lancar dan selamat dan servis yang diberikan adalah
                                    ajk yang berlesen, proses cepat dan mudah, pemilihan baka yang baik dan harga yang berpatutan
                                </p>
                                <button class="text-center"><a href="#" class="text-capitalize">tempah sekarang</a></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="first"></div>
                <div class="second"></div>
            </div>
        </div>
         
  
        <footer>
            <div class="container">
                <ul>
                    <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                    <li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
                </ul>
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="item">
                            <h4 class="text-uppercase">Hubungi Kami</h4>
                            <p class="address">
                                UiTM Cawangan Melaka, <br>
                                Kampung Seri Mendapat,<br>
                                77300 Merlimau, Melaka<br>
                                +6010-285-9000
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="item">
                            <h4 class="text-uppercase">Link Tambahan</h4>
                            <ul>
                                <li><a href="#">Laman Utama</a></li>
                                <li><a href="#">Buat Tempahan</a></li>
                                <li><a href="#">Senarai Tempahan</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="item date">
                            <h4 class="text-uppercase">Tarikh Qurban</h4>
                            <p><a href="#">21/08/2018</a></p>
                            <p><a href="#">11/08/2019</a></p>
                            <p><a href="#">30/07/2020</a></p>
                            <p><a href="#">19/07/2021</a></p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="item">
                            <h4 class="text-uppercase">Pemberitahuan</h4>
                           
                        </div>
                    </div>
                </div>
            </div>
            <div class="copyright text-center">
                
            </div>
        </footer>
        
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
            $(function () {
                
                'use strict';
                
                var winH = $(window).height();
                
                $('header').height(winH);  
                
                $('header .container > div').css('top', (winH / 2) - ( $('header .container > div').height() / 2));
                
                $('.navbar ul li a.search').on('click', function (e) {
                    e.preventDefault();
                });
                $('.navbar a.search').on('click', function () {
                    $('.navbar form').fadeToggle();
                });
                
                $('.navbar ul.navbar-nav li a').on('click', function (e) {
                    
                    var getAttr = $(this).attr('href');
                    
                    e.preventDefault();
                    $('html').animate({scrollTop: $(getAttr).offset().top}, 1000);
                });
            })
        </script>
    </body>
</html>