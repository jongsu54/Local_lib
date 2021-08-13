package com.sbk.locallib.book.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.book.dao.BookDAO;
import com.sbk.locallib.book.vo.BookVO;

@Service
public class BookService {

	@Autowired
	private BookDAO dao;
	
//	@Autowired
//	private HttpSession session;
	
	public boolean bookInsert(BookVO book) {
		boolean chk = false;
		//kdc와 사용자 정보 반영 필요
//		book.setKdc(0);
//		session으로 부터 로그인한 사용자 정보 받아와 입력
		book.setOwner_id("kkk3123");
		int cnt = dao.bookInsert(book);
		
		if(cnt>0) {
//			성공시 myInfo로
//			path = "redirect:/member/myInfo";
			chk = true;
		} else {
//			실패시 화면 그대로
//			path = "redirect:/book/bookAdd";
			chk = false;
		}
		return chk;
	}
	
}
