package com.spring.community.common.Scrap.Service;

import java.util.List;
import java.util.Map;

import com.spring.community.common.Criteria;
import com.spring.community.common.Scrap.VO.ScrapVO;

public interface ScrapService {
	//½ºÅ©·¦ ¸®½ºÆ®
	Map<String, List> ScrapList(ScrapVO scrap,Criteria cri);
	//½ºÅ©·¦ ÇÏ¿´´ÂÁö?
	boolean findScrap(ScrapVO scrap);
	//½ºÅ©·¦ Ãß°¡
	void addScrap(ScrapVO scrap);
	//½ºÅ©·¦ »èÁ¦
	void removeScrap(int sno);
	int getScrapTotal(String id);

}
