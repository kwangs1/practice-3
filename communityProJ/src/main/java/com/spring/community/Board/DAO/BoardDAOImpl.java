package com.spring.community.Board.DAO;

import java.util.List;
import java.util.logging.Logger;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO{
	private static Logger log = Logger.getLogger(BoardDAO.class.getName());
	@Autowired
	private SqlSession session;
	
	//게시판 목록
	@Override
	public List<BoardVO> lists(SearchCriteria scri) {
		return session.selectList("mapper.board.lists",scri);
	}
	//게시판 목록(자유)
	@Override
	public List<BoardVO> free(SearchCriteria scri) {
		return session.selectList("mapper.board.free",scri);
	}
	//게시판 목록(질문)
	@Override
	public List<BoardVO> qna(SearchCriteria scri) {
		return session.selectList("mapper.board.qna",scri);
	}
	//게시판 목록(공략)
	@Override
	public List<BoardVO> tip(SearchCriteria scri) {
		return session.selectList("mapper.board.tip",scri);
	}
	//게시판 목록(자랑)
	@Override
	public List<BoardVO> brag(SearchCriteria scri) {
		return session.selectList("mapper.board.brag",scri);
	}
	//게시글 작성
	@Override
	public void insertSelectKey(BoardVO board) {
		session.insert("mapper.board.insertSelectKey",board);
	}
	@Override
	public void insert(BoardVO board) {
		session.insert("mapper.board.insert",board);
	}
	//상세보기
	@Override
	public BoardVO detail(int bno) {
		return session.selectOne("mapper.board.detail",bno);
	}
	//조회수
	@Override
	public int UpdateHit(int bno) {
		return session.update("mapper.board.UpdateHit",bno);
	}
	//삭제
	@Override
	public int remove(int bno) {
		return session.delete("mapper.board.remove",bno);
	}
	//수정
	@Override
	public int modify(BoardVO board) {
		return session.update("mapper.board.modify",board); 
	}
	//총게시글 갯수
	@Override
	public int countList() {
		return session.selectOne("mapper.board.countList");
	}
	//댓글 갯수
	@Override
	public void reply_count(int bno) {
		 session.update("mapper.board.reply_count",bno);
	}
	//게시글 목록 좋아요 갯수 
	@Override
	public void like_count(int bno) {
		log.info("좋아요 갯수 카운트ㅡㅡ....");
		 session.update("mapper.board.like_count",bno);
	}

}
