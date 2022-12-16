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
	//삭제
	int DeleteReply(int rno);
	//글 작성시 댓글 번호와 그룹번호 동일학 업데이트
	int Group_update(ReplyVO reply);

}
