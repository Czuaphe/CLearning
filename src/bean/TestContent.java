package bean;

public class TestContent {
	int cid;
	int tid;  //测试
	int pid;   //题目
	int your_option;
	
	public TestContent() {}
	
	public TestContent(int cid, int tid, int pid, int your_option) {
		this.cid = cid;
		this.tid = tid;
		this.pid = pid;
		this.your_option = your_option;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getYour_option() {
		return your_option;
	}

	public void setYour_option(int your_option) {
		this.your_option = your_option;
	}
	
	
	
}
