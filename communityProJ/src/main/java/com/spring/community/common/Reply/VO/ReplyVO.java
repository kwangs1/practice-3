package com.spring.community.common.Reply.VO;

import java.sql.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

@Component
public class ReplyVO {
	private int rno;
	private int bno;
	private String nickname;
	private String r_pw;
	private String content;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date credate;
	private int r_depth;
	private int r_group;
	
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getR_pw() {
		return r_pw;
	}
	public void setR_pw(String r_pw) {
		this.r_pw = r_pw;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCredate() {
		return credate;
	}
	public void setCredate(Date credate) {
		this.credate = credate;
	}
	public int getR_depth() {
		return r_depth;
	}
	public void setR_depth(int r_depth) {
		this.r_depth = r_depth;
	}
	public int getR_group() {
		return r_group;
	}
	public void setR_group(int r_group) {
		this.r_group = r_group;
	}
	
	
}
