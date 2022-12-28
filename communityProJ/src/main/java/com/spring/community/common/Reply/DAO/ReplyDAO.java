package com.spring.community.common.Reply.DAO;

import java.util.List;

import com.spring.community.common.Reply.VO.ReplyVO;

public interface ReplyDAO {
	//목록
	List<ReplyVO> ReplyList(int bno);
	//작성
	int addReply(ReplyVO reply);
	//수정
	int ModifyReply(ReplyVO reply);
	ReplyVO getModifyReply(int rno);
	//삭제
	int DeleteReply(ReplyVO reply);
	
	//댓글에 달리 대댓글 갯수 카운트
	int Count_ReReply(ReplyVO reply);
	//댓글 삭제시 대댓글 달려있으면 (삭제된 댓글)이라고 수정
	int Reply_Content(ReplyVO reply);
	
	//글 작성시 댓글 번호와 그룹번호 동일학 업데이트
	int Group_update(ReplyVO reply);
	//대댓글 작성
	int addRe_Reply(ReplyVO reply);
	//댓글에 달린 좋아요 추가 및 삭제
	//추가
	int ReplyLikeUp(int rno);
	//삭제
	int ReplyLikeDown(int rno);

}
