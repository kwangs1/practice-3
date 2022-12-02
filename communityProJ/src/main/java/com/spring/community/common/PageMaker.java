package com.spring.community.common;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

//페이징 버튼을 계산하기 위한 클래스
public class PageMaker {
	private Criteria cri;
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 5;
	
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	
	//버튼 생성 메서드
	private void calcData() {
		//끝 페이지번호 = (현재페이지번호 / 화면에 보여지는 페이지 번호 갯수) * 화면에 보여지는 페이지 번호 갯수
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)* displayPageNum);
		
		//시작 페이지 번호 = (끝 페이지 번호 - 화면에 보여지는 페이지 번호 갯수) +1
		startPage = (endPage - displayPageNum) +1;
		if(startPage <= 0) {
			startPage = 1;
		}
		
		//마지막페이지 = (총 게시글수 / 한 페이지당 보여질 게시글 수)
		//끝페이지 번호보다 작은경우 마지막 페이지의 번호를 끝페이지 번호로 저장
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		//이전버튼 = 시작페이지번호 == 1 이면 false 아니면 true
		prev = startPage == 1 ? false:true;
		//다음번호 = 끝페이지번호 * 한 페이지당 보여질 게시글 수 < 총 게시글수 면 true 아니면 false
		next = endPage * cri.getPerPageNum() < totalCount ? true:false;
	}
	
	
	
	
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

    
	//쿼리문자열을 추가해서 원하는 uri생성할 수 있는 메서드
    public String makeQueryPage(int page) {
        UriComponents uri = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum())
                .queryParam("b_group", cri.getB_group())
                .build();
        return uri.toUriString();
    }
	
}
