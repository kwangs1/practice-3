package com.spring.community.common.Like.Service;

import com.spring.community.common.Like.VO.LikeVO;

public interface LikeService {
	//좋아요 누르기
	void LikeUp(LikeVO like);
	//좋아요 취소
	void LikeDown(LikeVO like);
	//좋아요 눌렀는지
	int findLike(int bno);
	//좋아요 갯수
	int getLike(int bno, int like_type);

}
