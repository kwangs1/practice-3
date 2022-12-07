package com.spring.community.Board.Controller;

import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.community.Board.Service.BoardService;
import com.spring.community.Board.VO.BoardVO;
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
		log.info("register.." + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	
	//게시판 상세보기
	@GetMapping("/detail")
	public void detail(int bno,BoardVO board,Model model) {
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
		service.remove(bno);
		
		return "redirect:/board/list";
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
		
		return "redirect:/board/list";
		
	}
}
