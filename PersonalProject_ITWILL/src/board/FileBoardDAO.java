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

public class FileBoardDAO {

	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	public List getFileBoardList(int startRow, int pageSize) {
		List boardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM fboard order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FileBoardBean bb = new FileBoardBean();
				
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
	public List getFileBoardList(int startRow, int pageSize, String search) {
		List boardList = new ArrayList();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT * FROM fboard  where subject like ? order by num desc limit ?,?;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FileBoardBean bb = new FileBoardBean();
				
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

	public int getFileBoardCount() {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "SELECT count(*) from fboard";
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
	public int getFileBoardCount(String search) {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
//			sql = "SELECT count(*) from board where subject like '%제목%'";
			sql = "SELECT count(*) from fboard where subject like ?";
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
	public void updateFileReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql  update
			sql="update fboard set readcount=readcount+1 where num=?";
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
	public FileBoardBean getFileBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="";
		FileBoardBean bb=new FileBoardBean();
		try {
			//1,2 디비연결
			con=getConnection();
			//3 sql num에 해당하는 게시판 글 정보 가져오기
			sql="select * from fboard where num=?";
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
				bb.setFile(rs.getString("file"));
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
	public void insertFileBoard(FileBoardBean fbb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			int num = 1;
			int readCount = 0;
			con = getConnection();
			
			sql = "SELECT max(num) as mnum from fboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("mnum") + 1;
			}
			sql = "INSERT INTO fboard(name, pass, subject, content, num, readcount, date, file) values(?,?,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, fbb.getWriter());
			pstmt.setString(2, fbb.getPass());
			pstmt.setString(3, fbb.getTitle());
			pstmt.setString(4, fbb.getContent());
			pstmt.setInt(5, num);
			pstmt.setInt(6, readCount);
			pstmt.setTimestamp(7, fbb.getDate());
			pstmt.setString(8, fbb.getFile());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
	}
	public int updateFileBoard(FileBoardBean fbb) {
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "select * from fboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fbb.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(fbb.getPass().equals(rs.getString("pass"))){//비밀번호는 안해줘도됨
					sql = "UPDATE fboard set name=?, subject=?, content=?, file=? where num=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, fbb.getWriter());
					pstmt.setString(2, fbb.getTitle());
					pstmt.setString(3, fbb.getContent());
					pstmt.setString(4, fbb.getFile());
					pstmt.setInt(5, fbb.getNum());
	
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
	public int deleteFileBoard(FileBoardBean fbb) {
		int check = 1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "DELETE FROM fboard where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, fbb.getNum());
			
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
