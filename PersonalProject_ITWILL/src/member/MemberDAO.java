package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	public Connection getConnection() throws Exception  {
		
		Connection con = null;
		Context init = new InitialContext(); //부모Context인터페이스의 자식InitialContext클래스
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		
		con = ds.getConnection();
		
		return con;
	}//getConnection

	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getConnection();
																															//1번째 값을 수동으로해도되지만 
			String sql = "insert into member(id, pass, name, email, address, city, Country, zip, phone, mobile, reg_date) values(?,?,?,?,?,?,?,?,?,?,?)";
			ps = con.prepareStatement(sql);
			//ps의 함수 sql구문을 만들고 실해할수있는 객체를 실행하는거 
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getPass());
			ps.setString(3, mb.getName());
			ps.setString(4, mb.getEmail());
			ps.setString(5, mb.getAddress());
			ps.setString(6, mb.getCity());
			ps.setString(7, mb.getCountry());
			ps.setString(8, mb.getZip());
			ps.setString(9, mb.getPhone());
			ps.setString(10, mb.getMobile());
			ps.setTimestamp(11, mb.getReg_date());
			//pass2,email2는 같은값 2번 입력해줄필요없고 확인용임
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(ps!=null) try {ps.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();} catch(SQLException ex) {}
		}
	}//insertMember
	
	public int userCheck(String id, String pass) {
		int check = -1; //여기 -1일 들어가는이유 ? 0이나 -1주고 아이디자체가없고 1은무조건권한부여가되서
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con=getConnection();
			
			String sql = "select * from member where id = ?";
			ps = con.prepareStatement(sql); //문자열이 쿼리가됨 들어가면 쿼리구문이되고  
			ps.setString(1, id); // ddd를 넣은걸 찾는거 밑으로 찾아가다가 찾으면 행다 가져오는거 /쿼리구문의 값을넣고 
			rs = ps.executeQuery(); //여기 쿼리에 무슨값이 들어가나 ? 실행 엔터한거 결과는 rs 실행하는거 
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					check=1;
				}else {
					check=0;
				}
			}else {
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(ps!=null) try { ps.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		
		return check;
	}//userCheck
	public int idCheck(String id) {
		int check = -1;
		Connection con = null;
		PreparedStatement ps= null;
		ResultSet rs= null;
		
		try {
			con = getConnection();
			String sql = "Select id from member where id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				check=1;
			}else {
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(ps!=null) try { ps.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();} catch(SQLException ex) {}
		}
		return check;
	} //idCheck
	
	public MemberBean getMember(String id) {
		MemberBean mb = new MemberBean();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = " select * from member where id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()){
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setCity(rs.getString("city"));
				mb.setCountry(rs.getString("country"));
				mb.setZip(rs.getString("zip"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(ps!=null) try { ps.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();}catch(SQLException ex) {}
		}
		return mb;
	}
	public void updateMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con=getConnection();
			String sql = "update member set name=?, email=?, address=?, city=?, country=?, zip=?, phone=?, mobile=? where id=?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, mb.getName());
			ps.setString(2, mb.getEmail());
			ps.setString(3, mb.getAddress());
			ps.setString(4, mb.getCity());
			ps.setString(5, mb.getCountry());
			ps.setString(6, mb.getZip());
			ps.setString(7, mb.getPhone());
			ps.setString(8, mb.getMobile());
			ps.setString(9, mb.getId());
		
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(ps!=null) try {ps.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}
		}
	}//updateMember
	public void daleteMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "DELETE FROM member where id=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mb.getId());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {con.close();} catch(SQLException ex) {}
		}
		
	}//deleteMember
}
