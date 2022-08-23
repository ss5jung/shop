package vo;

public class Review {
	private int orderNo;
	private String reviewContent;
	private int star;
	private String updateDate;
	private String createDate;
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Review(int orderNo, String reviewContent, int star, String updateDate, String createDate) {
		super();
		this.orderNo = orderNo;
		this.reviewContent = reviewContent;
		this.star = star;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
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
		return "Review [orderNo=" + orderNo + ", reviewContent=" + reviewContent + ", star=" + star + ", updateDate="
				+ updateDate + ", createDate=" + createDate + "]";
	}

}
