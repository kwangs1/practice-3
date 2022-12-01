package com.spring.community.Board.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.Board.VO.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	private SqlSession session;
	
	//게시판 목록
	@Override
	public List<BoardVO> getList() {
		return session.selectList("mapper.board.getList");
	}
	//게시글 작성
	@Override
	public void register(BoardVO board) {
		session.insert("mapper.board.register",board);
	}
	//목록
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
}
