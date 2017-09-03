package model;

import java.util.*;

public class Transaction {
	private ArrayList<Item> items = new ArrayList<Item>();
	private int id;
	private Date date;
	private String time;

	public Transaction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Transaction(ArrayList<Item> items, int id, Date date, String time) {
		super();
		this.items = items;
		this.id = id;
		this.date = date;
		this.time = time;
	}

	public ArrayList<Item> getItems() {
		return items;
	}

	public void setItems(ArrayList<Item> items) {
		this.items = items;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	public void addToList(Game game, int quantity) {
		Item item = new Item(game,quantity);
		items.add(item);
	}
}
