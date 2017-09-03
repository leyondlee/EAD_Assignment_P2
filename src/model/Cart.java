package model;

import java.util.*;

public class Cart {
	private ArrayList<Item> items = new ArrayList<Item>();

	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Cart(ArrayList<Item> items) {
		super();
		this.items = items;
	}

	public ArrayList<Item> getItems() {
		return items;
	}

	public void setItems(ArrayList<Item> items) {
		this.items = items;
	}
	
	public void addToCart(Game game, int quantity) {
		Item item = new Item(game,quantity);
		items.add(item);
	}
	
	public void removeFromCart(int index) {
		items.remove(index);
	}
}
