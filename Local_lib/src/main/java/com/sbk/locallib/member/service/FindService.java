package com.sbk.locallib.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.member.dao.FindDAO;
import com.sbk.locallib.member.vo.MemberVO;

@Service
public class FindService {

	@Autowired
	private FindDAO dao;
	@Autowired
	private HttpSession session;
	
	//아이디 & 이메일 확인
	public MemberVO userCheck(MemberVO member) {
		MemberVO user = null;
		user = dao.searchMember(member);
		
		if(user == null) {
			System.out.println("회원정보가 없음");
			
		}
		return user;
	}
	
//	public String userCheck(MemberVO member) {
//		String path = "";
//		MemberVO memberInfo = dao.searchMember(member);
//		if(memberInfo == null) {
//			System.out.println("회원정보 없음");
//			path = "redirect:/member/findUserinfo";
//		}else {
//			path = "redirect:/";
//		}
//		return path;
//	}
	
	
//	//아이디 찾기
//	public String userCheck(MemberVO inputData) {
//		String path = "";
//		MemberVO searchData = dao.searchMember(inputData.getName());
//		
//		if(searchData == null) {
//			System.out.println("ID없음");
//			path = "redirect:/member/findUserinfo";
//		}else {
//			session.setAttribute("name", searchData.getName());
//			session.setAttribute("user_id", searchData.getUser_id());
//			path = "redirect:/member/findId";
//		}
//		return path;
//	}
	
	
}
