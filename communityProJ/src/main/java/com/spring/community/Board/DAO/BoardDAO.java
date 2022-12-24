package com.spring.community.Board.DAO;

import java.util.List;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.SearchCriteria;

public interface BoardDAO {
	//목록
	List<BoardVO> lists(SearchCriteria scri);
	//목록(자랑)
	List<BoardVO> brag(SearchCriteria scri);
	//목록(공략)
	List<BoardVO> tip(SearchCriteria scri);
	//목록(질문)
	List<BoardVO> qna(SearchCriteria scri);
	//목록(자랑)
	List<BoardVO> free(SearchCriteria scri);
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
	//댓글 갯수
	void reply_count(int bno);
	//게시글 목록 좋아요 갯수
	void like_count(int bno);

}
