package com.spring.community.common.Reply.Service;

import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.community.common.Reply.DAO.ReplyDAO;
import com.spring.community.common.Reply.VO.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyDAO dao;

	private static Logger log = Logger.getLogger(ReplyService.class.getName());
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
	@Override
	public ReplyVO getModifyReply(int rno) {
		log.info("댓글 수정팝업 Service");
		return dao.getModifyReply(rno);
	}
	//삭제
	@Override
	public int DeleteReply(ReplyVO reply) {
		
		//댓글에 달린 대댓글 갯수가 몇개인지 카운트
		int Count_ReReply = dao.Count_ReReply(reply);
		
		int result = 0;
			if(Count_ReReply == 0) {
				result = dao.DeleteReply(reply);
			}else {
				//만약 댓글에 답글이 달려있을 경우에 댓글 삭제시 (삭제된 댓글)이라는 값을 넣는다
				result = dao.Reply_Content(reply);
			}
		
		return result;
		
//		return  dao.DeleteReply(rno);
	}
	
	//대댓글 작성
	@Override
	public int addRe_Reply(ReplyVO reply){
		log.info("대댓글 작성 진입S");
		return dao.addRe_Reply(reply);
	}

}
