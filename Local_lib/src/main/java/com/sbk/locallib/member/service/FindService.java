package com.sbk.locallib.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.member.dao.FindDAO;
import com.sbk.locallib.member.vo.MemberVO;

@Service
public class FindService {

	@Autowired
	private FindDAO dao;
	//이름확인
	public boolean nameCheck(String name) {
		boolean flag = false;
		
		MemberVO member = dao.nameCheck(name);
		
		if(member != null) {
			flag = true;
		}
		return flag;
	}
}
