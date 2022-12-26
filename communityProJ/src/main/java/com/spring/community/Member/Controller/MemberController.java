package com.spring.community.Member.Controller;

import java.util.Random;
import java.util.logging.Logger;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.community.Member.Service.MemberService;
import com.spring.community.Member.VO.MemberVO;

@Controller
@RequestMapping(value="/member")
public class MemberController {
	private static Logger log = Logger.getLogger(MemberController.class.getName());
	
	@Autowired
	private MemberService service;
	@Autowired
	private JavaMailSender mailSender;
	
	//회원가입
	@GetMapping("/join")
	public void join() {
		log.info("회원가입 페이지");
	}
	@PostMapping("/join")
	public String join(Model model,MemberVO member) {
		log.info("회원가입 post");
		service.join(member);
		
		return "redirect:/member/login";
	}
	
	//id중복검사
	@PostMapping("/IdCheck")
	@ResponseBody
	public String IdCheck(String id) {
		log.info("idCheck...." + id);
		
		int result = service.IdCheck(id);
		
		if(result != 0 ) {
			return "fail";
		}else{
			return "success";
		}
	}
	//닉네임 중복검사
	@PostMapping("/NickCheck")
	@ResponseBody
	public String NickCheck(String nickname) {
		log.info("NicknameCheck.."+nickname);
		
		int result = service.NickCheck(nickname);
		
		if(result != 0 ) {
			return "fail";
		}else {
			return "success";
		}
	}
	
	//이메일 인증
	@PostMapping("/MailCheck")
	@ResponseBody
	public String MailCheck(String email) {
		log.info("이메일 인증번호 발송");
		
		//인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(88888)+11111;
		log.info("인증 번호 발행:"+checkNum);
		
		//이메일 html
		//xml 등록된 계정
		String setFrom = "cckwang2345@naver.com";
		//수신받을 이메일
		String toMail = email;
		//메일 제목
		String title = "시끌벅적 커뮤니티 이메일 인증";
		//메일 내용
		String content = "사용자가 본인임을 확인하는 확인 코드를 입력하세요."
				+"<br><br>"
				+"인증번호는" + checkNum + "입니다";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		String num = Integer.toString(checkNum);
		return num;
	}
	
	//로그인
	@GetMapping("/login")
	public void login() {
		
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberVO member, 
			RedirectAttributes rttr, HttpServletRequest request) {
		
		HttpSession http = request.getSession();
		MemberVO vo = service.login(member);
		
		//존재하는 id일경우
		if(vo != null) {
			http.setAttribute("member", vo);
			return "redirect:/board/lists";
		}else {
			//존재하지 않을경우
			rttr.addFlashAttribute("result",0);
			return "redirect:/member/login";
		}
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession http  = request.getSession();
		http.invalidate();
		
		return "redirect:/board/lists";
	}
	
	//회원탈퇴
	@GetMapping("/remove")
	public void remove() {
		log.info("회원탈퇴 화면 진입");
		service.removeForm();
	}
	@PostMapping("/remove")
	public String remove(MemberVO member, HttpServletRequest request) {
		log.info("회원탈퇴 화면 진입P");
		HttpSession http = request.getSession();
		http.invalidate();
		
		service.remove(member);
		
		return "redirect:/board/lists";
	}
	
	//상세보기
	@GetMapping("/info")
	public void info() {
		service.info();
	}
	
	//비번수정
	@GetMapping("/PwModify")
	public void PwModify() {
		service.PwModifyForm();
	}
	@PostMapping("/PwModify")
	public String PwModify(MemberVO member,HttpServletRequest request) {
		HttpSession http = request.getSession();
		http.setAttribute("member", member);
		
		http.invalidate();
		
		service.PwModify(member);
		
		return "redirect:/member/login";
	}
	
	//정보수정
	@GetMapping("/modify")
	public void modify() {
		service.modifyForm();
	}
	@PostMapping("/modify")
	public String modify(MemberVO member,HttpServletRequest request) {
		HttpSession http = request.getSession();
		http.setAttribute("member", member);
		
		
		service.modify(member);
		
		return "redirect:/member/info";
	}
	
	//이메일 수정
	@GetMapping("/EmailModify")
	public void EmailModify() {
		service.EmailModifyForm();
	}
	@PostMapping("/EmailModify")
	public String EmailModify(MemberVO member,HttpServletRequest request) {
		HttpSession http = request.getSession();
		http.setAttribute("member", member);
		
		
		service.EmailModify(member);
		
		return "redirect:/member/info";
	}
	
	//id 찾기
	@GetMapping("/idSearch")
	public void idSearch() {
		
	}
	@PostMapping("/idSearch")
	@ResponseBody
	public String idSearch(String nickname, String email, Model model) {	
		log.info("nick..."+nickname);
		log.info("email..."+email);
		
		String result = service.idSearch(nickname,email);
		
		return result;
	}
	
	//pw 찾기
	@GetMapping("/pwSearch")
	public void pwSearch() {
		
	}
	@PostMapping("/pwSearch")
	@ResponseBody
	public String pwSearch(String id, String email, Model model) {	
		log.info("nick..."+id);
		log.info("email..."+email);
		
		String result = service.pwSearch(id,email);
		
		return result;
	}
}
