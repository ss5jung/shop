package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.CartDAO;
import repository.DBUtil;
import vo.Cart;

public class CartService {
	private DBUtil dbUtil;
	private CartDAO cartDAO;

	// 장바구니에 들어있는 상품의 수
	public int getCartGoodsCnt(String customerId) {
		int cnt = 0;
		dbUtil = new DBUtil();
		cartDAO = new CartDAO();
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			System.out.println("getCartGoodsCnt DB 연결 성공");
			// cartDAO call
			cnt = cartDAO.selectCartGoodsCnt(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return cnt;
	}

	// C 장바구니 추가
	public int addCart(Cart cart) {
		// 리턴값
		int row = 0;
		dbUtil = new DBUtil();
		cartDAO = new CartDAO();
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			System.out.println("addCart DB 연결 성공");
			// 개별 커밋 해제
			conn.setAutoCommit(false);
			// DAO call
			// 동일한 상품을 장바구니에 담은 적이 있는지 확인
			int cnt = cartDAO.selectGoodsInCartCk(conn, cart);
			if (cnt != 0) { // 장바구니에 이미 상품이 있는 경우
				// 수량 알아오기
				int qty = cartDAO.selectGoodsCntInCart(conn, cart);
				int newQty = cart.getCartQuantity() + qty;
				cart.setCartQuantity(newQty);
				row = cartDAO.updateCart(conn, cart);
			} else { // 장바구니에 상품이 없을 경우
				row = cartDAO.insertCart(conn, cart);
			}
			if (row != 0) {
				System.out.println("장바구니 추가 성공");
			} else {
				System.out.println("장바구니 추가 실패");
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// R 장바구니 리스트
	public List<Map<String, Object>> getCartList(String customerId) {
		// 리턴값
		List<Map<String, Object>> list = null;
		dbUtil = new DBUtil();
		cartDAO = new CartDAO();
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			System.out.println("getCartList DB 연결 성공");
			// cartDAO call
			list = cartDAO.selectCartList(conn, customerId);
			System.out.println(list + "list");
			if (list != null) {
				System.out.println("장바구니 추가 성공");
			} else {
				System.out.println("장바구니 추가 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

	// U 장바구니 수량 수정
	public int modifyCart(Cart cart) {
		// 리턴값
		int row = 0;
		dbUtil = new DBUtil();
		cartDAO = new CartDAO();
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			System.out.println("modifyCart DB 연결 성공");
			// DAO call
			row = cartDAO.updateCart(conn, cart);
			if (row != 0) {
				System.out.println("장바구니 수정 성공");
			} else {
				System.out.println("장바구니 수정 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}

	// D 장바구니 삭제
	public int removeCart(Cart cart) {
		// 리턴값
		int row = 0;
		dbUtil = new DBUtil();
		cartDAO = new CartDAO();
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			System.out.println("removeCart DB 연결 성공");
			// DAO call
			row = cartDAO.deleteCart(conn, cart);
			if (row != 0) {
				System.out.println("장바구니 삭제 성공");
			} else {
				System.out.println("장바구니 삭제 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return row;
	}
}
