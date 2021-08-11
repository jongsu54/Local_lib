package com.sbk.locallib.member.dao;

import com.sbk.locallib.member.vo.MemberVO;

public interface FindMapper {

	//아이디 & 이메일 확인
	public MemberVO searchMember(MemberVO member);
	
}
