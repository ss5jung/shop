package vo;

public class OutId {
	private String outId;
	private String createDate;
	public String getOutId() {
		return outId;
	}
	public void setOutId(String outId) {
		this.outId = outId;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "OutId [outId=" + outId + ", createDate=" + createDate + "]";
	}

}
