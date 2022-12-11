package com.spring.community.Board.DAO;

import java.util.List;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.BoardAttachVO;
import com.spring.community.common.Criteria;

public interface BoardDAO {
	//목록
	List<BoardVO> lists(Criteria cri);
	//목록(자랑)
	List<BoardVO> brag(Criteria cri);
	//목록(공략)
	List<BoardVO> tip(Criteria cri);
	//목록(질문)
	List<BoardVO> qna(Criteria cri);
	//목록(자랑)
	List<BoardVO> free(Criteria cri);
	//작성
	void insertSelectKey(BoardVO board);
	void insert(BoardVO board);
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
