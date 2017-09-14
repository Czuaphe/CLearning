package bean;

import java.util.Date;

public class Test {
	int tid;
	String name;
	String uid;
	int chapter;
	int section;
	Date start;     // 测试开始的时刻
	Date time;      // 测试理论结束所需时间
	Date true_time; // 测试实际结束所需时间
	int score;
	
	public Test() {}
	
	public Test(int tid,String name, String uid, int chapter, int section, Date start, Date time, Date true_time, int score) {
		this.tid = tid;
		this.name = name;
		this.uid = uid;
		this.chapter = chapter;
		this.section = section;
		this.start = start;
		this.time = time;
		this.true_time = true_time;
		this.score = score;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public int getChapter() {
		return chapter;
	}

	public void setChapter(int chapter) {
		this.chapter = chapter;
	}

	public int getSection() {
		return section;
	}

	public void setSection(int section) {
		this.section = section;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Date getTrue_time() {
		return true_time;
	}

	public void setTrue_time(Date true_time) {
		this.true_time = true_time;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}
	
	
}
