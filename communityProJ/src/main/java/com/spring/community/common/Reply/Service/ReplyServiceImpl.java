package com.spring.community.common.Reply.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.community.common.Reply.DAO.ReplyDAO;
import com.spring.community.common.Reply.VO.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyDAO dao;
	
	//목록
	@Override
	public List<ReplyVO> ReplyList(int bno){
		return dao.ReplyList(bno);
	}
	
	//작성
	@Override
	public int addReply(ReplyVO reply) {
		int result = dao.addReply(reply);
		
		//댓글 작성 시 해당 댓글의 r_group 컬럼 값을 rno 와 같게 업데이트 시키기위해서 코드 작성
		//이후 답글과 묶기위해서
		if(result == 1) {
			int Group_update = dao.Group_update(reply);
			reply.setR_group(Group_update);
		}
		return result;
	}
	
	//수정
	@Override
	public int ModifyReply(ReplyVO reply) {
		return dao.ModifyReply(reply);
	}
	
	//삭제
	@Override
	public int DeleteReply(int rno) {
		return dao.DeleteReply(rno);
	}
}
