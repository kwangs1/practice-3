package com.spring.community.common.Scrap.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.Criteria;
import com.spring.community.common.Scrap.DAO.ScrapDAO;
import com.spring.community.common.Scrap.VO.ScrapVO;

@Service
public class ScrapServiceImpl implements ScrapService{
	private static Logger log = Logger.getLogger(ScrapService.class.getName());
	
	@Autowired
	private ScrapDAO dao;
	
	//스크랩 리스트
	@Override
	public Map<String,List> ScrapList(ScrapVO scrap,Criteria cri){
		Map<String,List> map = new HashMap<String,List>();
		List<ScrapVO> ScrapList = dao.ScrapList(scrap);
		//만약 스크랩 된 게시글이 없을경우
		if(ScrapList.size() == 0) {
			return null;
		}
		//스크랩 한 게시물 정보 가져오기 위함.
		List<BoardVO> boardList = dao.boardList(cri);
		
		//목록 정보를 map 담아 저장
		map.put("ScrapList", ScrapList);
		map.put("boardList", boardList);
		return map;
	}
	
	//스크랩을 하였던 게시글인가?
	@Override
	public boolean findScrap(ScrapVO scrap) {
		return dao.findScrap(scrap);
	}
	
	//스크랩 추가
	@Override
	public void addScrap(ScrapVO scrap) {
		dao.addScrap(scrap);
	}
	
	//스크랩 삭제
	@Override
	public void removeScrap(int sno) {
		log.info("삭제가 먹힘??."+sno);
		dao.removeScrap(sno);
	}
	
	//스크랩 된 게시글 총 개수
	@Override
	public int getScrapTotal(String id) {
		log.info("cri.getId(Service)"+ id);
		return dao.getScrapTotal(id);
	}
	
}
