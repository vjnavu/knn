package vn.gov.knn.admin.board.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import vn.gov.knn.admin.admin.AdminService;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

import java.util.List;

@Service
public class PostService {
    @Autowired
    private PostMapper postMapper;
    @Autowired
    private FileService fileService;
    @Autowired
    private AdminService adminService;

    public List<Post> getAllPost(Post post) {
        return postMapper.getAllPost(post);
    }

    public List<Post> getPostList(Post post) {
        post.setOffset((post.getPage() - 1) * post.getSize());
        List<Post> posts = postMapper.getPostList(post);
        for (Post ps : posts) {
            String email = adminService.getAdminBySeq(ps.getPost_reg_adm()).getAd_email();
            if ((!email.equals("")) && email != null) {
                ps.setPost_reg_email(email);
            } else {
                ps.setPost_reg_email("Không tìm thấy tác giả");
            }
            ps.setFileVOList(fileService.getListFileByPostSeq(ps.getPost_seq()));
        }
        return posts;
    }


    public Post getPostBySeq(Integer postSeq) {
        Post post = postMapper.getPostBySeq(postSeq);
        if (post != null) {
            post.setFileVOList(fileService.getListFileByPostSeq(postSeq));
        }
        return post;
    }

    public void getPreNextPost(Model model, Integer postSeq) {
        Post post = postMapper.getPostBySeq(postSeq);
        Post search = new Post();
        search.setPost_seq(postSeq);
        search.setBoard_seq(post.getBoard_seq());
        Post prePost = postMapper.getPrePost(search);
        Post nextPost = postMapper.getNextPost(search);
        model.addAttribute("prePost", prePost);
        model.addAttribute("nextPost", nextPost);
    }

    public int countPost(Post post) {
        return postMapper.countPost(post);
    }

    public int saveNewPost(Post post, MultipartFile[] attachments) throws Exception {
        int result = postMapper.saveNewPost(post);
        /*System.out.println(attachments.length);*/
        if (result > 0 && attachments.length > 0) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/board/post/attachments/" + post.getBoard_seq());
            fileVO.setPost_seq(post.getPost_seq());
            fileService.saveMultiFile(attachments, fileVO);
        }
        return result;
    }

    public int updatePost(Post post, MultipartFile[] files) throws Exception {
        int updateResult = postMapper.updatePost(post);
        if (updateResult > 0) {
            if (post.getDeleteFileSeqList() != null && !post.getDeleteFileSeqList().isEmpty()) {
                for (Integer fileSeq : post.getDeleteFileSeqList()) {
                    fileService.deleteFileBySeq(fileSeq);
                }
            }
            if (files.length > 0) {
                FileVO fileVO = new FileVO();
                fileVO.setTarget_dir("/board/post/avatar/" + post.getBoard_seq());
                fileVO.setPost_seq(post.getPost_seq());
                fileService.saveMultiFile(files, fileVO);
            }
        }
        return updateResult;
    }

    public int updateStatusDelete(Post post) {
        return postMapper.updateStatusDelete(post);
    }

    public List<Post> getPostByLimit(int limit) {
        return postMapper.getPostByLimit(limit);
    }

    public List<Post> getPostbyBoardSeqLimit(int boardSeq, int limit) {
        Post post = new Post();
        post.setBoard_seq(boardSeq);
        post.setSize(limit);
        return postMapper.getPostbyBoardSeqLimit(post);

    }

    public List<Post> getVideoByLimit(int limit) {
        return postMapper.getVideoByLimit(limit);
    }

    public List<Post> getEventByLimit(int limit) {
        return postMapper.getEventByLimit(limit);
    }

    public List<Post> getDevByLimit(int limit) {
        return postMapper.getDevByLimit(limit);
    }

    public int countPostByBoard(int boardSeq) {
        return postMapper.countPostByBoard(boardSeq);
    }

    public int countTotalPost(int boardSeq) {
        return postMapper.countTotalPost(boardSeq);
    }

    public int countActivePost(int boardSeq) {
        return postMapper.countActivePost(boardSeq);
    }

    public int updateCountPost(Post post) {
        return postMapper.updateCountPost(post);
    }

}
