package com.spring.community.common.Like.VO;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class LikeVO {
	private int lno;
	private int bno;
	private String id;
	private int like_type;
	private int bad_type;
	private Date credate;
	
	
	
	public Date getCredate() {
		return credate;
	}
	public void setCredate(Date credate) {
		this.credate = credate;
	}
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
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
