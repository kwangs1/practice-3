package com.spring.community.Board.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.common.BoardAttachVO;

@Repository
public class BoardAttachDAOImpl implements BoardAttachDAO{
	@Autowired
	private SqlSession session;
	
	@Override
	public List<BoardAttachVO> getAttachList(int bno){
		return session.selectList("mapper.attach.getAttachList",bno);
	};
	
	@Override
	public void deleteImg(int bno) {
		session.delete("mapper.attach.deleteImg",bno);
	}
	
	@Override
	public void board_image(BoardAttachVO vo) {
		session.insert("mapper.attach.board_image",vo);
	}
	
	@Override
	public List<BoardAttachVO> getOldFiles(){
		return session.selectList("mapper.attach.getOldFiles");
	}
}
