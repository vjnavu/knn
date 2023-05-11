package vn.gov.knn.admin.board.post;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.board.board.Board;
import vn.gov.knn.admin.board.board.BoardService;
import vn.gov.knn.admin.config.Config;
import vn.gov.knn.admin.config.ConfigService;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;
import vn.gov.knn.user.common.CommonService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class PostController extends CurrentUser {
    @Autowired
    private BoardService boardService;

    @Autowired
    private PostService postService;

    @Autowired
    private ConfigService configService;

    @Autowired
    private FileService fileService;

    @Autowired
    private CommonService commonService;

    @GetMapping(value = "/cms/post")
    public String firstPostList(RedirectAttributes redirectAttributes, HttpServletResponse response) {
        super.updateRoleSession();
        Admin admin = (Admin) request.getSession().getAttribute("CurrentUser");
        int boardSeq = boardService.getBoardByRole(admin.getAd_role());
        if (boardSeq == -1) {
            redirectAttributes.addFlashAttribute("errorMess", "Chưa có bài viết nào tồn tại. Vui lòng tạo bảng tin sau đó tạo bài viết");
            return "redirect:/cms/board/new";
        } else if (boardSeq == 0) {
            String alert = "Bạn không có quyền xem danh sách bài viết của tất cả các bảng tin. Vui lòng thông báo admin cấp quyền";
            FlashMap flashMap = new FlashMap();
            flashMap.put("alert", alert);
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        } else {
            return "redirect:/cms/post/" + boardSeq;
        }
    }

    @GetMapping(value = "/cms/post/{boardSeq}")
    public String getPostList(
            Model model,
            @ModelAttribute("postSearch") Post post,
            @PathVariable int boardSeq,
            HttpServletResponse response) throws Exception {
        /*Quyền xem danh sách*/
        boolean check = commonService.checkAcceptBoard(boardSeq, 1);
        if (check) {
            super.updateRoleSession();
            List<Board> boardList = boardService.getAllBoard();
            model.addAttribute("boardList", boardList);
            post.setBoard_seq(boardSeq);
            List<Post> postList = postService.getPostList(post);
            int totalRow = postService.countPost(post);
            int totalPost = postService.countTotalPost(boardSeq);
            int activePost = postService.countActivePost(boardSeq);
            Pagination pagination = new Pagination();
            model.addAttribute(
                    "paging", pagination.createPagingString(post.getPage(), post.getSize(), totalRow));
            model.addAttribute("postList", postList);
            model.addAttribute("boardSeq", boardSeq);
            model.addAttribute("totalPost", totalPost);
            model.addAttribute("activePost", activePost);
            Board board = boardService.getBoardBySeq(boardSeq);
            if ("D".equals(board.getBoard_type())) {

                return "vn/admin/board/post/list_doc";
            } else {
                return "vn/admin/board/post/list";
            }
        } else {
            String alert = "Bạn không có quyền xem danh sách bài viết của bảng tin này";
            FlashMap flashMap = new FlashMap();
            if (alert != null && !alert.equals("")) {
                flashMap.put("alert", alert);
            }
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        }
    }

    @GetMapping(value = "/cms/post/new/{boardSeq}")
    public String getNewPost(
            Model model,
            @PathVariable int boardSeq,
            HttpServletResponse response) {
        /*Quyền viết*/
        boolean check = commonService.checkAcceptBoard(boardSeq, 2);
        if (check) {
            super.updateRoleSession();
            Board board = boardService.getBoardBySeq(boardSeq);
            List<Board> boardList = boardService.getAllBoard();
            model.addAttribute("boardList", boardList);
            this.getFilterWordandFileExt(model);
            Post postForm = new Post();
            postForm.setPost_display_tf(true);
            postForm.setBoard_seq(boardSeq);
            model.addAttribute("postForm", postForm);
            model.addAttribute("formAction", "save");
            model.addAttribute("boardSeq", boardSeq);
            model.addAttribute("fileNumber", board.getBoard_files());
            model.addAttribute("boardType", board.getBoard_type());
            if ("D".equals(board.getBoard_type())) {
                return "vn/admin/board/post/form_doc";
            } else {
                return "vn/admin/board/post/form";
            }
        } else {
            String alert = "Bạn không có quyền thêm hoặc chỉnh sửa bảng tin này";
            FlashMap flashMap = new FlashMap();
            if (alert != null && !alert.equals("")) {
                flashMap.put("alert", alert);
            }
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        }
    }

    @PostMapping(value = "/cms/post/save")
    public String saveNewPost(
            @ModelAttribute("postForm") Post post,
            @RequestParam(value = "avatar", required = false) MultipartFile avatar,
            RedirectAttributes redirectAttributes,
            @RequestParam("post_file") MultipartFile[] attachments,
            @RequestParam(value = "reg_dt", required = false) String post_reg_dt,
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {
        boolean check = commonService.checkAcceptBoard(post.getBoard_seq(), 2);
        if (check) {
            if (post.isPost_display_tf()) post.setPost_display("Y");
            else post.setPost_display("N");
            if (avatar != null && !avatar.isEmpty()) {
                FileVO fileVO = new FileVO();
                fileVO.setTarget_dir("/board/post/avatar/" + post.getBoard_seq());
                fileService.saveFile(avatar, fileVO);
                post.setPost_thumbnail(fileVO.getFile_seq());
            }else{
                post.setPost_thumbnail(1);
            }
            if (!post.getPost_hyper_text_vn().equals("") && post.getPost_hyper_text_vn() != null)
                post.setPost_text_vn(Jsoup.parse(post.getPost_hyper_text_vn()).wholeText());
            if (post.getPost_hyper_text_en() != null) {
                if (!post.getPost_hyper_text_en().equals("")) {
                    post.setPost_text_en(Jsoup.parse(post.getPost_hyper_text_en()).wholeText());
                }
            }
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("CurrentUser");
            post.setPost_reg_adm(admin.getAd_seq());

            //VTA 2022-04-27: Nhập ngày đăng bài từ form <=> nhập dữ liệu từ web cũ
            if (post_reg_dt != null) {
                Date regDateConvert = new SimpleDateFormat("yyyy-MM-dd").parse(post_reg_dt);
                post.setPost_reg_dt(regDateConvert);
            } else {
                post.setPost_reg_dt(new Date());
            }
            post.setPost_delete("N");
            int postSaveResult = postService.saveNewPost(post, attachments);
            if (postSaveResult > 0) {
                redirectAttributes.addFlashAttribute("successMess", "Thêm bài viết thành công");
            } else {
                redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi lưu bài viết");
            }
            return "redirect:/cms/post/" + post.getBoard_seq();
        } else {
            String alert = "Bạn không có quyền thêm hoặc chỉnh sửa bảng tin này";
            FlashMap flashMap = new FlashMap();
            if (alert != null && !alert.equals("")) {
                flashMap.put("alert", alert);
            }
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        }

    }


    /*View Post*/
    @GetMapping("/cms/post/view/{postSeq}")
    public String getPostView(
            @PathVariable Integer postSeq, Model model,
            HttpServletResponse response) {
        /*Quyền đọc*/
        List<Board> boardList = boardService.getAllBoard();
        Post postView = postService.getPostBySeq(postSeq);
        boolean check = commonService.checkAcceptBoard(postView.getBoard_seq(), 3);
        if (check) {
            model.addAttribute("boardList", boardList);
            model.addAttribute("postView", postView);
            model.addAttribute("boardSeq", postView.getBoard_seq());
            postService.getPreNextPost(model, postSeq);
            return "vn/admin/board/post/view";
        } else {
            String alert = "Bạn không có quyền đọc bài viết này";
            FlashMap flashMap = new FlashMap();
            if (alert != null && !alert.equals("")) {
                flashMap.put("alert", alert);
            }
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        }
    }

    /*Get Update Post*/
    @GetMapping(value = "/cms/post/update/{postSeq}")
    public String getUpdatePost(
            @PathVariable int postSeq, Model model,
            HttpServletResponse response) {
        /*Quyền đọc*/
        super.updateRoleSession();
        this.getFilterWordandFileExt(model);
        Post postForm = postService.getPostBySeq(postSeq);
        boolean check = commonService.checkAcceptBoard(postForm.getBoard_seq(), 3);
        if (check) {
            Board board = boardService.getBoardBySeq(postForm.getBoard_seq());
            if (postForm.getPost_display().equals("Y")) postForm.setPost_display_tf(true);
            else postForm.setPost_display_tf(false);
            List<Board> boardList = boardService.getAllBoard();
            model.addAttribute("boardList", boardList);
            model.addAttribute("postForm", postForm);
            model.addAttribute("boardSeq", postForm.getBoard_seq());
            model.addAttribute("formAction", "update");
            model.addAttribute("fileNumber", board.getBoard_files());
            model.addAttribute("boardType", board.getBoard_type());
            if ("D".equals(board.getBoard_type())) {
                return "vn/admin/board/post/form_doc";
            } else {
                return "vn/admin/board/post/form";
            }
        } else {
            String alert = "Bạn không có quyền đọc bài viết này";
            FlashMap flashMap = new FlashMap();
            if (alert != null && !alert.equals("")) {
                flashMap.put("alert", alert);
            }
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        }
    }


    /*Update Post*/
    @PostMapping(value = "/cms/post/update")
    public String updatePost(
            @ModelAttribute("postForm") Post post,
            HttpServletRequest request,
            @RequestParam("post_file") MultipartFile[] files,
            RedirectAttributes redirectAttributes,
            @RequestParam(value = "avatar", required = false) MultipartFile avatar,
            @RequestParam(value = "reg_dt", required = false) String post_reg_dt,
            HttpServletResponse response)
            throws Exception {
        /*Quyền viết*/
        Post getOldPost = postService.getPostBySeq(post.getPost_seq());
        boolean check = commonService.checkAcceptBoard(getOldPost.getBoard_seq(), 2);
        if (check) {
            if (avatar != null && !avatar.isEmpty()) {
                boolean deleteOldFile = fileService.deleteFileBySeq(getOldPost.getPost_thumbnail());
                FileVO fileVO = new FileVO();
                fileVO.setTarget_dir("/board/post/avatar/" + post.getBoard_seq());
                fileService.saveFile(avatar, fileVO);
                post.setPost_thumbnail(fileVO.getFile_seq());
            } else {
                post.setPost_thumbnail(getOldPost.getPost_thumbnail());
            }
            post.setPost_mod_dt(new Date());

            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("CurrentUser");
            post.setPost_mod_adm(admin.getAd_seq());
            if (post.isPost_display_tf()) post.setPost_display("Y");
            else post.setPost_display("N");
            if (!post.getPost_hyper_text_vn().equals(""))
                post.setPost_text_vn(Jsoup.parse(post.getPost_hyper_text_vn()).wholeText());
            if (post.getPost_hyper_text_en() != null) {
                if (!post.getPost_hyper_text_en().equals("")) {
                    post.setPost_text_en(Jsoup.parse(post.getPost_hyper_text_en()).wholeText());
                }
            }
            if (post_reg_dt != null && !post_reg_dt.equals("")) {
                Date regDateConvert = new SimpleDateFormat("yyyy-MM-dd").parse(post_reg_dt);
                post.setPost_reg_dt(regDateConvert);
            } else {
                post.setPost_reg_dt(new Date());
            }
            int postUpdateResult = postService.updatePost(post, files);
            if (postUpdateResult > 0) {
                redirectAttributes.addFlashAttribute(
                        "successMess", "Chỉnh sửa thông tin bài viết thành công");
            } else {
                redirectAttributes.addFlashAttribute(
                        "errorMess", "Đã xảy ra lỗi khi chỉnh sửa thông tin bài viết");
            }
            return "redirect:/cms/post/" + post.getBoard_seq();
        } else {
            String alert = "Bạn không có quyền thêm hoặc chỉnh sửa bảng tin này";
            FlashMap flashMap = new FlashMap();
            if (alert != null && !alert.equals("")) {
                flashMap.put("alert", alert);
            }
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        }
    }

    @GetMapping(value = "/cms/post/delete/{postSeq}")
    public String deletePost(@PathVariable int postSeq,
                             RedirectAttributes redirectAttributes,
                             HttpServletResponse response) {
        /*Quyền xóa*/
        int boardSeq = postService.getPostBySeq(postSeq).getBoard_seq();
        boolean check = commonService.checkAcceptBoard(boardSeq, 4);
        if (check) {
            super.updateRoleSession();
            Post post = new Post();
            post.setPost_seq(postSeq);
            post.setPost_delete("N");
            int postUpdateDelete = postService.updateStatusDelete(post);
            if (postUpdateDelete > 0) {
                redirectAttributes.addFlashAttribute(
                        "successMess", "Xóa bài viết thành công");
            } else {
                redirectAttributes.addFlashAttribute(
                        "errorMess", "Đã xảy ra lỗi khi xóa bài viết");
            }
            return "redirect:/cms/post/" + boardSeq;
        } else {
            String alert = "Bạn không có quyền thêm hoặc chỉnh sửa bảng tin này";
            FlashMap flashMap = new FlashMap();
            if (alert != null && !alert.equals("")) {
                flashMap.put("alert", alert);
            }
            FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
            flashMapManager.saveOutputFlashMap(flashMap, request, response);
            return "redirect:" + request.getHeader("Referer");
        }
    }

    private void getFilterWordandFileExt(Model model) {
        Config setting = configService.getConfig();
        String wordFilter = setting.getConfig_block_word();
        if (wordFilter != null) {
            String[] arrFilter = wordFilter.split(",");
            model.addAttribute("wordFilter", arrFilter);
        }
    }
}
