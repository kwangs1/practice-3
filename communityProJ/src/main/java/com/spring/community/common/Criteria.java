package com.spring.community.common;

//게시글 조회 쿼리에 전달될 파라미터를 담게 될 클래스
public class Criteria {
	private int page;//현재 페이지 번호
	private int perPageNum;//한 페이지당 보여질 게시글 객수
	private int rowStart;//게시글 시작행번호
	private int rowEnd;//게시글 마지막행번호


	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		//현제 페이지 번호가 0보다 작으면 1로 표시
		if(page <=0) {
			this.page = 1;
		}else {
			this.page = page;			
		}
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int PageCount) {
		int cnt = this .perPageNum;
		if(PageCount != cnt) {
			this.perPageNum = cnt;
		}else {
			this.perPageNum = PageCount;			
		}
	}
	
	//시작 번호
	public int getRowStart() {
		//(현재 페이지번호 -1) * 한 페이지당 보여질 게시글 갯수
		rowStart = ((page - 1) * perPageNum) + 1;
		return rowStart;
	}
	public void setRowStart(int rowStart) {
		this.rowStart = rowStart;
	}
	//끝 번호
	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	public void setRowEnd(int rowEnd) {
		this.rowEnd = rowEnd;
	}
	
	
}
