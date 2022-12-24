package com.spring.community.Member.DAO;

import com.spring.community.Member.VO.MemberVO;

public interface MemberDAO {
	//회원가입
	void join(MemberVO member);
	//id 중복검사
	int IdCheck(String id);
	//닉네임 중복검사
	int NickCheck(String nickname);
	//로그인
	MemberVO login(MemberVO member);
	//회원탈퇴
	void remove(MemberVO member);
	void removeForm();
	//상세보기
	void info();
	//비밀번호 수정
	void PwModifyForm();
	void PwModify(MemberVO member);
	//정보 수정
	void modifyForm();
	void modify(MemberVO member);

}
