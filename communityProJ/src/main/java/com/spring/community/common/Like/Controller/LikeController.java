package com.spring.community.common.Like.Controller;

import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.community.common.Like.Service.LikeService;
import com.spring.community.common.Like.VO.LikeVO;

@RestController
@RequestMapping(value="/Like")
public class LikeController {
	private static Logger log = Logger.getLogger(LikeController.class.getName());
	
	@Autowired
	private LikeService service;
	
	//좋아요 누르기
	@PostMapping("/LikeUp")
	public void LikeUp(@RequestBody LikeVO like) {
		log.info("LikeUp...C..:" + like);
		
		service.LikeUp(like);
	}
	
	//좋아요 취소
	@PostMapping("/LikeDown")
	public void LikeDown(@RequestBody LikeVO like) {
		log.info("LikeDown......:" + like);
		
		service.LikeDown(like);
	}
}
