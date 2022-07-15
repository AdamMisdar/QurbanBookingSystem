<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Log In | Qurban</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
  
}
.container{
  background-image: url('loginOrderImage.jpg');
  background-size:cover ;
  background-repeat:no-repeat;
  margin: auto;
  width: 100%;
  height: 100%;
  max-width: 100%;
  min-width: 100%;
  max-height: 100%;
  position: absolute;
  z-index: -1;

}
.center{
  position: absolute;
 
  top: 50%;
  left: 80%;
  transform: translate(-50%, -50%);
  min-width: 500px;
  min-height: 400px;
  background: rgb(255, 255, 255);
  border-radius: 10px;
  box-shadow: 10px 10px 15px rgba(0,0,0,0.05);


  
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
.image{

  background-color: #ffffff;
  height: 80vh;
  width: 100vh;
  z-index: 20;
  position: relative;
  display: block;
  margin: auto auto;
  padding: auto;
  top: 50%;
  left: 20%;
  transform: translate(-70%, -50%);
  backdrop-filter: blur(4px) saturate(180%);
    -webkit-backdrop-filter: blur(4px) saturate(180%);
    background-color: rgba(238, 240, 246, 0.65);
    border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, 0.125);
 
  
}
.imagecontainer{
  height: 60vh;
  width: 70vh;
  z-index: 21;
  position: relative;
  display: flex;
  
  margin: auto auto;
  padding: 10px;
  top: 15%;
  left: 0%;
  border-radius: 12px;
  background-image: url('login.svg');
  background-repeat: no-repeat;
  background-size: 80%;
  background-position: 50%;
  

}



form .txt_field{
  position: relative;
  border-bottom: 2px solid #adadad;
  margin: 30px 0;
  
}
.txt_field input{
  width: 100%;
  padding: 0 5px;
  height: 40px;
  font-size: 16px;
  border: none;
  background: none;
  outline: none;
}
.txt_field label{
  position: absolute;
  top: 50%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  font-size: 16px;
  pointer-events: none;
  transition: .5s;
}
.txt_field span::before{
  content: '';
  position: absolute;
  top: 40px;
  left: 0;
  width: 0%;
  height: 2px;
  background: #26d98e;
  transition: .5s;
}
.txt_field input:focus ~ label,
.txt_field input:valid ~ label{
  top: -5px;
  color: #26d98e;
}
.txt_field input:focus ~ span::before,
.txt_field input:valid ~ span::before{
  width: 100%;
}
.pass{
  margin: -5px 0 20px 5px;
  color: #a6a6a6;
  cursor: pointer;
}
.pass:hover{
  text-decoration: underline;
}
input[type="submit"]{
  width: 100%;
  height: 50px;
  border: 1px solid;
  background: #1dac70;
  border-radius: 25px;
  font-size: 18px;
  color: #e9f4fb;
  font-weight: 700;
  cursor: pointer;
  outline: none;
}
input[type="submit"]:hover{
  border-color: #2691d9;
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
</head>
 <body>
 
    <div class="container">
    </div>
    
    <div class="center">
     	 <h1>Log Masuk</h1>
      	<div class="containerform">
      
      		<form method="post" action="">
      
       	 	<div class="txt_field">
          		 <input type="text" name="email" required>
         		 <span></span>
         		 <label>E-mel</label>
       	 	</div>
        
        	<div class="txt_field">
        		 <input type="password" name="password" required>
         		 <span></span>
         		 <label>Kata Laluan</label>
       		 </div>
        
       		 <div class="pass">Terlupa Kata Laluan?</div>
       			 	<input type="submit" value="Log Masuk" formaction="LoginHandler?action=login" onclick="">
        	<div class="signup_link">
         		 Tiada akaun? <a href="client-registration.jsp">Cipta Akaun Baru</a>
        	</div>
        
      		</form>
      
    	</div>
    </div>
    <div class="image">
      	<div class="imagecontainer">

      	</div> 
    </div> 


  </body>
</html>