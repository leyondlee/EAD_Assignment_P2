function isEmptyString(string) {
	var isEmpty = false;
	if (string == null || string == "") {
		isEmpty = true;
	}
	
	return isEmpty;
}

function hasWhitespace(string) {
	var has = false;
	if (string.indexOf(" ") != -1) {
		has = true;
	}
	
	return has;
}

function checkUsername(username) {
var check = true;
	
	var string = username.value;
	if (hasWhitespace(string)) {
		check = false;
	}
	
	return check;
}

function checkPassword(password) {
	var check = -1;
	
	var string = password.value;
	var length = string.length;
	if (length >= 8 && length <= 16) {
		var hasChars = false;
		var hasNumber = false;
		for (i = 0; i < string.length; i++) {
			var c = string[i];
			
			if (isNaN(c)) {
				hasChars = true;
			}
			
			if (isFinite(c)) {
				hasNumber = true;
			}
		}
		
		if (hasChars && hasNumber) {
			check = 0;
		} else {
			check = 1;
		}
	}
	
	return check;
}

function checkEmail(email) {
	var check = true;
	
	var string = email.value;
	if (string.indexOf("@") == -1 || string.indexOf(".") == -1 || hasWhitespace(string)) {
		check = false;
	}
	
	return check;
}

function checkContact(contact) {
	var check = 0;
	
	var string = contact.value;
	if (string.length == 8) {
		for (i = 0; i < string.length; i++) {
			var c = string[i];
			if (isNaN(c)) {
				check = 1;
				break;
			}
		}
	} else {
		check = -1;
	}
	
	return check;
}

function inputError(e) {
	e.classList.add("has-error");
	e.getElementsByTagName("p")[0].style.display = "block";
}

function reset(form) {
	var array;
	
	array = form.getElementsByClassName("form-group");
	for (i = 0; i < array.length; i++) {
		array[i].classList.remove("has-error");
	}
	
	array = form.getElementsByTagName("p");
	for (i = 0; i < array.length; i++) {
		array[i].style.display = "none";
	}
}

function registrationCheck() {
	var pass = true;
	
	var array = ["username","password","confirmpassword","email","contact","address"];
	
	var form = document.forms["registrationForm"];
	reset(form);
	
	for (i = 0; i < array.length; i++) {
		var s = array[i];
		var e = form[s];
		var v = e.value;
		var div = e.parentElement;
		
		if (isEmptyString(v)) {
			pass = false;
			
			inputError(div);
		}
	}
	
	var checkusername = false, checkpass = false, checkemail = false, checkcontact = false;
	if (pass) {
		var username = form["username"];
		var password = form["password"];
		var confirmpassword = form["confirmpassword"];
		var email = form["email"];
		var contact = form["contact"];
		
		var div;
		var check;
		
		if (!checkUsername(username)) {
			div = username.parentElement;
			div.getElementsByTagName("p")[1].style.display = "block";
		} else {
			checkusername = true;
		}
		
		check = checkPassword(password);
		div = password.parentElement;
		switch (check) {
			case -1:
				div.getElementsByTagName("p")[1].style.display = "block";
				break;
			
			case 0:
				if (password.value != confirmpassword.value) {
					div = confirmpassword.parentElement;
					div.getElementsByTagName("p")[1].style.display = "block";
				} else {
					checkpass = true;
				}
				
				break;
			
			case 1:
				div.getElementsByTagName("p")[2].style.display = "block";
				break;
		}
		
		if (!checkEmail(email)) {
			div = email.parentElement;
			div.getElementsByTagName("p")[1].style.display = "block";
		} else {
			checkemail = true;
		}
		
		check = checkContact(contact);
		div = contact.parentElement;
		switch (check) {
			case -1:
				div.getElementsByTagName("p")[1].style.display = "block";
				break;
			
			case 0:
				checkcontact = true;
				break;
			
			case 1:
				div.getElementsByTagName("p")[2].style.display = "block";
				break;
		}
	}
	
	var r = checkusername && checkpass && checkemail && checkcontact;
	if (!r) {
		window.scrollTo(0,0);
	}
	
	return r;
}

