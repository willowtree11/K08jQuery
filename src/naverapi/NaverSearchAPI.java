package naverapi;

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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NaverSearchAPI extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String clientId = "id"; //애플리케이션 클라이언트 아이디값" 네이버 개발자도구에서 로그인 후 확인
        String clientSecret = "secret"; //애플리케이션 클라이언트 시크릿값" 네이버 개발자도구에서 로그인 후 확인

        String text = null;
        int startNum = 0;  //지역변수로 선언하면 apiURL에서 사용할 수 없으므로 바깥에 선언      
        try {
        	//JSP에서 입력한 검색어를 파라미터로 받아서 변수처리
        	String searchTxt=req.getParameter("keyword");
        	startNum=Integer.parseInt(req.getParameter("startNum")); //추가함, 
            
        	text = URLEncoder.encode(searchTxt, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }        
        
        String apiURL = "https://openapi.naver.com/v1/search/blog?query=" + text 
        		+ "&display=20&start="+startNum;    // json 결과, ["&display=20&start=값"+startNum]추가함 'start'는 Naver Developer에서 지정한 이름임
        
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);
        
        //네이버 검색 API실행 시의 결과값을 로그로 출력
        System.out.println(responseBody);
        
        //네이버의 검색결과를 JSON으로 내려받아 서블릿에서 즉시 화면에 출력한다
        resp.setContentType("text/html; charset=utf-8");
        resp.getWriter().write(responseBody);
	}
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
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

    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private static String readBody(InputStream body){
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
