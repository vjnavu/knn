package vn.gov.knn.admin.board.post;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PostMapper {
    List<Post> getAllPost(Post post);

    List<Post> getPostList(Post post);

    Post getPostBySeq(int postSeq);

    Post getPrePost(Post search);

    Post getNextPost(Post search);

    int countPost(Post post);

    int saveNewPost(Post post);

    int updatePost(Post post);

    int updateStatusDelete(Post post);

    public List<Post> getPostbyBoardSeqLimit(Post post);

    List<Post> getPostByLimit(int limit);

    List<Post> getVideoByLimit(int limit);

    List<Post> getEventByLimit(int limit);

    List<Post> getDevByLimit(int limit);

    int countPostByBoard(int boardSeq);

    int countTotalPost(int boardSeq);

    int countActivePost(int boardSeq);

    int updateCountPost(Post post);
}
