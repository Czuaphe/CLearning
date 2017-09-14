package bean;

public class User {
	String uid;
	String name;
	String pswd;
	int kind;
	String class_;
	
	public User() {}

	public User(String uid, String name, String pswd, int kind) {
		this.uid = uid;
		this.name = name;
		this.pswd = pswd;
		this.kind = kind;
	}
	
	public User(String uid, String name, String pswd, int kind, String class_) {
		this(uid, name, pswd, kind);
		this.class_ = class_;
	}

	
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPswd() {
		return pswd;
	}

	public void setPswd(String pswd) {
		this.pswd = pswd;
	}

	public int getKind() {
		return kind;
	}

	public void setKind(int kind) {
		this.kind = kind;
	}

	public String getClass_() {
		return class_;
	}

	public void setClass_(String class_) {
		this.class_ = class_;
	}
	
}
