package com.sbk.locallib.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sbk.locallib.member.service.MemberService;
import com.sbk.locallib.member.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	
	@RequestMapping(value="/member/joinForm" , method = RequestMethod.GET)
	public String joinForm() {
		return "member/joinForm";
		
	}
		
	@RequestMapping(value="/member/loginForm" , method = RequestMethod.GET)
	public String loginForm() {
		return "member/loginForm";
	}
	
	@RequestMapping(value="/member/findUserinfo" , method = RequestMethod.GET)
	public String findUserinfo() {
		return "member/findUserinfo";
	}
	
	@RequestMapping(value="/member/login" , method = RequestMethod.POST)
	public String login(MemberVO member) {
		return service.login(member);
				
	}
	
	@RequestMapping(value="/member/logout" , method = RequestMethod.GET)
	public String logout() {
		return service.logout();
				
	}
	
	
	
}