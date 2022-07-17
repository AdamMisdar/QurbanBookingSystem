<!--
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
-->

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="staffchoice-style.css">
<title>Daftar Akaun</title>
</head>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans:wght@700&family=Poppins:wght@400;500;600&display=swap');
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}

body{
  

  margin: 0;
  padding: 0;
  height: 100vh;
  overflow: hidden;
  background-color: #578572;
  
}

.center{
  position: absolute;
 
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  min-width: 500px;
  min-height: 400px;
  background: rgb(255, 255, 255);
  border-radius: 10px;
  box-shadow: 15px 15px 15px 15px rgba(0, 0, 0, 0.05);

  
}
.center h1{
  text-align: center;
  padding: 20px 0;
  border-bottom: 1px solid silver;
  
}
.center form{
  position: relative;
  box-sizing:border-box;
  text-align:center;
  margin: auto;
  padding: 30px;

}


.pass{
  margin: -5px 0 20px 5px;
  color: #a6a6a6;
  cursor: pointer;
}
.pass:hover{
  text-decoration: underline;
}

.submitV{
  width: 100%;
  height: 80px;
  border: 1px solid;
  background: #1dac70;
  border-radius: 25px;
  font-size: 18px;
  color: #e9f4fb;
  font-weight: 700;
  cursor: pointer;
  outline: none;
}
.submitV:hover{
  border-color: #59dfdf;
  background: #7ed3b0;
  transition: .5s;
}
.submitM{
  width: 100%;
  height: 80px;
  border: 1px solid;
  background: #1d4aac;
  border-radius: 25px;
  font-size: 18px;
  color: #e9f4fb;
  font-weight: 700;
  cursor: pointer;
  outline: none;
}
.submitM:hover{
  border-color: #59dfdf;
  background: #5271b6;
  transition: .5s;
}
.signup_link{
  margin: 30px 0;
  text-align: center;
  font-size: 16px;
  color: #666666;
}
.signup_link a{
  color: #2691d9;
  text-decoration: none;
}
.signup_link a:hover{
  text-decoration: underline;
}


</style>
<body>
  
    <div class="center">
        
        <h1>Daftar Akaun AJK</h1>
        <div class="containerform">
        <form method="post" onsubmit="return validate()">
          
             <input type="submit"  class="submitV" name="submitV"  formaction="committee-voluntary-registration.jsp" value="Sukarelawan">
             <input type="submit"  class="submitM" name="submitM"  formaction="committee-management-registration.jsp" value="Pengurusan">
             
          <div class="signup_link">
            Kembali ke Senarai AJK? <a href="index.jsp">Senarai AJK</a>
          </div>
    
        </form>
      </div>
      </div>



</body>
</html>