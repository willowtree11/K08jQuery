package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ZipcodeDAO {
	
	Connection con; //커넥션 객체를 멤버변수로 설정하여 공유
	PreparedStatement psmt;
	ResultSet rs;
	
	public ZipcodeDAO() {
		try {
			Context ctx = new InitialContext();
			
			DataSource source = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			con = source.getConnection();
			System.out.println("DBCP연결성공");
		}
		catch(Exception e) {
			System.out.println("DBCP연결실패");
			e.printStackTrace();
		}		
	}
	
	public void close() {
		try {
			//연결을 해제하는 것이 아니라 커넥션풀에 다시 반납한다.
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
			e.printStackTrace();
		}
	}
	
	public ArrayList<String> getSido(){
		ArrayList<String> sidoAddr=new ArrayList<String>();
		
		String sql= "SELECT DISTINCT sido FROM zipcode "
				+ " WHERE 1=1"				
				+ " ORDER BY sido ASC";
		/*
		String sql= "SELECT sido FROM zipcode "
				+ " WHERE 1=1"				
				+ " GROUP BY sido "
				+ " ORDER BY sido ASC";
		*/
				
		try {
			//쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				sidoAddr.add(rs.getString(1));
			}
		}
		catch(Exception e) {}
		
		return sidoAddr;
	}
	
	public ArrayList<String> getGugun(String sido){
		ArrayList<String> gugunAddr=new ArrayList<String>();
		
		String sql= "SELECT DISTINCT gugun FROM zipcode "
				+ " WHERE sido=?"				
				+ " ORDER BY gugun DESC";
		
		try {
			//쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(sql);
			psmt.setString(1, sido);
			rs = psmt.executeQuery();
			while(rs.next()) {
				gugunAddr.add(rs.getString(1));
			}
		}
		catch(Exception e) {e.printStackTrace();}
		
		return gugunAddr;
	}
}
