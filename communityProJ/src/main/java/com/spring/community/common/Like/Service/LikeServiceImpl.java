package com.spring.community.common.Like.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.community.common.Like.DAO.LikeDAO;
import com.spring.community.common.Like.VO.LikeVO;
import com.spring.community.common.Like.VO.ReplyLikeVO;

@Service
public class LikeServiceImpl implements LikeService{
	private static Logger log = Logger.getLogger(LikeService.class.getName());
	
	@Autowired
	private LikeDAO dao;

/* 게시글 좋아요,싫어요 */	
	//좋아요 누르기
	@Override
	public void LikeUp(LikeVO like) {
		log.info("좋아요 누름....." + like);
		dao.LikeUp(like);
	}	
	//좋아요 취소
	@Override
	public void LikeDown(LikeVO like) {
		log.info("좋아요 취소....." + like);
		dao.LikeDown(like);			
	}	
	//좋아요 확인
	@Override
	public int findLike(int bno) {
		log.info("findLike...Check..."+bno);
		return dao.findLike(bno);
	}	
	//좋아요 갯수
	@Override
	public int getLike(int bno, int like_type) {
		log.info("getLike...check..."+bno+"\\\\"+like_type);
		Map<String,Object>map = new HashMap<>();
		map.put("bno", bno);
		map.put("like_type", like_type);
		
		return dao.getLike(map);
	}

	//싫어요 누르기
	@Override
	public void BadUp(LikeVO like) {
		log.info("싫어요 누름....." + like);
		dao.BadUp(like);
	}
	//싫어요 취소
	@Override
	public void BadDown(LikeVO like) {
		log.info("싫어요 취소....." + like);
		dao.BadDown(like);			
	}
	//싫어요 확인
	@Override
	public int findBad(int bno) {
		log.info("findBad...Check..."+bno);
		return dao.findBad(bno);
	}
	//싫어요 갯수
	@Override
	public int getBad(int bno, int bad_type) {
		log.info("getLike...check..."+bno+"\\\\"+bad_type);
		Map<String,Object>map = new HashMap<>();
		map.put("bno", bno);
		map.put("bad_type", bad_type);
		
		return dao.getBad(map);
	}

/* 댓글 좋아요,싫어요 */
	//좋아요 누르기
	@Override
	public void ReplyLikeUp(ReplyLikeVO replyLike) {
		dao.ReplyLikeUp(replyLike);
	}
	//좋아요 취소
	@Override
	public void ReplyLikeDown(ReplyLikeVO replyLike) {
		dao.ReplyLikeDown(replyLike);
	}
	//좋아요 확인
	@Override
	public int findReLike(int rno) {
		return dao.findReLike(rno);
	}	
	
	//싫어요 누르기
	@Override
	public void ReplyBadUp(ReplyLikeVO replyLike) {
		dao.ReplyBadUp(replyLike);
	}
	//싫어요 취소
	@Override
	public void ReplyBadDown(ReplyLikeVO replyLike) {
		dao.ReplyBadDown(replyLike);
	}
	//싫어요 확인
	@Override
	public int findReBad(int rno) {
		return dao.findReBad(rno);
	}	
	
	

}
