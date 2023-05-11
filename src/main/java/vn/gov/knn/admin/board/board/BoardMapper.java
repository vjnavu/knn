package vn.gov.knn.admin.board.board;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
interface BoardMapper {
    List<Board> getAllBoard();

    List<Board> getBoardByDisplay();

    List<Board> getBoardList(Board board);

    int countBoard(Board board);

    int saveBoard(Board board);

    int updateBoard(Board board);

    Board getBoardBySeq(int boardSeq);

    int deleteBoard(int boardSeq);

    Board getFirstBoard();

    int countTotalBoard();

    int countActiveBoard();
}
