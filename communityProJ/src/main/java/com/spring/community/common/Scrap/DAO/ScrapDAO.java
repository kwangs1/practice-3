package com.spring.community.common.Scrap.DAO;

import java.util.List;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.Criteria;
import com.spring.community.common.Scrap.VO.ScrapVO;

public interface ScrapDAO {
	//½ºÅ©·¦ ¸®½ºÆ®
	List<ScrapVO> ScrapList(ScrapVO scrap);
	List<BoardVO> boardList(Criteria cri);
	//½ºÅ©·¦ µÇ¾îÀÖ´Â ±ÛÀÎÁö?
	boolean findScrap(ScrapVO scrap);
	//½ºÅ©·¦ Ãß°¡
	void addScrap(ScrapVO scrap);
	//½ºÅ©·¦ »èÁ¦
	void removeScrap(int sno);
	int getScrapTotal(String id);
}
