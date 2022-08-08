package vo;

public class Goods {
	//멤버변수
	private int goodsNo;
	private String goodsName;
	private int goodsPrice;
	private String updateDate;
	private String createDate;
	private String soldOut;
	//멤버메소드
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
	@Override
	public String toString() {
		return "Goods [goodsNo=" + goodsNo + ", goodsName=" + goodsName + ", goodsPrice=" + goodsPrice + ", updateDate="
				+ updateDate + ", createDate=" + createDate + ", soldOut=" + soldOut + "]";
	}
	
}
