package com.spring.community.common.Like.DAO;

import java.util.Map;
import java.util.logging.Logger;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.common.Like.VO.LikeVO;
import com.spring.community.common.Like.VO.ReplyLikeVO;

@Repository
public class LikeDAOImpl implements LikeDAO{
	private static Logger log = Logger.getLogger(LikeDAO.class.getName());
	
	@Autowired
	private SqlSession session;
/* 게시글 좋아요,싫어요 */	
	//좋아요 누르기
	@Override
	public void LikeUp(LikeVO like) {
		session.insert("mapper.Like.LikeUp", like);
	}	
	//좋아요 취소
	@Override
	public void LikeDown(LikeVO like) {
		session.delete("mapper.Like.LikeDown", like);
	}	
	//좋아요 확인
	@Override
	public int findLike(int bno) {
		log.info("findLike....Check.."+bno);
		return session.selectOne("mapper.Like.findLike",bno);
	}
	//좋아요 갯수
	@Override
	public int getLike(Map<String,Object> data) {
		log.info("getLike...check..."+data);
		return session.selectOne("mapper.Like.getLike",data);
	}
	
	//싫어요 누르기
	@Override
	public void BadUp(LikeVO like) {
		session.insert("mapper.Like.BadUp", like);
	}	
	//싫어요 취소
	@Override
	public void BadDown(LikeVO like) {
		session.delete("mapper.Like.BadDown", like);
	}	
	//싫어요 확인
	@Override
	public int findBad(int bno) {
		log.info("findBad....Check.."+bno);
		return session.selectOne("mapper.Like.findBad",bno);
	}
	//싫어요 갯수
	@Override
	public int getBad(Map<String,Object> data) {
		log.info("getLike...check..."+data);
		return session.selectOne("mapper.Like.getBad",data);
	}

/* 댓글 좋아요,싫어요 */
	//좋아요 누르기
	@Override
	public void ReplyLikeUp(ReplyLikeVO replyLike) {
		session.insert("mapper.Like.ReplyLikeUp",replyLike);
	}
	//좋아요 취소
	@Override
	public void ReplyLikeDown(ReplyLikeVO replyLike) {
		session.delete("mapper.Like.ReplyLikeDown",replyLike);
	}
	//좋아요 확인
	@Override
	public int findReLike(int rno) {
		return session.selectOne("mapper.Like.findReLike",rno);
	}
	
	//싫어요 누르기
	@Override
	public void ReplyBadUp(ReplyLikeVO replyLike) {
		session.insert("mapper.Like.ReplyBadUp",replyLike);
	}
	//싫어요 취소
	@Override
	public void ReplyBadDown(ReplyLikeVO replyLike) {
		session.delete("mapper.Like.ReplyBadDown",replyLike);
	}
	//싫어요 확인
	@Override
	public int findReBad(int rno) {
		return session.selectOne("mapper.Like.findReBad",rno);
	}

}
