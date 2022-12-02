package com.spring.community.Board.Service;

import java.util.List;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.Criteria;

public interface BoardService {
	//목록
	List<BoardVO> getList(Criteria cri);
	//목록(자랑)
	List<BoardVO> BoastList(Criteria cri);
	//목록(꽁략)
	List<BoardVO> AttackgetList(Criteria cri);
	//목록(질문)
	List<BoardVO> QnAList(Criteria cri);
	//목록(일반)
	List<BoardVO> NomalList(Criteria cri);
	//작성
	void register(BoardVO board);
	//상세보기
	BoardVO detail(int bno);
	//조회수
	int UpdateHit(int bno);
	//삭제
	int remove(int bno);
	//수정
	int modify(BoardVO board);
	//총 게시글 갯수
	int countList();

}
