package com.spring.community.Board.Controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.community.Board.Service.BoardService;
import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.BoardAttachVO;
import com.spring.community.common.Criteria;
import com.spring.community.common.PageMaker;

@Controller
@RequestMapping(value="/board/*")
public class BoardController{
	private static Logger log = Logger.getLogger(BoardController.class.getName());
	@Autowired
	private BoardService service;
	
	
	//게시판 목록
	@GetMapping("/lists")
	public void list(Model model,Criteria cri) {
		log.info("All-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);	
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
	
		model.addAttribute("pageMaker",pageMaker);
		//전체
		model.addAttribute("lists",service.lists(cri));

	}
	//게시판 목록(자유)
	@GetMapping("/free")
	public void free(Model model,Criteria cri) {
		log.info("free-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);	
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());		
		model.addAttribute("pageMaker",pageMaker);
		//자유
		model.addAttribute("free",service.free(cri));

	}
	//게시판 목록(질문)
	@GetMapping("/qna")
	public void qna(Model model,Criteria cri) {
		log.info("qna-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);	
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
		model.addAttribute("pageMaker",pageMaker);
		//자유
		model.addAttribute("qna",service.qna(cri));

	}
	//게시판 목록(자랑)
	@GetMapping("/brag")
	public void brag(Model model,Criteria cri) {
		log.info("brag-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
		model.addAttribute("pageMaker",pageMaker);
		//자유
		model.addAttribute("brag",service.brag(cri));

	}
	//게시판 목록(공략)
	@GetMapping("/tip")
	public void tip(Model model,Criteria cri) {
		log.info("tip-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
		model.addAttribute("pageMaker",pageMaker);
		//자유
		model.addAttribute("tip",service.tip(cri));

	}

	//게시판 작성 
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {

		log.info("==========================");

		log.info("register: " + board);

		if (board.getAttachList() != null) {

			board.getAttachList().forEach(attach -> log.info("나와주세요~"+attach));

		}

		log.info("==========================");

		service.register(board);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/lists";
	}
	
	//게시판 상세보기
	@GetMapping("/detail")
	public void detail(int bno,BoardVO board,Model model,BoardAttachVO img) {
		log.info("detail"+bno);
		//상세보기
		model.addAttribute("detail",service.detail(bno));
		//조회수
		service.UpdateHit(bno);
	}
	
	//게시판 삭제
	@GetMapping("/remove")
	public String remove(int bno) { 
		log.info("remove.."+bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
		}
		
		
		return "redirect:/board/lists";
	}
	
	//게시판 수정
	@GetMapping("/modify")
	public void modify(int bno,Model model) {
		log.info("get modify");
		model.addAttribute("board",service.detail(bno));
	}
	@PostMapping("/modify")
	public String modify(BoardVO board) {
		log.info("post modify.."+board);
		service.modify(board);
		
		return "redirect:/board/lists";
		
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
	    
	    if(attachList == null || attachList.size() == 0) {
	      return;
	    }
	    
	    log.info("delete attach files...................");
	    log.info("delete attachList"+attachList);
	    
	    attachList.forEach(attach -> {
	      try {        
	        Path file  = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
	        
	        Files.deleteIfExists(file);
	        
	        if(Files.probeContentType(file).startsWith("image")) {
	        
	          Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
	          
	          Files.delete(thumbNail);
	        }
	
	      }catch(Exception e) {
	        log.info("delete file error" + e.getMessage());
	      }//end catch
	    });//end foreachd
	  }

	

	@GetMapping(value = "/getAttachList",
			    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int bno) {

		log.info("getAttachList " + bno);

		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);

	}
}
