package bean;

public class Problem {
	int pid;
	String name;
	int score;
	int chapter;
	int section;
	String title;
	String option1;
	String option2;
	String option3;
	String option4;
	int true_option;
	
	public Problem() {}
	
	public Problem(int pid, String name, int score, int chapter, int section, String title, String option1, String option2, String option3, String option4, int true_option) {
		
		this.pid = pid;
		this.name = name;
		this.score = score;
		this.chapter = chapter;
		this.section = section;
		this.title = title;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.option4 = option4;
		this.true_option = true_option;
	}


	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOption1() {
		return option1;
	}

	public void setOption1(String option1) {
		this.option1 = option1;
	}

	public String getOption2() {
		return option2;
	}

	public void setOption2(String option2) {
		this.option2 = option2;
	}

	public String getOption3() {
		return option3;
	}

	public void setOption3(String option3) {
		this.option3 = option3;
	}

	public String getOption4() {
		return option4;
	}

	public void setOption4(String option4) {
		this.option4 = option4;
	}

	public int getTrue_option() {
		return true_option;
	}

	public void setTrue_option(int true_option) {
		this.true_option = true_option;
	}
	
	
	
}
