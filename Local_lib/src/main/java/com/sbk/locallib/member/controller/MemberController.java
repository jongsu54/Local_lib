package com.sbk.locallib.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbk.locallib.member.service.FindService;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	private FindService service;
	
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
	
	//이름확인
	@ResponseBody
	@RequestMapping(value = "nameCheck", method = RequestMethod.POST)
	public boolean nameCheck(String name) {
		return service.nameCheck(name);
	}
	
	
}