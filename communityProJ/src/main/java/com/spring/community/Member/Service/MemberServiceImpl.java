package com.spring.community.Member.Service;

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
}
