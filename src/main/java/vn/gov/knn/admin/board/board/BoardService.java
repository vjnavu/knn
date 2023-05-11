package vn.gov.knn.admin.board.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.admin.AdminService;

import java.util.List;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private AdminService adminService;

	public List<Board> getAllBoard() {
		return boardMapper.getAllBoard();
	}

	public List<Board> getBoardList(Board board) {
		return boardMapper.getBoardList(board);
	}

	public int countBoard(Board board) {
		return boardMapper.countBoard(board);
	}

	public int saveBoard(Board board) {
		return boardMapper.saveBoard(board);
	}

	public Board getBoardBySeq(Integer catSeq) {
		Board board = boardMapper.getBoardBySeq(catSeq);
		if(board.getBoard_mod_adm() != 0)
		{
			Admin admin = adminService.getAdminBySeq(board.getBoard_mod_adm());
			board.setBoard_mod_email(admin.getAd_email());
		}
		return board;
	}

	public int updateBoard(Board board) {
		return boardMapper.updateBoard(board);
	}

	public int deleteBoard(int boardSeq) {
		return boardMapper.deleteBoard(boardSeq);
	}

	public Board getFirstBoard() {
		return boardMapper.getFirstBoard();
	}

	public int countTotalBoard() {
		return boardMapper.countTotalBoard();
	}

	public int countActiveBoard() {
		return boardMapper.countActiveBoard();
	}

	public int getBoardByRole(int ad_role) {
		List<Board> boardList = boardMapper.getAllBoard();
		int boardSeq = 0;
		if(ad_role == 1)
		{
			boardSeq = boardList.get(0).getBoard_seq();
		}
		else
		{
			if(boardList.size() == 0)
			{
				boardSeq = -1;
			}
			else
			{
				for(int i = 0; i < boardList.size(); i++)
				{
					if(boardList.get(i).getBoard_perm_view_list().contains(String.valueOf(ad_role)))
					{
						boardSeq = boardList.get(i).getBoard_seq();
						break;
					}
				}
			}
		}

		return boardSeq;
	}
}
