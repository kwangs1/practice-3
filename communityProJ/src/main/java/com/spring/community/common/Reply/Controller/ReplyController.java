package com.spring.community.common.Reply.Controller;

import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.community.Board.Service.BoardService;
import com.spring.community.common.Reply.Service.ReplyService;
import com.spring.community.common.Reply.VO.ReplyVO;

@RestController
@RequestMapping(value="/reply")
public class ReplyController {
	@Autowired
	private ReplyService service;
	@Autowired
	private BoardService boardService;
	
	private static Logger log = Logger.getLogger(ReplyController.class.getName());
	
	//댓글목록
	@PostMapping("/ReplyList")
	public List<ReplyVO> ReplyList(int bno,Model model){
		//댓글 수
		boardService.reply_count(bno);

		return service.ReplyList(bno);
	}
	
	//댓글작성
	@PostMapping("/addReply")
	public ResponseEntity<String> addReply(@RequestBody ReplyVO reply){
		log.info("ReplyVO:"+ reply);
			
		return service.addReply(reply) == 1  
				?  new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글수정
	@PostMapping("/ModifyReply")
	public ResponseEntity<String> ModifyReply(@RequestBody ReplyVO reply){
		log.info("modify:" + reply);

		return service.ModifyReply(reply) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//댓글삭제
	@PostMapping("/DeleteReply")
	public ResponseEntity<String> DeleteReply(ReplyVO reply){
		
		return service.DeleteReply(reply) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//대댓글 작성
	@PostMapping("/addReReply")
	public ResponseEntity<String> addRe_Reply(@RequestBody ReplyVO reply){	
		log.info("ReRepy-C:"+ reply);
		//댓글의 r_group를 가져오기위해 set저장
		int rno = reply.getRno();
		reply.setR_group(rno);
		//대댓글 이라는 것을 구분하기위한 r_depth 값 설정
		reply.setR_depth(1);
		
	return service.addRe_Reply(reply) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
