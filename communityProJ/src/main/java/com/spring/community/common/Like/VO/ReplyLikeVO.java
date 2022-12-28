package com.spring.community.common.Like.VO;

import org.springframework.stereotype.Component;

@Component
public class ReplyLikeVO {
	private int hrno;
	private int rno;
	private int like_type;
	private int bad_type;
	
	public int getHrno() {
		return hrno;
	}
	public void setHrno(int hrno) {
		this.hrno = hrno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getLike_type() {
		return like_type;
	}
	public void setLike_type(int like_type) {
		this.like_type = like_type;
	}
	public int getBad_type() {
		return bad_type;
	}
	public void setBad_type(int bad_type) {
		this.bad_type = bad_type;
	}
	
	
}
