package com.spring.community.Member.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.community.Member.DAO.MemberDAO;
import com.spring.community.Member.VO.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	private static Logger log = Logger.getLogger(MemberService.class.getName());

	@Autowired
	private MemberDAO dao;
	
	//회원가입
	@Override
	public void join(MemberVO member) {
		dao.join(member);
	}	
	
	//id 중복검사
	@Override
	public int IdCheck(String id) {
		return dao.IdCheck(id);
	}	
	
	//닉네임 중복
	@Override
	public int NickCheck(String nickname) {
		return dao.NickCheck(nickname);
	}	
	
	//로그인
	@Override
	public MemberVO login(MemberVO member) {
		return dao.login(member);
	}	
	
	//회원탈퇴
	@Override
	public void remove(MemberVO member) {
		log.info("회원탈퇴 화면 진입P");
		 dao.remove(member);
	}
	@Override
	public void removeForm() {
		dao.removeForm();
	}
	
	//상세보기
	@Override
	public void info() {
		dao.info();
	}
	
	//비밀번호 수정
	@Override
	public void PwModifyForm() {
		dao.PwModifyForm();
	}
	@Override
	public void PwModify(MemberVO member) {
		dao.PwModify(member);
	}
	
	//정보 수정
	@Override
	public void modifyForm() {
		dao.modifyForm();
	}
	@Override
	public void modify(MemberVO member) {
		dao.modify(member);
	}
	
	//이메일 수정
	@Override
	public void EmailModifyForm() {
		dao.EmailModifyForm();
	}
	@Override
	public void EmailModify(MemberVO member) {
		dao.EmailModify(member);
	}
	
	//id 찾기
	@Override
	public String idSearch(String nickname, String email) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("nickname", nickname);
		map.put("email", email);
		
		log.info("nick.S.."+nickname);
		log.info("email.S.."+email);
		
		return dao.idSearch(map);

	}
	
	//pw 찾기
	@Override
	public String pwSearch(String id, String email) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("email", email);
		
		log.info("id.S.."+id);
		log.info("email.S.."+email);
		
		return dao.pwSearch(map);

	}
	
}
