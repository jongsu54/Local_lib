package com.sbk.locallib.book.dao;

import java.util.ArrayList;

import com.sbk.locallib.book.vo.BookVO;

public interface BookMapper {
	
	public int bookInsert(BookVO book);

	public ArrayList<BookVO> getMyBooks(String userId);
}
