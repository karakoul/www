//import com.uthldap.Uthldap;
/* global ldap */

var attempt = 3; // Variable to count number of attempts.
// Below function Executes on click of login button.
function validate(){
var username = document.getElementById("username").value;
var password = document.getElementById("password").value;


Uthldap ldap = new Uthldap(username,password);
alert ("Waiting");

//if(ldap.auth()){
//   alert ("Login successfully");
//   window.location = "index2.html";
//
//}
//else{
//    attempt --;// Decrementing by one.
//    alert("You have left "+attempt+" attempt;");
//}
if ( username === "Formget" && password === "formget#123"){
alert ("Login successfully");
window.location = "success.html"; // Redirecting to other page.
return false;
}
else{
attempt --;// Decrementing by one.
alert("You have left "+attempt+" attempt;");
}

}

