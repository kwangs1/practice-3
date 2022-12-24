package com.spring.community.Member.DAO;

import java.util.logging.Logger;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.community.Member.VO.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{
	private static Logger log = Logger.getLogger(MemberDAO.class.getName());

	@Autowired
	private SqlSession session;
	
	//회원가입
	@Override
	public void join(MemberVO member) {
		session.insert("mapper.member.join",member);
	}
	
	//id중복검사
	@Override
	public int IdCheck(String id) {
		return session.selectOne("mapper.member.IdCheck",id);
	}
	
	//닉네임중복검사
	@Override
	public int NickCheck(String nickname) {
		return session.selectOne("mapper.member.NickCheck",nickname);
	}
	
	//로그인
	@Override
	public MemberVO login(MemberVO member) {
		return session.selectOne("mapper.member.login",member);
	}
	
	//회원탈퇴
	@Override
	public void remove(MemberVO member) {
		log.info("회원탈퇴 화면 진입P");
		 session.delete("mapper.member.remove",member);
	}
	@Override
	public void removeForm() {
		session.selectOne("mapper.member.removeForm");
	}
	
	//상세보기
	@Override
	public void info() {
		session.selectOne("mapper.member.info");
	}
	
	//비밀번호 수정
	@Override
	public void PwModifyForm() {
		session.selectOne("mapper.member.PwModifyForm");
	}
	@Override
	public void PwModify(MemberVO member) {
		session.update("mapper.member.PwModify",member);
	}
	
	//정보 수정
	@Override
	public void modifyForm() {
		session.selectOne("mapper.member.modifyForm");
	}
	@Override
	public void modify(MemberVO member) {
		session.update("mapper.member.modify",member);
	}
}
