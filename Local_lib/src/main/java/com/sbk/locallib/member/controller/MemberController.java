package com.sbk.locallib.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberController {
	
	
	@RequestMapping(value="/member/joinForm" , method = RequestMethod.GET)
	public String joinForm() {
		return "member/joinForm";
		
	}
		
	@RequestMapping(value="/member/loginForm" , method = RequestMethod.GET)
	public String loginForm() {
		return "member/loginForm";
	}
	
	
	
}