package com.spring.community.Board.Service;

import java.util.List;

import com.spring.community.Board.VO.BoardVO;

public interface BoardService {
	//목록
	List<BoardVO> getList();
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

}
