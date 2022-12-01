package com.spring.community.Board.VO;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class BoardVO {
	private int bno;
	private String title;
	private String nickname;
	private Date credate;
	private String content;
	private int pin;
	private int b_group;
	private int hit;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getCredate() {
		return credate;
	}
	public void setCredate(Date credate) {
		this.credate = credate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getPin() {
		return pin;
	}
	public void setPin(int pin) {
		this.pin = pin;
	}
	public int getB_group() {
		return b_group;
	}
	public void setB_group(int b_group) {
		this.b_group = b_group;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	
}
