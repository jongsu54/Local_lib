package com.sbk.locallib.book.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.book.vo.BookVO;

@Repository
public class BookDAO {

	@Autowired
	private SqlSession session;

	public int bookInsert(BookVO book) {
		int cnt = 0;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			cnt = mapper.bookInsert(book);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public ArrayList<BookVO> getMyBooks(String userId) {
		ArrayList<BookVO> list = null;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			list = mapper.getMyBooks(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
