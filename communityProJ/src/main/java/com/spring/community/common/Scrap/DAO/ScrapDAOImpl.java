package com.spring.community.common.Scrap.DAO;

import java.util.List;
import java.util.logging.Logger;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.Scrap.VO.ScrapVO;

@Repository
public class ScrapDAOImpl implements ScrapDAO{
	private static Logger log = Logger.getLogger(ScrapDAO.class.getName());
	
	@Autowired
	private SqlSession session;
	
	//½ºÅ©·¦ ¸®½ºÆ®
	@Override
	public List<ScrapVO>ScrapList(ScrapVO scrap){
		List<ScrapVO>ScrapList = session.selectList("mapper.scrap.ScrapList",scrap);
		return ScrapList;
	}
	
	@Override
	public List<BoardVO>boardList(List<ScrapVO>ScrapList){
		List<BoardVO>boardList = session.selectList("mapper.scrap.boardList",ScrapList);
		return boardList;
	}

	//½ºÅ©·¦ µÇ¾îÀÖ´Â ±ÛÀÎÁö?
	@Override
	public boolean findScrap(ScrapVO scrap) {
		String result = session.selectOne("mapper.scrap.findScrap",scrap);
		return Boolean.parseBoolean(result);
	}
	
	//½ºÅ©·¦ Ãß°¡
	@Override
	public void addScrap(ScrapVO scrap) {
		session.insert("mapper.scrap.addScrap",scrap);
	}
	
	//½ºÅ©·¦ »èÁ¦
	@Override
	public void removeScrap(int sno) {
		log.info("»èÁ¦°¡ ¸ÔÈû??."+sno);
		session.delete("mapper.scrap.removeScrap",sno);
	}
	
}
