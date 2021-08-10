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
	
	public String bookInsert(BookVO book) {
		String path = "";
		int cnt = dao.bookInsert(book);
		
		if(cnt>0) {
			// 성공시 myInfo로
			path = "redirect:/member/myInfo";
		} else {
			// 실패시 화면 그대로
			path = "redirect:/book/bookAdd";
		}
		return path;
	}
	
}
