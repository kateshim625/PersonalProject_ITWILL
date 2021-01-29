package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CommentDAO {

	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	
	public int getCommentCount(int num) {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT count(*) from comment where num=?"; //방번호에 따른 모든 코멘트만 들고오기
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return count;
	}
		
	public List getCommentBoardList(int cstartRow, int cpageSize) {
		List commentList2 = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM comment order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cstartRow-1);
			pstmt.setInt(2, cpageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentBean cb = new CommentBean();
				
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setComment(rs.getString("comment"));
				cb.setReg_date(rs.getTimestamp("reg_date"));
				
				commentList2.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();} catch(SQLException ex) {}
		}
		return commentList2;
	}
	public List getCommentBoardList(int cstartRow, int cpageSize, int cnum) {
		List commentList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM comment where num=? order by reg_date desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cnum);
			pstmt.setInt(2, cstartRow-1);
			pstmt.setInt(3, cpageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentBean cb = new CommentBean();
				
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setComment(rs.getString("comment"));
				cb.setReg_date(rs.getTimestamp("reg_date"));
				cb.setIdx(rs.getInt("idx"));
				
				commentList.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();} catch(SQLException ex) {}
		}
		return commentList;
	}
	
	public CommentBean getComment(int bnum) { //게시글에 있는 넘버에대한댓긋 
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		CommentBean cb = new CommentBean();
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from comment where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				cb.setId(rs.getString("id"));
				cb.setNum(rs.getInt("num"));
				cb.setComment(rs.getString("comment"));
				cb.setReg_date(rs.getTimestamp("reg_date"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return cb;
	}

	public CommentBean getCommentIdx(int idx) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		CommentBean cb = new CommentBean();
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from comment where idx=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				cb.setId(rs.getString("id"));
				cb.setNum(rs.getInt("num"));
				cb.setComment(rs.getString("comment"));
				cb.setReg_date(rs.getTimestamp("reg_date"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return cb;
	}

	public void insertComment(CommentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			con = getConnection();
			//자동증가는 이부분필요없음

//			GalleryBoardBean gbb = new GalleryBoardBean();
//			int cnum = 1;
//			sql = "SELECT max(num) as mnum from comment";
//			pstmt = con.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//					
//			if(rs.next()) {
//				cnum = rs.getInt("mnum") + 1;
//			}
			sql = "INSERT INTO comment(num, id, reg_date, comment) values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cb.getNum());
			pstmt.setString(2, cb.getId());
			pstmt.setTimestamp(3, cb.getReg_date());
			pstmt.setString(4, cb.getComment());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
	}
	public int deleteComment(CommentBean cb) {
		int check = 1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "DELETE FROM comment where idx=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cb.getIdx());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}

		return check;
	}
	
	public void updateComment(CommentBean cb) {
		System.out.println(cb.getIdx());
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
//			
//			sql = "UPDATE comment set comment=?, reg_date=? where idx=?";
			sql = "UPDATE comment set comment=? where idx=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, cb.getComment());
//			pstmt.setTimestamp(2, cb.getReg_date());
			pstmt.setInt(2, cb.getIdx());

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
	}

}
