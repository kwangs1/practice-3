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
	public int DeleteReply(int rno) {
		return session.delete("mapper.reply.DeleteReply",rno);
	}
	
	//글 작성시 댓글 번호와 그룹번호 동일학 업데이트
	@Override
	public int Group_update(ReplyVO reply) {
		return session.update("mapper.reply.Group_update",reply);
	}
}
