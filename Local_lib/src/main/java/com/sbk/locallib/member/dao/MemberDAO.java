package com.sbk.locallib.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.member.vo.MemberVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession session ;
	
	
	public MemberVO searchMember(String user_id) {
		MemberVO member = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.searchMember(user_id);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
	
	
}
