package com.sbk.locallib.book.vo;

import lombok.Data;

@Data
public class BookVO {

	private String book_id;
	private String book_name;	
	private String author;
	private String publisher;
	private String isbn;
	private String kdc;
	private String date;
	private String owner_id;
	private String state_gb;
}
