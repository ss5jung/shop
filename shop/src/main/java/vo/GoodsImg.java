package vo;

public class GoodsImg {
	//멤버변수
	private int goodsNo;
	private String filename;
	private String originFilename;
	private String contentType;
	private String createDate;
	//멤버함수
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOriginFilename() {
		return originFilename;
	}
	public void setOriginFilename(String originFilename) {
		this.originFilename = originFilename;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	
	@Override
	public String toString() {
		return "GoodsImg [goodsNo=" + goodsNo + ", filename=" + filename + ", originFilename=" + originFilename
				+ ", contentType=" + contentType + ", createDate=" + createDate + "]";
	}

}
