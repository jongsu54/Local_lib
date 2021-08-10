package com.sbk.locallib.member.dao;

import com.sbk.locallib.member.vo.MemberVO;

public interface FindMapper {

	//이름확인
	public MemberVO nameCheck(String name);
	
}
