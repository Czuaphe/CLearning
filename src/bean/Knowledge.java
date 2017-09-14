package bean;

public class Knowledge {
	int kid;
	int chapter;
	int section;
	String title;
	String details;
	
	public Knowledge() {}
	
	public Knowledge(int kid, int chapter, int section, String title, String details) {
		this.kid = kid;
		this.chapter = chapter;
		this.section = section;
		this.title = title;
		this.details = details;
	}

	public int getKid() {
		return kid;
	}

	public void setKid(int kid) {
		this.kid = kid;
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

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}
	
	
	
}
