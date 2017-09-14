package bean;

public class ProblemInfo {
	private Problem problem;
	private int true_num;
	private int sum_num;
	
	public ProblemInfo() {}
	
	public ProblemInfo(Problem problem, int true_num, int sum_num) {
		this.problem = problem;
		this.true_num = true_num;
		this.sum_num = sum_num;
	}

	public Problem getProblem() {
		return problem;
	}

	public void setProblem(Problem problem) {
		this.problem = problem;
	}

	public int getTrue_num() {
		return true_num;
	}

	public void setTrue_num(int true_num) {
		this.true_num = true_num;
	}

	public int getSum_num() {
		return sum_num;
	}

	public void setSum_num(int sum_num) {
		this.sum_num = sum_num;
	}
	
	
}
