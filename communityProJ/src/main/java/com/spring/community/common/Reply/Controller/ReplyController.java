package com.spring.community.common.Reply.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.community.common.Reply.Service.ReplyService;
import com.spring.community.common.Reply.VO.ReplyVO;

@RestController
@RequestMapping(value="/reply")
public class ReplyController {
	@Autowired
	private ReplyService service;
	
	
	//´ñ±Û¸ñ·Ï
	@PostMapping("/ReplyList")
	public List<ReplyVO> ReplyList(int bno){
		return service.ReplyList(bno);
	}
	
	//´ñ±ÛÀÛ¼º
	@PostMapping("/addReply")
	public Map<String,Object> addReply(@RequestBody ReplyVO reply){
		Map<String, Object> result = new HashMap<>();
		
		try {
			service.addReply(reply);
			result.put("status" , "OK");
		}catch (Exception e) {
			e.printStackTrace();
			result.put("status", "false");
		}
		
		return result;
	}
	
	//´ñ±Û¼öÁ¤
	@PostMapping("/ModifyReply")
	public Map<String,Object> ModifyReply(@RequestBody ReplyVO reply){
		Map<String, Object> result = new HashMap<>();
		
		try {
			service.ModifyReply(reply);
			result.put("status" , "OK");
		}catch (Exception e) {
			e.printStackTrace();
			result.put("status", "false");
		}
		
		return result;
	}
	
	//´ñ±Û»èÁ¦
	@PostMapping("/DeleteReply")
	public Map<String,Object> DeleteReply(int rno){
		Map<String, Object> result = new HashMap<>();
		
		try {
			service.DeleteReply(rno);
			result.put("status" , "OK");
		}catch (Exception e) {
			e.printStackTrace();
			result.put("status", "false");
		}
		
		return result;
	}
}
