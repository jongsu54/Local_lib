package com.sbk.locallib.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.member.vo.MemberVO;

@Repository
public class FindDAO {
	@Autowired
	private SqlSession session;
	
	//이름확인
	public MemberVO nameCheck(String name) {
		MemberVO member = null;
		
		try {
			FindMapper mapper = session.getMapper(FindMapper.class);
			member = mapper.nameCheck(name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
}
