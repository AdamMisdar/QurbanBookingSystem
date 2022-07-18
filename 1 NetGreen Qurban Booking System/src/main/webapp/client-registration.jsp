
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="registration-style.css">
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

input[type="date"]::before {
  content: attr(placeholder);
  position: absolute;
  color: #999999;
}

input[type="date"] {
  color: #ffffff;
}

input[type="date"]:focus,
input[type="date"]:valid {
  color: #666666;
}

input[type="date"]:focus::before,
input[type="date"]:valid::before {
  content: "";
}
#alert{
  color:red;
  font-weight: 500;
  padding-bottom: 10px;
}
#voluntary{
  text-align: left;
  color: #1dac70;
}
select {
  -webkit-appearance:none;
  -moz-appearance:none;
  -ms-appearance:none;
  appearance:none;
  outline:0;
  box-shadow:none;
  border:0!important;
  background: #057561;
  background-image: none;
  flex: 1;
  padding: 5px;
  color:#fff;
  cursor:pointer;
  font-size: 1em;
  font-family: 'Open Sans', sans-serif;
}
select::-ms-expand {
  display: none;
}
.select {
  position: relative;
  display: flex;
  width: 20em;
  height: 2.5em;
  line-height: 3;
  background: 057561;
  overflow: hidden;
  border-radius: .25em;
  margin-top: 5px;
}
.select::after {
  content: '\25BC';
  position: absolute;
  top: 0;
  right: 0;
  padding: 0 1em;
  background: #035e43;
  cursor:pointer;
  pointer-events:none;
  transition:.25s all ease;
}
.select:hover::after {
  color: #b0f0e4;
}

</style>
<body>
    <div class="center">
	<h1>Daftar Akaun</h1>
	<p>Akaun Klien</p>

    <div class="center">
        
        <h1>Daftar Akaun</h1>
        <div class="containerform">
        <form method="post" onsubmit="return validate()">
          <div class="txt_field">
            <input type="text" name="clientFullName" required>
            <span></span>
            <label>Nama Penuh:</label>
          </div>
          <div class="txt_field">
            <input type="email" name="clientEmail" required>
            <span></span>
            <label>Email:</label>
          </div>
          <div class="txt_field">
            <input type="text" name="clientPhoneNum" required>
            <span></span>
            <label>Nombor Telefon:</label>
          </div>
          <div class="txt_field">
            <input type="text" name="clientAddress" required>
            <span></span>
            <label>Alamat:</label>
          </div>
          <div class="txt_field">
            <input type="date" name="clientBirthDate" required>
            <span></span>
            <label>Tarikh Lahir:</label>
          </div>
          <div class="txt_field">
            <input type="password" name="clientPassword" id="clientPassword" required>
            <span></span>
            <label>Kata Laluan:</label>
          </div>
          <div class="txt_field">
            <input type="password" name="clientReenterPassword" id="clientReenterPassword" onkeyup="check(this)" required>
            <span></span>
            <label>Masukkan semula kata laluan:</label>
            
          </div>
          <p><error id="alert"></error></p>
          

          <!--
          <input type="submit" value="Log Masuk">
             -->
             <input type="submit" id="create" class="button" name="submit" formaction="ClientHandler?action=createClient" onclick="wrong_pass_alert()" value="Daftar Akaun">
             
          <div class="signup_link">
            Sudah ada akaun? <a href="login.jsp">Log Masuk</a>
          </div>
    
        </form>
      </div>
      </div>

</div>
<script type="text/javascript">
        var password = document.getElementById('clientPassword');
        var flag= 1; 
        function check(elem){
            if(elem.value.length > 0){
                if(elem.value != password.value){
                    document.getElementById('alert').innerText = "Kata laluan tidak sama";
                    flag=0;
                    document.getElementById('create').disabled = true;
                document.getElementById('create').style.opacity = (0.4);
                }
                else{
                    document.getElementById('alert').innerText="";
                    flag=1;
                    document.getElementById('create').disabled = false;
                    document.getElementById('create').style.opacity = (1);
                }
            }else{
                document.getElementById('alert').innerText = "Masukkan kembali kata laluan anda";
                flag=0;
                document.getElementById('create').disabled = true;
                document.getElementById('create').style.opacity = (0.4);
            }
        }
        function validate(){
            if(flag==1){
                return true;
            }
            else{
                return false;
            }
        }

        function wrong_pass_alert() {
            if (document.getElementById('clientPassword').value != "" &&
                document.getElementById('clientReenterPassword').value != "") {
                alert("Your response is submitted");
            } else {
                alert("Please fill all the fields");
            }
        }



</script>
</body>
</html>