package com.spring.community.Board.Controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.community.Board.Service.BoardService;
import com.spring.community.Board.VO.BoardVO;
import com.spring.community.common.BoardAttachVO;
import com.spring.community.common.PageMaker;
import com.spring.community.common.SearchCriteria;
import com.spring.community.common.Like.Service.LikeService;
import com.spring.community.common.Like.VO.LikeVO;
import com.spring.community.common.Like.VO.ReplyLikeVO;
import com.spring.community.common.Reply.Service.ReplyService;

@Controller
@RequestMapping(value="/board/*")
public class BoardController{
	private static Logger log = Logger.getLogger(BoardController.class.getName());
	@Autowired
	private BoardService service;
	@Autowired
	private ReplyService replySerivce;
	@Autowired
	private LikeService likeService;
	
	
	//게시판 목록
	@GetMapping("/lists")
	public void list(Model model,@ModelAttribute("scri")SearchCriteria scri) {
		log.info("All-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);	
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
	
		model.addAttribute("pageMaker",pageMaker);
		//전체
		model.addAttribute("lists",service.lists(scri));		
		//댓글,좋아요 갯수
		BoardVO board = new BoardVO();
		service.reply_count(board.getBno());
	}
	//게시판 목록(자유)
	@GetMapping("/free")
	public void free(Model model,@ModelAttribute("scri")SearchCriteria scri) {
		log.info("free-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);	
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());		
		model.addAttribute("pageMaker",pageMaker);
		//자유
		model.addAttribute("free",service.free(scri));
		//댓글,좋아요 갯수
		BoardVO board = new BoardVO();
		service.reply_count(board.getBno());

	}
	//게시판 목록(질문)
	@GetMapping("/qna")
	public void qna(Model model,@ModelAttribute("scri")SearchCriteria scri) {
		log.info("qna-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);	
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
		model.addAttribute("pageMaker",pageMaker);
		//질문
		model.addAttribute("qna",service.qna(scri));
		//댓글,좋아요 갯수
		BoardVO board = new BoardVO();
		service.reply_count(board.getBno());

	}
	//게시판 목록(자랑)
	@GetMapping("/brag")
	public void brag(Model model,@ModelAttribute("scri")SearchCriteria scri) {
		log.info("brag-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
		model.addAttribute("pageMaker",pageMaker);
		//자랑
		model.addAttribute("brag",service.brag(scri));
		//댓글,좋아요 갯수
		BoardVO board = new BoardVO();
		service.reply_count(board.getBno());

	}
	//게시판 목록(공략)
	@GetMapping("/tip")
	public void tip(Model model,@ModelAttribute("scri")SearchCriteria scri) {
		log.info("tip-list");
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		//총 게시글 갯수
		pageMaker.setTotalCount(service.countList());
		model.addAttribute("pageMaker",pageMaker);
		//공략
		model.addAttribute("tip",service.tip(scri));
		//댓글,좋아요 갯수
		BoardVO board = new BoardVO();
		service.reply_count(board.getBno());

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
	public void detail(int bno,Model model,@ModelAttribute("scri")SearchCriteria scri
			,HttpServletRequest request) {
		log.info("detail"+bno);
		//상세보기
		model.addAttribute("detail",service.detail(bno));
		//조회수
		service.UpdateHit(bno);
		//좋아요
		LikeVO like = new LikeVO();
		like.setBno(bno);
		like.setLike_type(1);
		like.setBad_type(1);
		
		/* 게시글 좋아요,싫어요 확인 */
		//좋아요 확인
		model.addAttribute("findLike",likeService.findLike(bno));
		//좋아요 갯수
		model.addAttribute("getLike",likeService.getLike(bno,1));
		//싫어요 확인
		model.addAttribute("findBad",likeService.findBad(bno));
		//싫어요 갯수
		model.addAttribute("getBad",likeService.getBad(bno,1));
		
	}
	//수정 팝업창
	@GetMapping("/getModifyReply")
	public void getModifyReply(int rno,Model model) {
		log.info("댓글 수정 팝업 Controller");
		model.addAttribute("reply",replySerivce.getModifyReply(rno));
	}
	
	//게시판 삭제
	@GetMapping("/remove")
	public String remove(int bno,RedirectAttributes rttr,@ModelAttribute("scri")SearchCriteria scri) { 
		log.info("remove.."+bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
		}
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:/board/lists";
	}
	
	//게시판 수정
	@GetMapping("/modify")
	public void modify(int bno,Model model,@ModelAttribute("scri")SearchCriteria scri) {
		log.info("get modify");
		model.addAttribute("board",service.detail(bno));
	}
	@PostMapping("/modify")
	public String modify(BoardVO board,RedirectAttributes rttr,@ModelAttribute("scri")SearchCriteria scri) {
		log.info("post modify.."+board);
		service.modify(board);
		
		rttr.addAttribute("bno", board.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:/board/detail";
		
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
