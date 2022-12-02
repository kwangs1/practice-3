package com.spring.community.Board.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.Criteria;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	private SqlSession session;
	
	//게시판 목록
	@Override
	public List<BoardVO> getList(Criteria cri) {
		return session.selectList("mapper.board.getList",cri);
	}
	//게시판 목록(일반)
	@Override
	public List<BoardVO> NomalList(Criteria cri) {
		return session.selectList("mapper.board.NomalList",cri);
	}
	//게시판 목록(질문)
	@Override
	public List<BoardVO> QnAList(Criteria cri) {
		return session.selectList("mapper.board.QnAList",cri);
	}
	//게시판 목록(공략)
	@Override
	public List<BoardVO> AttackgetList(Criteria cri) {
		return session.selectList("mapper.board.AttackgetList",cri);
	}
	//게시판 목록(자랑)
	@Override
	public List<BoardVO> BoastList(Criteria cri) {
		return session.selectList("mapper.board.BoastList",cri);
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
	//총게시글 갯수
	@Override
	public int countList() {
		return (Integer)session.selectOne("mapper.board.countList");
	}
}
