package com.spring.community.common.Scrap.VO;

import org.springframework.stereotype.Component;

@Component
public class ScrapVO {
	private int sno;
	private int bno;
	private String id;
	
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}
