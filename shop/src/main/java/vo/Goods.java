package vo;

public class Goods {
	//멤버변수
	private int goodsNo;
	private String goodsName;
	private int goodsPrice;
	private String updateDate;
	private String createDate;
	private String soldOut;
	private String goodsDetail;
	public Goods() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Goods(int goodsNo, String goodsName, int goodsPrice, String updateDate, String createDate, String soldOut,
			String goodsDetail) {
		super();
		this.goodsNo = goodsNo;
		this.goodsName = goodsName;
		this.goodsPrice = goodsPrice;
		this.updateDate = updateDate;
		this.createDate = createDate;
		this.soldOut = soldOut;
		this.goodsDetail = goodsDetail;
	}
	@Override
	public String toString() {
		return "Goods [goodsNo=" + goodsNo + ", goodsName=" + goodsName + ", goodsPrice=" + goodsPrice + ", updateDate="
				+ updateDate + ", createDate=" + createDate + ", soldOut=" + soldOut + ", goodsDetail=" + goodsDetail
				+ "]";
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public int getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
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
	public String getSoldOut() {
		return soldOut;
	}
	public void setSoldOut(String soldOut) {
		this.soldOut = soldOut;
	}
	public String getGoodsDetail() {
		return goodsDetail;
	}
	public void setGoodsDetail(String goodsDetail) {
		this.goodsDetail = goodsDetail;
	}
	
}
