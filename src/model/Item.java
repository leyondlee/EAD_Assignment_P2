package model;

public class Item {
	private Game game;
	private int quantity;
	
	public Item() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Item(Game game, int quantity) {
		super();
		this.game = game;
		this.quantity = quantity;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
