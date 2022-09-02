package vo;

public class Cart {
	private int goods_no;
	private String customer_id;
	private int cart_quantity;
	private String updateDate;
	private String createDate;

	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getGoods_no() {
		return goods_no;
	}

	public void setGoods_no(int goods_no) {
		this.goods_no = goods_no;
	}

	public String getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}

	public int getCart_quantity() {
		return cart_quantity;
	}

	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return "Cart [goods_no=" + goods_no + ", customer_id=" + customer_id + ", cart_quantity=" + cart_quantity
				+ ", updateDate=" + updateDate + ", createDate=" + createDate + "]";
	}

}
