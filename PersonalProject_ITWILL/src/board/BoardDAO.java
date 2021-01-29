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

public class BoardDAO {

	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	public List getBoardList(int startRow, int pageSize) {
		List boardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM board order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setPass(rs.getString("pass"));
				bb.setNum(rs.getInt("num"));
				bb.setTitle(rs.getString("subject"));
				bb.setWriter(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadCount(rs.getInt("readCount"));
				boardList.add(bb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return boardList;
	}
	public List getBoardList(int startRow, int pageSize, String search) {
		List boardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM board  where subject like ? order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				
				bb.setContent(rs.getString("content"));
				bb.setPass(rs.getString("pass"));
				bb.setNum(rs.getInt("num"));
				bb.setTitle(rs.getString("subject"));
				bb.setWriter(rs.getString("name"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadCount(rs.getInt("readCount"));
				boardList.add(bb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return boardList;
	}

	public int getBoardCount() {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT count(*) from board";
			pstmt = con.prepareStatement(sql);
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
	public int getBoardCount(String search) {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
//			sql = "SELECT count(*) from board where subject like '%제목%'";
			sql = "SELECT count(*) from board where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");

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
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql  update
			sql="update board set readcount=readcount+1 where num=?";
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
	public BoardBean getBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		BoardBean bb=new BoardBean();
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4 rs <= 실행결과
			rs=pstmt.executeQuery();
			//5 rs 첫행이동 데이터 있으면 bb 에 멤버변수
			if(rs.next()) {
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setWriter(rs.getString("name"));
				bb.setNum(rs.getInt("num"));
				bb.setPass(rs.getString("pass"));
				bb.setReadCount(rs.getInt("readcount"));
				bb.setTitle(rs.getString("subject"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try { pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return bb;
	}
	public void insertBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			int num = 1;
			int readCount = 0;
			con = getConnection();
			//num이라느 게시판글 가져오는것 
			
			sql = "SELECT max(num) as mnum from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("mnum") + 1;
			}
			sql = "INSERT INTO board(name, pass, subject, content, num, readcount, date) values(?,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bb.getWriter());
			pstmt.setString(2, bb.getPass());
			pstmt.setString(3, bb.getTitle());
			pstmt.setString(4, bb.getContent());
			pstmt.setInt(5, num);
			pstmt.setInt(6, readCount);
			pstmt.setTimestamp(7, bb.getDate());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
	}
	public int updateBoard(BoardBean bb) {
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(bb.getPass().equals(rs.getString("pass"))){ //비밀번호는 안해줘도됨
					sql = "UPDATE board set name=?, subject=?, content=? where num=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, bb.getWriter());
					pstmt.setString(2, bb.getTitle());
					pstmt.setString(3, bb.getContent());
					pstmt.setInt(4, bb.getNum());
	
					pstmt.executeUpdate();
					
					check = 1;
				} else {
					check = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
		return check;
	}
	public int deleteBoard(BoardBean bb) {
		int check = 1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "DELETE FROM board where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getNum());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}

		return check;
	}
}
