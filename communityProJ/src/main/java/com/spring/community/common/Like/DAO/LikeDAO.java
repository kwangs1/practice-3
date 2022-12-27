package com.spring.community.common.Like.DAO;

import java.util.Map;

import com.spring.community.common.Like.VO.LikeVO;

public interface LikeDAO {
/* 게시글 좋아요,싫어요 */
	//좋아요누르기
	void LikeUp(LikeVO like);
	//좋아요 취소
	void LikeDown(LikeVO like);
	//좋아요 확인
	int findLike(int bno);
	//좋아요 갯수
	int getLike(Map<String, Object> data);
	//싫어요 누르기
	void BadUp(LikeVO like);
	//싫어요 취소
	void BadDown(LikeVO like);
	//싫어요 확인
	int findBad(int bno);

}
