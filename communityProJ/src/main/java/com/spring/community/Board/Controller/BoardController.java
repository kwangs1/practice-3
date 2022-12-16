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

			board.getAttachList().forEach(attach -> log.info("getAttachList:"+attach));

		}

		log.info("==========================");

		service.register(board);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/lists";
	}
	
	//게시판 상세보기
	@GetMapping("/detail")
	public void detail(int bno,Model model,BoardVO boardVO) {
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
	
	//파일 삭제 메서드
	//BoardAttachVO에 을 List에 담아준다
	private void deleteFiles(List<BoardAttachVO> attachList) {
	    //만약 list안에 값이 없거나 배열의 타입 길이가 0 이면 리턴을 시킨다
	    if(attachList == null || attachList.size() == 0) {
	      return;
	    }
	    
	    log.info("delete attach files...................");
	    log.info("delete attachList"+attachList);
	    //람다함수를 사용해서 배열에 담긴 값을 매개변수 attach를 통해 출력
	    attachList.forEach(attach -> {
	      try {        
	    	  //파일의 경로에 있는 이미지 파일의 값을 가져와 file객체에 넣는다
	        Path file  = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
	        //deleteIfExists() 를 사용해서 파일이 존재하면 삭제, 존재하지않으면 false를 리턴하게 함
	        Files.deleteIfExists(file);
	        //만약 파일에 입력된 값이 image로 시작한다면
	        if(Files.probeContentType(file).startsWith("image")) {
	        	//thumbNail변수에 그 경로에 있는 파일 값을 넣고
	          Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
	          //삭제시킨다
	          Files.delete(thumbNail);
	        }
	
	      }catch(Exception e) {
	        log.info("delete file error" + e.getMessage());
	      }//end catch
	    });//end foreachd
	  }

	
	//저장된 이미지 파일을 List를 통해 출력시키기 위해
	@GetMapping(value = "/getAttachList",
			    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int bno) {

		log.info("getAttachList " + bno);

		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);

	}
}
