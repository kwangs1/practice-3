package com.spring.community.Member.Service;

import com.spring.community.Member.VO.MemberVO;

public interface MemberService {
	//회원가입
	void join(MemberVO member);
	//id중복검사
	int IdCheck(String id);
	//닉네임 중복검사
	int NickCheck(String nickname);
	//로그인
	MemberVO login(MemberVO member);

}
