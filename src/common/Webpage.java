package common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpSession;
import model.*;
import java.nio.file.*;

public class Webpage {
	public static String getPriceString(double input) {
		DecimalFormat df = new DecimalFormat("0.00");
		String s = df.format(input);
		
		return s;
	}
	
	public static String imageLocation(String s) {
		if (s == null) {
			s = "";
		}
		
		if (s.equals("")) {
			s = "images/defaultimage.jpg";
		}
		
		return s;
	}
	
	public static boolean deleteImage(String filepath) {
		boolean deleted = false;
		Path path = FileSystems.getDefault().getPath(filepath);
		try {
			deleted = Files.deleteIfExists(path);
		} catch (Exception e) {
			
		}
		
		return deleted;
	}
	
	public static boolean checkAdmin(HttpSession session) {
		boolean isAdmin = false;
		
		User user = (User) session.getAttribute("user");
		if (user != null && user.isAdmin()) {
			isAdmin = true;
		}
		
		return isAdmin;
	}
	
	public static boolean checkLoggedin(HttpSession session) {
		boolean loggedin = false;
		
		User user = (User) session.getAttribute("user");
		if (user != null) {
			loggedin = true;
		}
		
		return loggedin;
	}
	
	public static String htmlspecialchars(String s){
		s = s.replace("&", "&amp;");
		s = s.replace("\"", "&quot;");
		s = s.replace("'", "&#039;");
		s = s.replace("<", "&lt;");
		s = s.replace(">", "&gt;");
		
		s = s.replace("\n","<br />");
		
		return s;
	}
	
	public static boolean checkUsername(String username) {
		boolean valid = false;
		if (username != null && username.length() > 0 && !username.contains(" ")) {
			valid = true;
		}
		
		return valid;
	}
	
	public static boolean checkPassword(String password, String confirmpassword) {
		boolean valid = false;
		if (password != null && confirmpassword != null) {
			if (password.length() >= 8 && password.length() <= 16) {
				if (password.equals(confirmpassword)) {
					valid = true;
				}
			}
		}
		
		return valid;
	}
	
	public static boolean checkEmail(String email) {
		boolean valid = false;
		if (email != null && email.contains("@") && email.contains(".")) {
			valid = true;
		}
		
		return valid;
	}
	
	public static boolean checkContact(String contact) {
		boolean valid = false;
		if (contact != null && contact.length() == 8) {
			valid = true;
			for (int i = 0; i < contact.length(); i++) {
				char c = contact.charAt(i);
				if (!Character.isDigit(c)) {
					valid = false;
					break;
				}
			}
		}
		
		return valid;
	}
	
	public static boolean checkAddress(String address) {
		boolean valid = false;
		if (address != null) {
			if (address.length() > 0) {
				valid = true;
			}
		}
		
		return valid;
	}
	
	public static String stringCheck(String s) {
		if (s == null) {
			s = "";
		}
		
		return s;
	}
	
	public static String dateFormat(Date date, String dateFormat) {
		return (new SimpleDateFormat(dateFormat)).format(date);
	}
	
	public static int getInt(String s) {
		int i;
		try {
			i = Integer.parseInt(s);
		} catch (Exception e) {
			i = 0;
		}
		
		return i;
	}
}
