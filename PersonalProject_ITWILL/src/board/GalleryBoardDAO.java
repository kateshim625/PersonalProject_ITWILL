package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GalleryBoardDAO {

	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	public List getGalleryBoardList(int startRow, int pageSize) {
		List galBoardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM gboard order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GalleryBoardBean gbb = new GalleryBoardBean();
				
				gbb.setContent(rs.getString("content"));
				gbb.setPass(rs.getString("pass"));
				gbb.setNum(rs.getInt("num"));
				gbb.setTitle(rs.getString("subject"));
				gbb.setWriter(rs.getString("name"));
				gbb.setDate(rs.getTimestamp("date"));
				gbb.setReadCount(rs.getInt("readCount"));
				gbb.setFile(rs.getString("file"));
				galBoardList.add(gbb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return galBoardList;
	}
	public List getGalleryBoardList(int startRow, int pageSize, String search) {
		List galBoardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM gboard  where subject like ? order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GalleryBoardBean gbb = new GalleryBoardBean();
				
				gbb.setContent(rs.getString("content"));
				gbb.setPass(rs.getString("pass"));
				gbb.setNum(rs.getInt("num"));
				gbb.setTitle(rs.getString("subject"));
				gbb.setWriter(rs.getString("name"));
				gbb.setDate(rs.getTimestamp("date"));
				gbb.setReadCount(rs.getInt("readCount"));
				gbb.setFile(rs.getString("file"));

				galBoardList.add(gbb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return galBoardList;
	}

	public int getGalleryBoardCount() {
		int gcount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT count(*) from gboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				gcount = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return gcount;
	}
	public int getGalleryBoardCount(String search) {
		int gcount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
//			sql = "SELECT count(*) from board where subject like '%제목%'";
			sql = "SELECT count(*) from gboard where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");

			rs = pstmt.executeQuery();
			if(rs.next()) {
				gcount = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return gcount;
	}
	public void updateGalleryReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql  update
			sql="update gboard set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
	}
	
	// getBoard(num)
	public GalleryBoardBean getGalleryBoard(int gnum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		GalleryBoardBean gbb=new GalleryBoardBean();
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from gboard where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				gbb.setContent(rs.getString("content"));
				gbb.setDate(rs.getTimestamp("date"));
				gbb.setWriter(rs.getString("name"));
				gbb.setNum(rs.getInt("num"));
				gbb.setPass(rs.getString("pass"));
				gbb.setReadCount(rs.getInt("readcount"));
				gbb.setTitle(rs.getString("subject"));
				gbb.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return gbb;
	}
	public void insertGalleryBoard(GalleryBoardBean gbb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			int gnum = 1;
			int greadCount = 0;
			con = getConnection();
			
			sql = "SELECT max(num) as mnum from gboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				gnum = rs.getInt("mnum") + 1;
			}
			sql = "INSERT INTO gboard(name, pass, subject, content, num, readcount, date, file) values(?,?,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, gbb.getWriter());
			pstmt.setString(2, gbb.getPass());
			pstmt.setString(3, gbb.getTitle());
			pstmt.setString(4, gbb.getContent());
			pstmt.setInt(5, gnum);
			pstmt.setInt(6, greadCount);
			pstmt.setTimestamp(7, gbb.getDate());
			pstmt.setString(8, gbb.getFile());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
	}
	public int updateGalleryBoard(GalleryBoardBean gbb) {
		int gcheck = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "select * from gboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gbb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(gbb.getPass().equals(rs.getString("pass"))){//비밀번호는 안해줘도됨
					sql = "UPDATE gboard set name=?, subject=?, content=?, file=? where num=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, gbb.getWriter());
					pstmt.setString(2, gbb.getTitle());
					pstmt.setString(3, gbb.getContent());
					pstmt.setString(4, gbb.getFile());
					pstmt.setInt(5, gbb.getNum());
	
					pstmt.executeUpdate();
					
					gcheck = 1;
				} else {
					gcheck = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return gcheck;
	}
	public int deleteGalleryBoard(GalleryBoardBean gbb) {
		int gcheck = 1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "DELETE FROM gboard where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, gbb.getNum());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}

		return gcheck;
	}
}
