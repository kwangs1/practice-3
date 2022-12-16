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
	//삭제
	int DeleteReply(int rno);

}
