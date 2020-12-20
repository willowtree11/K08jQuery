package realtime;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import controller.OracleDAO;

@WebServlet("/RealtimeSearch.wow")
public class RealtimeSearch extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8;");
		
		
		String searchName = req.getParameter("searchName");
		
		OracleDAO dao = new OracleDAO();
		List<MemberDTO> members = dao.searchName(searchName);
		//System.out.println(dao.isMember("test1", "1234"));
		
		//String resultJSON = strJSON(searchName);
		//resp.getWriter().write(resultJSON);
	}
	
	public String strJSON(String searchName) {
		
		//JSON배열을 만들기 위한 선언
		JSONArray jsonArr = new JSONArray();
		
		OracleDAO dao = new OracleDAO();		
		
		//dao에서 회원정보 검색후 결과 반환
		List<MemberDTO> members = dao.searchName(searchName);
		
		for(MemberDTO m : members) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("id", m.getId());
			jsonObj.put("pass", m.getPass());
			jsonObj.put("name", m.getName());
			jsonObj.put("regidate", m.getRegidate());
			
			jsonArr.add(jsonObj);
		}
		
		dao.close();
		return jsonArr.toString();
	}
}
