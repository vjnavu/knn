package vn.gov.knn.admin.board.post.view;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.gov.knn.admin.board.post.Post;
import vn.gov.knn.admin.board.post.PostService;

@Service
public class CountViewService {
    @Autowired
    private CountViewMapper countViewMapper;
    @Autowired
    private PostService postService;

    public void countView(CountView countView) {
        CountView countViewGet = countViewMapper.getCountView(countView);
        if (countViewGet == null) {
            countViewMapper.saveCountView(countView);
            Post post = new Post();
            post.setPost_seq(countView.getPost_seq());
            postService.updateCountPost(post);
        }
    }

    public void deleteBySessionId(String id) {
        countViewMapper.deleteBySessionId(id);
    }
}
