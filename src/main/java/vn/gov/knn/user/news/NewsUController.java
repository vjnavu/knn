package vn.gov.knn.user.news;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import vn.gov.knn.admin.album.Album;
import vn.gov.knn.admin.album.AlbumService;
import vn.gov.knn.admin.board.board.Board;
import vn.gov.knn.admin.board.board.BoardService;
import vn.gov.knn.admin.board.post.Post;
import vn.gov.knn.admin.board.post.PostService;
import vn.gov.knn.admin.board.post.view.CountView;
import vn.gov.knn.admin.board.post.view.CountViewService;
import vn.gov.knn.admin.board.qa.QA;
import vn.gov.knn.admin.board.qa.QAService;
import vn.gov.knn.admin.config.Config;
import vn.gov.knn.admin.config.ConfigService;
import vn.gov.knn.admin.content.Content;
import vn.gov.knn.admin.content.ContentService;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;
import vn.gov.knn.admin.menu.MenuService;
import vn.gov.knn.admin.support.Pagination;
import vn.gov.knn.user.common.CommonService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class NewsUController {
    @Autowired
    private BoardService boardService;
    @Autowired
    private PostService postService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private QAService qaService;

    @Autowired
    private MenuService menuService;
    @Autowired
    private ContentService contentService;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private HttpServletResponse response;
    @Autowired
    private ConfigService configService;
    @Autowired
    private CountViewService countViewService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private FileService fileService;

    @GetMapping(value = "/news/board/{boardSeq}")
    public String viewBoard(@PathVariable Integer boardSeq, @ModelAttribute(value = "postSearch") Post post, Model model, HttpServletRequest request, HttpServletResponse response) {
        /*Quyền xem danh sách*/
        boolean check = commonService.checkAcceptBoard(boardSeq, 1);
        if (check) {
            Board board = boardService.getBoardBySeq(boardSeq);
            String type = board.getBoard_type();
            if ("D".equals(type) || "L".equals(type)) {
                post.setSize(10);
            } else {
                post.setSize(9);
            }
            if (post.getSearchItem() == null) {
                HttpSession session = request.getSession();
                String language = (String) session.getAttribute("language");
                if (language == null) {
                    session.setAttribute("language", "vn");
                    post.setSearchItem("post_title_vn");
                } else {
                    if (language.equals("vn")) {
                        post.setSearchItem("post_title_vn");
                    } else {
                        post.setSearchItem("post_title_en");
                    }
                }
                post.setSearchItem("post_title_vn");
            }

            if ("D".equals(board.getBoard_type())) {
                post.setSearchItem(null);
            }
            commonService.sentInfoWeb(model);
            post.setBoard_seq(boardSeq);
            List<Post> posts = postService.getPostList(post);
            int totalRow = postService.countPost(post);
            int totalPost = postService.countPostByBoard(boardSeq);
            int totalPage = 0;
            if (totalRow % 10 == 0) {
                totalPage = (int) totalRow / 10;
            } else {
                totalPage = (int) totalRow / 10 + 1;
            }
            Pagination pagination = new Pagination();
            model.addAttribute("paging", pagination.createPagingString(post.getPage(), post.getSize(), totalRow));
            model.addAttribute("posts", posts);
            model.addAttribute("boardSeq", boardSeq);
            model.addAttribute("totalPost", totalPost);
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("totalRow", totalRow);
            String typeConvert = "";
            switch (type) {
                case "M":
                    typeConvert = "basic";
                    break;
                case "W":
                    typeConvert = "web";
                    break;
                case "G":
                    typeConvert = "gallery";
                    break;
                case "D":
                    typeConvert = "document";
                    break;
                case "U":
                    typeConvert = "setting";
                    break;
                case "V":
                    typeConvert = "video";
                    break;
                case "L":
                    typeConvert = "galleryList";
                    break;
                default:
                    typeConvert = "basic";
                    break;
            }
            return "/vn/user/news/" + typeConvert + "/list";
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

    @GetMapping(value = "/news/{type}/view/{postSeq}")
    public String viewPost(@PathVariable String type, @PathVariable Integer postSeq, Model model) {
        /*Quyền đọc*/
        boolean check = commonService.checkAcceptBoard(postService.getPostBySeq(postSeq).getBoard_seq(), 3);
        if (check) {
            commonService.sentInfoWeb(model);
            Post post = postService.getPostBySeq(postSeq);
            model.addAttribute("post", post);
            postService.getPreNextPost(model, postSeq);
            model.addAttribute("type", type);
            model.addAttribute("boardSeq", post.getBoard_seq());
            HttpSession session = request.getSession();
            CountView countView = new CountView();
            countView.setPost_seq(postSeq);
            countView.setVp_session_id(session.getId());
            countViewService.countView(countView);
            return "/vn/user/news/" + type + "/view";
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

    @GetMapping(value = "/post/view/{postSeq}")
    public String viewPostTmp(@PathVariable Integer postSeq, RedirectAttributes redirectAttributes) {
        /*Quyền đọc*/
        Post post = postService.getPostBySeq(postSeq);
        if (post != null) {
            Board board = boardService.getBoardBySeq(post.getBoard_seq());
            String type = board.getBoard_type();
            switch (type) {
                case "M":
                    type = "basic";
                    break;
                case "W":
                    type = "web";
                    break;
                case "G":
                    type = "gallery";
                    break;
                case "D":
                    type = "document";
                    break;
                case "U":
                    type = "setting";
                    break;
                case "V":
                    type = "video";
                    break;
                case "L":
                    type = "galleryList";
                    break;
                default:
                    type = "basic";
                    break;
            }
            return "redirect:/news/" + type + "/view/" + postSeq;
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Bài viết không còn tồn tại");
            return "redirect:/";
        }
    }

    //    Question start
    @GetMapping(value = "/news/qa/questions")
    public String getList(@ModelAttribute(value = "qaSearch") QA qa, Model model) {
        commonService.sentInfoWeb(model);
//        qa.setSearchItem("qa_question");
        List<QA> qas = qaService.getListQa(qa);
        model.addAttribute("qas", qas);
        int totalRow = qaService.countQA(qa);
        model.addAttribute("totalRow", totalRow);
        int totalPage = 0;
        if (totalRow % 10 == 0) {
            totalPage = (int) totalRow / 10;
        } else {
            totalPage = (int) totalRow / 10 + 1;
        }
        model.addAttribute("totalPage", totalPage);
        Pagination pagination = new Pagination();
        model.addAttribute("paging", pagination.createPagingString(qa.getPage(), qa.getSize(), totalRow));

        return "/vn/user/news/qa/list";
    }

    @PostMapping(value = "/news/qa/questions/private")
    @ResponseBody
    public String getPasswordQa(@RequestParam(value = "password") String qaPassword,
                                @RequestParam(value = "seq") Integer seq,
                                Model model,
                                HttpServletRequest request) {
        commonService.sentInfoWeb(model);
        QA qa = qaService.getQABySeq(seq);
        if (BCrypt.checkpw(qaPassword, qa.getQa_password())) {
            String qaCheck = UUID.randomUUID().toString();
            HttpSession session = request.getSession();
            session.removeAttribute("qaCheck");
            session.setAttribute("qaCheck", qaCheck);
            qaCheck = qaCheck + "-" + String.valueOf(seq);
            return qaCheck;
        } else {
            return "0";
        }
    }

    @GetMapping(value = "/news/qa/question")
    public String createQuestionG(Model model) {
        commonService.sentInfoWeb(model);
        Config config = configService.getConfig();
        String wordFilter = config.getConfig_block_word();
        if (wordFilter != null) {
            String[] arrFilter = wordFilter.split(",");
            model.addAttribute("wordFilter", arrFilter);
        }
        model.addAttribute("action", "new");
        model.addAttribute("qa", new QA());
        return "/vn/user/news/qa/question";
    }

    @PostMapping(value = "/news/qa/question/new")
    public String createQuestionP(@ModelAttribute(value = "qa") QA qa, RedirectAttributes redirectAttributes) {
        qa.setQa_question_dt(new Date());
        if (qa.getQa_password() != null) {
            qa.setQa_password(BCrypt.hashpw(qa.getQa_password(), BCrypt.gensalt(12)));
        }
        int saveResult = qaService.saveNewQA(qa);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Đăng câu hỏi thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/news/qa/questions";
    }


    @GetMapping(value = "/news/qa/view/{postSeq}")
    public String viewQa(@PathVariable Integer postSeq, Model model) {
        /*HttpSession session = request.getSession();
        CountView countView = new CountView();
        countView.setPost_seq(postSeq);
        countView.setVp_session_id(session.getId());
        countViewService.countView(countView);*/
        commonService.sentInfoWeb(model);
        QA qa = qaService.getQABySeq(postSeq);
        model.addAttribute("qa", qa);
        return "/vn/user/news/qa/view";
    }

    @GetMapping(value = "/news/qa/private/{string}")
    public String privateQa(@PathVariable String string, Model model, RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        int index = string.lastIndexOf("-");
        Integer seq = Integer.parseInt(string.substring(index + 1));
        String key = string.substring(0, index);
        String keySession = (String) session.getAttribute("qaCheck");
        if (keySession != null) {
            if (key.equals(keySession)) {
                /*CountView countView = new CountView();
                countView.setPost_seq(seq);
                countView.setVp_session_id(session.getId());
                countViewService.countView(countView);*/
                commonService.sentInfoWeb(model);
                QA qa = qaService.getQABySeq(seq);
                model.addAttribute("qa", qa);
                model.addAttribute("key", key + "-" + String.valueOf(seq));
                return "/vn/user/news/qa/view";
            } else {
                redirectAttributes.addFlashAttribute("errorMess", "Còn cái nịt");
                return "redirect:/news/qa/questions";
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đừng cố không ăn được đâu");
            return "redirect:/news/qa/questions";
        }
    }

    @GetMapping(value = "/news/qa/delete/{string}")
    public String deleteQa(@PathVariable String string, RedirectAttributes redirectAttributes) {
        int index = string.lastIndexOf("-");
        Integer seq = Integer.parseInt(string.substring(index + 1));
        String key = string.substring(0, index);
        HttpSession session = request.getSession();
        String keySession = (String) session.getAttribute("qaCheck");
        if (keySession != null) {
            if (key.equals(keySession)) {
                int deleteResult = qaService.deleteQa(seq);
                if (deleteResult > 0) {
                    redirectAttributes.addFlashAttribute("successMess", "Xoá câu hỏi thành công");
                } else {
                    redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xoá câu hỏi");
                }
                return "redirect:/news/qa/questions";
            } else {
                redirectAttributes.addFlashAttribute("errorMess", "Bạn không có quyền xóa câu hỏi này");
                return "redirect:/news/qa/questions";
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Bạn không có quyền xóa câu hỏi này");
            return "redirect:/news/qa/questions";
        }
    }

    @GetMapping(value = "/news/qa/update/{string}")
    public String updateQa(@PathVariable String string, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        commonService.sentInfoWeb(model);
        Config config = configService.getConfig();
        int index = string.lastIndexOf("-");
        Integer seq = Integer.parseInt(string.substring(index + 1));
        String key = string.substring(0, index);
        HttpSession session = request.getSession();
        String keySession = (String) session.getAttribute("qaCheck");
        if (keySession != null) {
            if (key.equals(keySession)) {
                String wordFilter = config.getConfig_block_word();
                if (wordFilter != null) {
                    String[] arrFilter = wordFilter.split(",");
                    model.addAttribute("wordFilter", arrFilter);
                }
                QA qa = qaService.getQABySeq(seq);
                model.addAttribute("qa", qa);
                model.addAttribute("action", "update");
                return "/vn/user/news/qa/question";
            } else {
                redirectAttributes.addFlashAttribute("errorMess", "Bạn không có quyền sửa câu hỏi này");
                return "redirect:/news/qa/questions";
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Bạn không có quyền sửa câu hỏi này");
            return "redirect:/news/qa/questions";
        }
    }

    @PostMapping(value = "/news/qa/question/update")
    public String postUpdateQa(@ModelAttribute(value = "qa") QA qa, RedirectAttributes redirectAttributes) {
        int updateResult = qaService.userUpdateQA(qa);
        if (updateResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Sửa câu hỏi thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi sửa câu hỏi");
        }
        return "redirect:/news/qa/questions";
    }

    //    Question end
    @GetMapping(value = "/news/content/{postSeq}")
    public String viewContent(@PathVariable Integer postSeq, Model model) {
        Content content = contentService.getContentBySeq(postSeq);
        model.addAttribute("content", content);
        commonService.sentInfoWeb(model);
        return "/vn/user/content/content";
    }

    @GetMapping(value = "/events")
    public String viewEvent(Model model, @ModelAttribute(value = "eventSearch") Album album) {
        commonService.sentInfoWeb(model);
        album.setSize(12);
        List<Album> albums = albumService.getAllAlbum(album);

        if (albums.size() > 0) {
            for (Album albumList : albums) {
                List<FileVO> files = new ArrayList<>();
                if (albumList.getAlbum_img().length() > 0) {
                    int[] img = Arrays.stream(albumList.getAlbum_img().split(",")).mapToInt(Integer::parseInt).toArray();
                    if (img != null && img.length > 0) {
                        for (int i : img) {
                            FileVO fileVO = fileService.getUUIDFileBySeq(i);
                            files.add(fileVO);
                        }
                    }
                }
                albumList.setAlbum(files);
            }
        }

        int totalRow = albumService.countAlbum(album);

        int totalPage = 0;
        if (totalRow % 10 == 0) {
            totalPage = (int) totalRow / 10;
        } else {
            totalPage = (int) totalRow / 10 + 1;
        }

        Pagination pagination = new Pagination();

        model.addAttribute("totalPage", totalPage - 1);
        model.addAttribute("paging", pagination.createPagingString(album.getPage(), album.getSize(), totalRow));
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("albums", albums);
        return "/vn/user/news/event/list";
    }

//    public static void main(String[] args) {
//        String s = "sajld-sfh dsk fdsfd;lksghdfgh-sdflglhdfsgs -219";
//        int index = s.lastIndexOf("-");
//        System.out.println(s.substring(index+1));
//        System.out.println(s.substring(0,index));
//    }
}
