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

public class EventBoardDAO {

	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	public List getEventBoardList(int startRow, int pageSize) {
		List eBoardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM eboard order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventBoardBean ebb = new EventBoardBean();
				
				ebb.setContent(rs.getString("content"));
				ebb.setPass(rs.getString("pass"));
				ebb.setNum(rs.getInt("num"));
				ebb.setTitle(rs.getString("subject"));
				ebb.setWriter(rs.getString("name"));
				ebb.setDate(rs.getTimestamp("date"));
				ebb.setReadCount(rs.getInt("readCount"));
				ebb.setFile(rs.getString("file"));
				eBoardList.add(ebb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return eBoardList;
	}
	public List getEventBoardList(int startRow, int pageSize, String search) {
		List galBoardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM eboard  where subject like ? order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventBoardBean ebb = new EventBoardBean();
				
				ebb.setContent(rs.getString("content"));
				ebb.setPass(rs.getString("pass"));
				ebb.setNum(rs.getInt("num"));
				ebb.setTitle(rs.getString("subject"));
				ebb.setWriter(rs.getString("name"));
				ebb.setDate(rs.getTimestamp("date"));
				ebb.setReadCount(rs.getInt("readCount"));
				ebb.setFile(rs.getString("file"));

				galBoardList.add(ebb);
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

	public int getEventBoardCount() {
		int ecount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT count(*) from eboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ecount = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return ecount;
	}
	public int getEventBoardCount(String search) {
		int ecount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
//			sql = "SELECT count(*) from board where subject like '%제목%'";
			sql = "SELECT count(*) from eboard where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");

			rs = pstmt.executeQuery();
			if(rs.next()) {
				ecount = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return ecount;
	}
	public void updateEventReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql  update
			sql="update eboard set readcount=readcount+1 where num=?";
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
	public EventBoardBean getEventBoard(int gnum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		EventBoardBean ebb=new EventBoardBean();
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from eboard where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				ebb.setContent(rs.getString("content"));
				ebb.setDate(rs.getTimestamp("date"));
				ebb.setWriter(rs.getString("name"));
				ebb.setNum(rs.getInt("num"));
				ebb.setPass(rs.getString("pass"));
				ebb.setReadCount(rs.getInt("readcount"));
				ebb.setTitle(rs.getString("subject"));
				ebb.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return ebb;
	}
	public void insertEventBoard(EventBoardBean ebb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			int gnum = 1;
			int greadCount = 0;
			con = getConnection();
			
			sql = "SELECT max(num) as mnum from eboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				gnum = rs.getInt("mnum") + 1;
			}
			sql = "INSERT INTO eboard(name, pass, subject, content, num, readcount, date, file) values(?,?,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, ebb.getWriter());
			pstmt.setString(2, ebb.getPass());
			pstmt.setString(3, ebb.getTitle());
			pstmt.setString(4, ebb.getContent());
			pstmt.setInt(5, gnum);
			pstmt.setInt(6, greadCount);
			pstmt.setTimestamp(7, ebb.getDate());
			pstmt.setString(8, ebb.getFile());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
	}
	public int updateEventBoard(EventBoardBean ebb) {
		int echeck = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "select * from eboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ebb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(ebb.getPass().equals(rs.getString("pass"))){//비밀번호는 안해줘도됨
					sql = "UPDATE eboard set name=?, subject=?, content=?, file=? where num=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, ebb.getWriter());
					pstmt.setString(2, ebb.getTitle());
					pstmt.setString(3, ebb.getContent());
					pstmt.setString(4, ebb.getFile());
					pstmt.setInt(5, ebb.getNum());
	
					pstmt.executeUpdate();
					
					echeck = 1;
				} else {
					echeck = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return echeck;
	}
	public int deleteEventBoard(EventBoardBean ebb) {
		int echeck = 1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "DELETE FROM eboard where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, ebb.getNum());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}

		return echeck;
	}
}
