package com.spring.community.Board.Service;

import java.util.List;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.BoardAttachVO;
import com.spring.community.common.SearchCriteria;

public interface BoardService {
	//목록
	List<BoardVO> lists(SearchCriteria scri);
	//목록(자랑)
	List<BoardVO> brag(SearchCriteria scri);
	//목록(꽁략)
	List<BoardVO> tip(SearchCriteria scri);
	//목록(질문)
	List<BoardVO> qna(SearchCriteria scri);
	//목록(자유)
	List<BoardVO> free(SearchCriteria scri);
	//작성
	void register(BoardVO board);
	//상세보기
	BoardVO detail(int bno);
	//조회수
	int UpdateHit(int bno);
	//삭제
	boolean remove(int bno);
	//수정
	boolean modify(BoardVO board);
	//총 게시글 갯수
	int countList();
	//댓글 갯수
	void reply_count(int bno);
	//좋아요 갯수
	void like_count(int bno);
	//이미지 파일 리스트
	List<BoardAttachVO> getAttachList(int bno);
	//이미지 삭제
	void removeAttach(int bno);

}
