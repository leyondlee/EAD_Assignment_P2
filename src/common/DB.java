package common;

import java.sql.*;
import model.*;

public class DB {
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String connURL = ""; //Put connection URL here
			conn = DriverManager.getConnection(connURL);
		} catch (Exception e) {
			
		}
		
		return conn;
	}
	
	public static boolean checkAdmin(String username) {
		boolean isAdmin = false;
		
		try {
			Connection conn = DB.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM administrator WHERE username = ?");
			pstmt.setString(1, username);
			ResultSet rs = pstmt.executeQuery();
			
        	if (rs.next()) {
        		isAdmin = true;
        	}
    	
    		conn.close();
		} catch (Exception e) {
			
		}
		
		return isAdmin;
	}
	
	public static boolean emailExists(String s) {
		boolean exists = false;
		
		try {
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM member WHERE email = ?");
			pstmt.setString(1, s);
			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				exists = true;
			}
			
			conn.close();
		} catch (Exception e) {
			
		}
		
		return exists;
	}
	
	public static boolean usernameExists(String s) {
		boolean exists = false;
		
		try {
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE username = ?");
			pstmt.setString(1, s);
			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				exists = true;
			}
			
			conn.close();
		} catch (Exception e) {
			
		}
		
		return exists;
	}
	
	public static Game getGame(String id) {
		Game game = null;
		try {
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameid = ?");
			pstmt.setString(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				game = new Game(rs.getInt("gameid"), rs.getString("title"), rs.getDate("releaseDate"), rs.getString("description"), rs.getDouble("price"), rs.getString("imageLocation"), rs.getInt("companyid"), rs.getInt("preowned"), rs.getInt("quantity"));
			}
			
			conn.close();
		} catch (Exception e) {
			
		}
		
		return game;
	}
	
	public static int getGameQuantity(String gameid) {
		int quantity = -1;
		try {
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameid = ?");
			pstmt.setString(1, gameid);
			
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				quantity = rs.getInt("quantity");
			}
			
			conn.close();
		} catch (Exception e) {
			
		}
		
		return quantity;
	}
}
