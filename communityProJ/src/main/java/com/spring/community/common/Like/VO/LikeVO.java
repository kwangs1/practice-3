package com.spring.community.common.Like.VO;

import org.springframework.stereotype.Component;

@Component
public class LikeVO {
	private int lno;
	private int bno;
	private int like_type;
	
	public int getLno() {
		return lno;
	}
	public void setLno(int lno) {
		this.lno = lno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getLike_type() {
		return like_type;
	}
	public void setLike_type(int like_type) {
		this.like_type = like_type;
	}
	
	
}
