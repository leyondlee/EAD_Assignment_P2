package model;

import java.util.*;

public class Game {
	private int gameid;
	private String title;
	private Date releaseDate;
	private String description;
	private double price;
	private String imageLocation;
	private int companyid;
	private int preowned;
	private int quantity;
	
	public Game() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Game(int gameid, String title, Date releaseDate, String description, double price, String imageLocation, int companyid, int preowned, int quantity) {
		super();
		this.gameid = gameid;
		this.title = title;
		this.releaseDate = releaseDate;
		this.description = description;
		this.price = price;
		this.imageLocation = imageLocation;
		this.companyid = companyid;
		this.preowned = preowned;
		this.quantity = quantity;
	}

	public int getGameid() {
		return gameid;
	}

	public void setGameid(int gameid) {
		this.gameid = gameid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImageLocation() {
		return imageLocation;
	}

	public void setImageLocation(String imageLocation) {
		this.imageLocation = imageLocation;
	}

	public int getCompanyid() {
		return companyid;
	}

	public void setCompanyid(int companyid) {
		this.companyid = companyid;
	}

	public int getPreowned() {
		return preowned;
	}

	public void setPreowned(int preowned) {
		this.preowned = preowned;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