function updateCheck() {
	var pass = true;
	
	var array = ["username","email","contact","address"];
	
	var form = document.forms["updateForm"];
	reset(form);
	
	for (i = 0; i < array.length; i++) {
		var s = array[i];
		var e = form[s];
		var v = e.value;
		var div = e.parentElement.parentElement;
		
		if (isEmptyString(v)) {
			pass = false;
			
			inputError(div);
		}
	}
	
	var checkusername = false, checkpass = false, checkemail = false, checkcontact = false;
	if (pass) {
		var username = form["username"];
		var email = form["email"];
		var contact = form["contact"];
		var currentpassword = form["currentpassword"];
		var newpassword = form["newpassword"];
		var confirmpassword = form["confirmpassword"];
		
		if (!checkUsername(username)) {
			div = username.parentElement.parentElement;
			div.getElementsByTagName("p")[1].style.display = "block";
		} else {
			checkusername = true;
		}
		
		if (!checkEmail(email)) {
			div = email.parentElement.parentElement;
			div.getElementsByTagName("p")[1].style.display = "block";
		} else {
			checkemail = true;
		}
		
		check = checkContact(contact);
		div = contact.parentElement.parentElement;
		switch (check) {
			case -1:
				div.getElementsByTagName("p")[1].style.display = "block";
				break;
			
			case 0:
				checkcontact = true;
				break;
			
			case 1:
				div.getElementsByTagName("p")[2].style.display = "block";
				break;
		}
		
		div = currentpassword.parentElement.parentElement;
		var currentpasswordvalue = currentpassword.value;
		var newpasswordvalue = newpassword.value;
		var confirmpasswordvalue = confirmpassword.value;
		if (!isEmptyString(currentpasswordvalue)) {
			if (!isEmptyString(newpasswordvalue) && !isEmptyString(confirmpasswordvalue)) {
				if (newpasswordvalue != confirmpasswordvalue) {
					div.getElementsByTagName("p")[4].style.display = "block";
				} else {
					check = checkPassword(newpassword);
					if (check == 0) {
						checkpass = true;
					} else {
						div.getElementsByTagName("p")[2].style.display = "block";
					}
				}
			} else {
				if (isEmptyString(newpasswordvalue)) {
					div.getElementsByTagName("p")[1].style.display = "block";
				}
			
				if (isEmptyString(confirmpasswordvalue)) {
					div.getElementsByTagName("p")[3].style.display = "block";
				}
			}
		} else {
			if (!isEmptyString(newpasswordvalue) || !isEmptyString(confirmpasswordvalue)) {
				div.getElementsByTagName("p")[0].style.display = "block";
			} else {
				checkpass = true;
			}
		}
	}
	
	var r = checkusername && checkpass && checkemail && checkcontact;
	if (!r) {
		window.scrollTo(0,0);
	}
	
	return r;
}

function updateCheckAdmin() {
	var check;
	var checkpass = false;
	
	var form = document.forms["updateForm"];
	reset(form);
	
	var currentpassword = form["currentpassword"];
	var newpassword = form["newpassword"];
	var confirmpassword = form["confirmpassword"];
	
	var div = currentpassword.parentElement.parentElement;
	var currentpasswordvalue = currentpassword.value;
	var newpasswordvalue = newpassword.value;
	var confirmpasswordvalue = confirmpassword.value;
	if (!isEmptyString(currentpasswordvalue)) {
		if (!isEmptyString(newpasswordvalue) && !isEmptyString(confirmpasswordvalue)) {
			if (newpasswordvalue != confirmpasswordvalue) {
				div.getElementsByTagName("p")[4].style.display = "block";
			} else {
				check = checkPassword(newpassword);
				if (check == 0) {
					checkpass = true;
				} else {
					div.getElementsByTagName("p")[2].style.display = "block";
				}
			}
		} else {
			if (isEmptyString(newpasswordvalue)) {
				div.getElementsByTagName("p")[1].style.display = "block";
			}
		
			if (isEmptyString(confirmpasswordvalue)) {
				div.getElementsByTagName("p")[3].style.display = "block";
			}
		}
	} else {
		if (!isEmptyString(newpasswordvalue) || !isEmptyString(confirmpasswordvalue)) {
			div.getElementsByTagName("p")[0].style.display = "block";
		} else {
			checkpass = true;
		}
	}
	
	var r = checkpass;
	if (!r) {
		window.scrollTo(0,0);
	}
	
	return r;
}