package service;

import java.util.List;

import repository.CartDAO;
import repository.DBUtil;
import vo.Cart;

public class CartService {
	private DBUtil dbUtil;
	private CartDAO cartDAO;

	// C 장바구니 추가
	public int addCart(Cart cart) {
		return 0;
		// 리턴값
		 
	}

	// R 장바구니 리스트
	public List<Cart> getCartList(Cart cart) {
		return null;
	}

	// U 장바구니 수량 수정
	public int modifyCart(Cart cart) {
		return 0;
	}

	// D 장바구니 삭제
	public int removeCart(Cart cart) {
		return 0;
	}
}
