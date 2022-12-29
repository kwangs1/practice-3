package com.spring.community.common.Reply.DAO;

import java.util.List;
import java.util.logging.Logger;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.common.Reply.VO.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	@Autowired
	private SqlSession session;
	
	private static Logger log = Logger.getLogger(ReplyDAO.class.getName());
	//목록
	@Override
	public List<ReplyVO> ReplyList(int bno){
		return session.selectList("mapper.reply.ReplyList",bno);
	}
	
	//작성
	@Override
	public int addReply(ReplyVO reply) {
		return session.insert("mapper.reply.addReply",reply);
	}
	
	//수정
	@Override
	public int ModifyReply(ReplyVO reply) {
		return session.update("mapper.reply.ModifyReply",reply);
	}
	@Override
	public ReplyVO getModifyReply(int rno) {
		log.info("댓글 수정팝업창 dao");
		return session.selectOne("mapper.reply.getModifyReply",rno);
	}
	//삭제
	@Override
	public int DeleteReply(ReplyVO reply) {
		return session.delete("mapper.reply.DeleteReply",reply);
	}
	
	//삭제시 댓글에 대댓글 카운트
	@Override
	public int Count_ReReply(ReplyVO reply) {
		return session.selectOne("mapper.reply.Count_ReReply",reply);
	}
	//대댓글이 달린 댓글 삭제시 완전삭제가 아닌 (삭제된 댓글)이라고 표기
	@Override
	public int Reply_Content(ReplyVO reply) {
		return session.update("mapper.reply.Reply_Content",reply);
	}
	
	//글 작성시 댓글 번호와 그룹번호 동일학 업데이트
	@Override
	public int Group_update(ReplyVO reply) {
		return session.update("mapper.reply.Group_update",reply);
	}
	
	//대댓글 작성
	@Override
	public int addRe_Reply(ReplyVO reply) {
		return session.insert("mapper.reply.addRe_Reply",reply);
	}
	
	//댓글에 달린 좋아요 추가 및 삭제
	//추가
	@Override
	public int ReplyLikeUp(int rno) {
		return session.update("mapper.reply.ReplyLikeUp",rno);
	}
	//삭제
	@Override
	public int ReplyLikeDown(int rno) {
		return session.update("mapper.reply.ReplyLikeDown",rno);
	}
	
	//댓글에 달린 싫어요 추가 및 삭제
	//추가
	@Override
	public int ReplyBadUp(int rno) {
		return session.update("mapper.reply.ReplyBadUp",rno);
	}
	//삭제
	@Override
	public int ReplyBadDown(int rno) {
		return session.update("mapper.reply.ReplyBadDown",rno);
	}
}
