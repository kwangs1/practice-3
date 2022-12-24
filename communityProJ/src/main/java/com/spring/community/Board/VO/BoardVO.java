package com.spring.community.Board.VO;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.spring.community.common.BoardAttachVO;

@Component
public class BoardVO {
	private int bno;
	private String title;
	private String nickname;
	private Date credate;
	private String content;
	private int pin;
	private int category;
	private int hit;
	private int reply_count;
	private int like_count;
	private List<BoardAttachVO> attachList;
	
	
	public List<BoardAttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<BoardAttachVO> attachList) {
		this.attachList = attachList;
	}
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
	
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	
	
}
