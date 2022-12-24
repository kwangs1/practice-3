package com.spring.community.common.Like.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.community.common.Like.DAO.LikeDAO;
import com.spring.community.common.Like.VO.LikeVO;

@Service
public class LikeServiceImpl implements LikeService{
	private static Logger log = Logger.getLogger(LikeService.class.getName());
	
	@Autowired
	private LikeDAO dao;
	
	//좋아요 누르기
	@Override
	public void LikeUp(LikeVO like) {
		log.info("LikeUp.....S..:"+ like);
		dao.LikeUp(like);
	}
	
	//좋아요 취소
	@Override
	public void LikeDown(LikeVO like) {
		log.info("LikeDown.....S..:" + like);
		dao.LikeDown(like);
	}
	
	//좋아요 확인
	@Override
	public int findLike(int bno) {
		log.info("findLike...Check..."+bno);
		return dao.findLike(bno);
	}
	
	//좋아요 갯수
	@Override
	public int getLike(int bno, int like_type) {
		log.info("getLike...check..."+bno+"\\\\"+like_type);
		Map<String,Object>map = new HashMap<>();
		map.put("bno", bno);
		map.put("like_type", like_type);
		
		return dao.getLike(map);
	}


	

}
