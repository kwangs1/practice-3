package com.spring.community.Board.Service;

import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.community.Board.DAO.BoardDAO;
import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.Criteria;

@Service
public class BoardServiceImpl implements BoardService{
	private static Logger log = Logger.getLogger(BoardService.class.getName());
	@Autowired
	private BoardDAO dao;
	
	//게시판 목록
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList......");
		return dao.getList(cri);
	}
	//게시판 목록(일반)
	@Override
	public List<BoardVO> NomalList(Criteria cri) {
		log.info("NomalList......");
		return dao.NomalList(cri);
	}
	//게시판 목록(질문)
	@Override
	public List<BoardVO> QnAList(Criteria cri) {
		log.info("QnAList......");
		return dao.QnAList(cri);
	}
	//게시판 목록(공략)
	@Override
	public List<BoardVO> AttackgetList(Criteria cri) {
		log.info("AttackgetList......");
		return dao.AttackgetList(cri);
	}
	//게시판 목록(자랑)
	@Override
	public List<BoardVO> BoastList(Criteria cri) {
		log.info("BoastList......");
		return dao.BoastList(cri);
	}
	//게시판 작성
	@Override
	public void register(BoardVO board) {
		log.info("register....." + board);
		dao.register(board);
	}
	//목록
	@Override
	public BoardVO detail(int bno) {
		log.info("detail...." + bno);
		return dao.detail(bno);
	}
	//조회수
	@Override
	public int UpdateHit(int bno) {
		return dao.UpdateHit(bno);
	}
	//삭제
	@Override
	public int remove(int bno) {
		return dao.remove(bno);
	}
	//수정
	@Override
	public int modify(BoardVO board) {
		log.info("modify.."+board);
		return dao.modify(board);
	}
	//총 게시글 갯수
	@Override
	public int countList() {
		return dao.countList();
	}
}
