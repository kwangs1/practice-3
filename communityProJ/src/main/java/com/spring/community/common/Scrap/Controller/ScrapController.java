package com.spring.community.common.Scrap.Controller;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.community.Member.VO.MemberVO;
import com.spring.community.common.Criteria;
import com.spring.community.common.PageMaker;
import com.spring.community.common.Scrap.Service.ScrapService;
import com.spring.community.common.Scrap.VO.ScrapVO;

@Controller
@RequestMapping("/Scrap")
public class ScrapController {
	private static Logger log = Logger.getLogger(ScrapController.class.getName());

	@Autowired
	private ScrapService service;

	//스크랩 리스트
	@GetMapping("/ScrapList")
	public void ScrapList(HttpServletRequest request,ScrapVO scrap,Criteria cri,Model model) {
		HttpSession session = request.getSession();
		
		//id에 대한 정보 가져옴
		MemberVO member = (MemberVO)session.getAttribute("member");
		String id = member.getId();
		scrap.setId(id);
		cri.setId(id);
		
		//스크랩 한 게시글을 Map에 담음.
		Map<String,List>map = service.ScrapList(scrap,cri);
		session.setAttribute("scrap", map);
		
		//페이징 버튼을 위해 객체 선언(전체)
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);	
		//총 게시글 갯수
		pageMaker.setTotalCount(service.getScrapTotal(cri.getId()));
		log.info("cri.getId()"+cri.getId());
		model.addAttribute("pageMaker",pageMaker);
	}
	
	//스크랩 추가 및 확인
	@PostMapping("/addScrap")
	@ResponseBody
	public String addScrap(int bno, HttpServletRequest request, ScrapVO scrap) {
		HttpSession session = request.getSession();
		
		//id에 대한 정보 가져옴
		MemberVO member = (MemberVO)session.getAttribute("member");
		String id = member.getId();
		scrap.setId(id);
		//게시글 번호 셋팅
		scrap.setBno(bno);
		
		//해당 게시글을 스크랩 하였는지?
		boolean ScrapCheck = service.findScrap(scrap);
		log.info("게시물을 체크 하였던건가요?..."+ScrapCheck);
		
		if(ScrapCheck == true) {
			return "fail";
		}else {
			service.addScrap(scrap);
			return "success";
		}
		
	}
	
	//스크랩 삭제
	@PostMapping("/removeScrap")
	public String removeScrap(int sno) {
		log.info("삭제가 먹힘??."+sno);
		service.removeScrap(sno);
		
		return "redirect:/Scrap/ScrapList";
	}
	
}
