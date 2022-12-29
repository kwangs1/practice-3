package com.spring.community.common.Reply.Service;

import java.util.List;

import com.spring.community.common.Reply.VO.ReplyVO;

public interface ReplyService {
	//목록
	List<ReplyVO> ReplyList(int bno);
	//작성
	int addReply(ReplyVO reply);
	//수정
	int ModifyReply(ReplyVO reply);
	ReplyVO getModifyReply(int rno);
	//삭제
	int DeleteReply(ReplyVO reply);
	//대댓글 작성
	int addRe_Reply(ReplyVO reply);
	
	//댓글에 달린 좋아요 갯수 추가 및 삭제
	//추가
	int ReplyLikeUp(int rno);
	//삭제
	int ReplyLikeDown(int rno);	
	
	//댓글에 달린 싫어요 갯수 추가 및 삭제
	//추가
	int ReplyBadUp(int rno);
	//삭제
	int ReplyBadDown(int rno);
}
