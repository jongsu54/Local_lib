package com.sbk.locallib.book.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbk.locallib.book.vo.BookVO;

@Controller
public class BookController {
	
	//bookAdd로 이동
	@RequestMapping(value="/book/bookAdd" , method = RequestMethod.GET)
	public String myInfo() {
		return "book/bookAdd";
	}
	
	// 리턴할 때 한글로 인코딩 해서 보여주는 거: produces =
	@ResponseBody
	@RequestMapping(value = "/naverBookSearch", method = RequestMethod.GET, produces = "application/text;charset=UTF-8")
	public String naverSearch(String keyword, BookVO book) {
		String clientId = "lLhpxGB8vpFt8ZUpZsDO"; // 애플리케이션 클라이언트 아이디값"
		String clientSecret = "1paRu2jdsA"; // 애플리케이션 클라이언트 시크릿값"
		
		System.out.println(keyword + book);
		
		
		String text = "";
		String title = "", author = "", isbn = "", publisher = "";
		
		try {
			if(keyword!=null)
				text = URLEncoder.encode(keyword, "UTF-8");
			if(book.getTitle()!=null)
				title = URLEncoder.encode(book.getTitle(), "UTF-8");
			if(book.getAuthor()!=null)
				author = URLEncoder.encode(book.getAuthor(), "UTF-8");
			if(book.getIsbn()!=null)
				isbn = URLEncoder.encode(book.getIsbn(), "UTF-8");
			if(book.getPublisher()!=null)
				publisher = URLEncoder.encode(book.getPublisher(), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("검색어 인코딩 실패", e);
		}

//		<option value="d_titl">제목</option>
//		<option value="d_auth">저자</option>
//		<option value="d_isbn">isbn</option>
//		<option value="d_publ">출판사</option>
		
		String apiURL = null;
		
		if(keyword!=null) {
			apiURL = "https://openapi.naver.com/v1/search/book?query=" + text; // json 결과
		} else {
			apiURL = "https://openapi.naver.com/v1/search/book_adv?"
					+ "d_titl=" + title + "&d_auth=" + author +"&d_isbn=" + isbn +"&d_publ=" + publisher; // json 결과
		}
		//https://book.naver.com/search/search.nhn?publishStartDay=&publishEndDay=&categoryId=&serviceSm=advbook.basic&ic=service.summary&title=&author=%EC%A0%95%EC%8A%B9%ED%98%84&publisher=&isbn=&toc=&subject=&cate1Depth=&cate2Depth=&cate3Depth=&cate4Depth=&publishStartYear=&publishStartMonth=&publishEndYear=&publishEndMonth=&x=26&y=15
		
		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = get(apiURL, requestHeaders);

		System.out.println(responseBody);

		return responseBody;
	}

	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 에러 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}

	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}

			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}

}
