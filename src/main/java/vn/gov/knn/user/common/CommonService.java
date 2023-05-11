package vn.gov.knn.user.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.board.board.Board;
import vn.gov.knn.admin.board.board.BoardService;
import vn.gov.knn.admin.board.post.Post;
import vn.gov.knn.admin.board.post.PostService;
import vn.gov.knn.admin.config.Config;
import vn.gov.knn.admin.config.ConfigService;
import vn.gov.knn.admin.exam.Exam;
import vn.gov.knn.admin.exam.ExamService;
import vn.gov.knn.admin.menu.Menu;
import vn.gov.knn.admin.menu.MenuService;
import vn.gov.knn.admin.visitor.Visitor;
import vn.gov.knn.admin.visitor.VisitorService;
import vn.gov.knn.user.search.Search;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommonService {
    @Autowired
    private MenuService menuService;

    @Autowired
    private ConfigService configService;

    @Autowired
    private VisitorService visitorService;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private PostService postService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private ExamService examService;

    public void sentInfoWeb(Model model) {
        model.addAttribute("generalSearch", new Search());
        Map<Menu, List<Menu>> menus = new LinkedHashMap<>();
        List<Menu> menuP = menuService.getListMenuParent();
        if (menuP != null) {
            for (Menu menu : menuP) {
                List<Menu> menuC = menuService.getListMenuByParent(menu);
                menus.put(menu, menuC);
            }
        }
        model.addAttribute("menus", menus);
        HttpSession session = request.getSession();
        session.removeAttribute("menuHome");
        session.setAttribute("menuHome", menus);

        Config config = configService.getConfig();
        model.addAttribute("config", config);

        List<Visitor> visitors = visitorService.getAllVisitor();
        Integer total = 0;
        if (visitors.size() != 0) {
            for (Visitor visitor : visitors) {
                total += visitor.getVs_total();
            }
        }
        if (visitors.size() != 0) {
            model.addAttribute("visitors", total);
            model.addAttribute("visitor", visitors.get(0).getVs_total());
        } else {
            model.addAttribute("visitors", 0);
            model.addAttribute("visitor", 0);
        }

        Breadcrumb breadcrumb = new Breadcrumb();
        breadcrumb.getMenuC1().setMn_name_vn("Trang chủ");
        breadcrumb.getMenuC1().setMn_name_en("Home");
        breadcrumb.getMenuC1().setMn_link("/");
        breadcrumb.getMenuC1().setMn_seq(0);
        Integer activeMenu = (Integer) session.getAttribute("activeMenu");
        String url = request.getRequestURL().toString();
        /*Active when click item in Home*/
        if (activeMenu == null || url.contains("/news/")|| url.contains("/certificate/")|| url.contains("/agency/")|| url.contains("/exam/")) {
            if (!url.contains("/cms/")
                    && !request.getRequestURL().toString().contains("/ckfinder/")
                    && !request.getRequestURL().toString().contains("/code/check")
                    && !request.getRequestURL().toString().contains("/content/check/")
                    && !request.getRequestURL().toString().contains("/board/check/")
                    && !request.getRequestURL().toString().contains("/cms/admin/email/check")
                    && !request.getRequestURL().toString().contains("/forgot/email/code")
                    && !request.getRequestURL().toString().contains("/forgot/email/confirm")
                    && !request.getRequestURL().toString().contains("/assets/user")
                    && !request.getRequestURL().toString().contains("/jarvis/file")
            ) {
                if (url.contains("/news/") && !url.contains("/news/qa/questions") && !url.contains("/news/board/") && !url.contains("/news/content/")) {
                    if (url.contains("/qa/")) {
                        List<Menu> findQaMenu = menuService.getMenuByUrl("/news/qa/questions");
                        session.removeAttribute("activeMenu");
                        session.setAttribute("activeMenu", findQaMenu.get(0).getMn_seq());
                        activeMenu = findQaMenu.get(0).getMn_seq();
                    } else {
                        String seq = this.cutBoard(url);
                        int postSeq = Integer.parseInt(seq);
                        Post post = postService.getPostBySeq(postSeq);
                        List<Menu> findPostMenu = menuService.getMenuByUrl("/news/board/" + post.getBoard_seq());
                        if (findPostMenu.size() > 0) {
                            int menuSeq = findPostMenu.get(0).getMn_seq();
                            session.removeAttribute("activeMenu");
                            session.setAttribute("activeMenu", menuSeq);
                            activeMenu = menuSeq;
                        }
                    }
                } else if (url.contains("/certificate/category/list/")) {
                    List<Menu> menu = menuService.getMenuByUrl("/certificate/category");
                    session.removeAttribute("activeMenu");
                    session.setAttribute("activeMenu", menu.get(0).getMn_seq());
                    activeMenu = menu.get(0).getMn_seq();
                } else if (url.contains("/agency/view/")) {
                    List<Menu> menu = menuService.getMenuByUrl("/agency");
                    session.removeAttribute("activeMenu");
                    session.setAttribute("activeMenu", menu.get(0).getMn_seq());
                    activeMenu = menu.get(0).getMn_seq();
                } else if (url.contains("/exam/view/")) {
                    int index = url.lastIndexOf("/");
                    Exam exam = examService.getExamBySeq(Integer.parseInt(url.substring(index + 1)));
                    List<Menu> menu =  new ArrayList<>();
                    if (exam.getExam_type().equals("VN")) {
                        menu = menuService.getMenuByUrl("/exam/vn");
                    }else {
                        menu = menuService.getMenuByUrl("/exam/in");
                    }
                    session.removeAttribute("activeMenu");
                    session.setAttribute("activeMenu", menu.get(0).getMn_seq());
                    activeMenu = menu.get(0).getMn_seq();
                } else {
                    for (Map.Entry<Menu, List<Menu>> entry : menus.entrySet()) {
                        if (url.contains(entry.getKey().getMn_link())) {
                            session.removeAttribute("activeMenu");
                            session.setAttribute("activeMenu", entry.getKey().getMn_seq());
                            activeMenu = entry.getKey().getMn_seq();
                            break;
                        } else {
                            if (entry.getValue().size() > 0) {
                                for (int i = 0; i < entry.getValue().size(); i++) {
                                    if (url.contains(entry.getValue().get(i).getMn_link())) {
                                        session.removeAttribute("activeMenu");
                                        session.setAttribute("activeMenu", entry.getValue().get(i).getMn_seq());
                                        activeMenu = entry.getValue().get(i).getMn_seq();
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (activeMenu != null) {
            Menu menu = menuService.getMenuBySeq(activeMenu);
            if (menu != null) {
                if (menu.getMn_top() == 0) {
                    breadcrumb.getMenuC2().setMn_name_vn(menu.getMn_name_vn());
                    breadcrumb.getMenuC2().setMn_name_en(menu.getMn_name_en());
                    breadcrumb.getMenuC2().setMn_link(menu.getMn_link());
                    breadcrumb.getMenuC2().setMn_seq(menu.getMn_seq());
                } else {
                    breadcrumb.getMenuC3().setMn_name_vn(menu.getMn_name_vn());
                    breadcrumb.getMenuC3().setMn_name_en(menu.getMn_name_en());
                    breadcrumb.getMenuC3().setMn_link(menu.getMn_link());
                    breadcrumb.getMenuC3().setMn_seq(menu.getMn_seq());
                    Menu menuC2 = menuService.getMenuBySeq(menu.getMn_top());
                    breadcrumb.getMenuC2().setMn_name_vn(menuC2.getMn_name_vn());
                    breadcrumb.getMenuC2().setMn_name_en(menuC2.getMn_name_en());
                    breadcrumb.getMenuC2().setMn_link(menuC2.getMn_link());
                    breadcrumb.getMenuC2().setMn_seq(menuC2.getMn_seq());
                }
            }
        }
        model.addAttribute("breadcrumb", breadcrumb);
        model.addAttribute("activeMenu", activeMenu);
        List<Menu> menuSub = new ArrayList<>();
        if (activeMenu != null) {
            Menu menu = menuService.getMenuBySeq(activeMenu);
            model.addAttribute("menuTittle", menu);
            if (menu.getMn_top() == 0) {
                menuSub = menuService.getListMenuByParent(menu);
            } else {
                menuSub = menuService.getListMenuThwart(menu);
            }
        }
        model.addAttribute("menuSub", menuSub);
    }

    public String cutBoard(String url) {
        String arUrl[] = url.split("");
        int indexStart = 0;
        int count = 0;
        for (int i = 0; i < arUrl.length; i++) {
            if (arUrl[i].equals("/")) {
                if (count == 5) {
                    indexStart = i + 1;
                    break;
                } else {
                    count++;
                }
            }
        }
        url = url.substring(indexStart);
        return url;
    }

    /*
     * role : 1 Quyền xem danh sách mục lục bài viết
     * role : 2 Quyền đăng ký/ chỉnh sửa bài viết
     * role : 3 Quyền xem nội dung bài viết
     * role : 4 Quyền xóa bài viết */
    public boolean checkAcceptBoard(int boardSeq, int role) {
        boolean result = false;
        Board board = boardService.getBoardBySeq(boardSeq);
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        if (admin == null) {
            admin = new Admin();
            admin.setAd_role(4);
        }
        if (admin.getAd_role() == 1) {
            result = true;
        } else {
            String roleUser = String.valueOf(admin.getAd_role());
            if (role == 1) {
                String roleViewList = board.getBoard_perm_view_list();
                if (roleViewList.contains(roleUser)) result = true;
            } else if (role == 2) {
                String roleWrite = board.getBoard_perm_write();
                if (roleWrite.contains(roleUser)) result = true;
            } else if (role == 3) {
                String roleRead = board.getBoard_perm_view_post();
                if (roleRead.contains(roleUser)) result = true;
            } else {
                String roleDelete = board.getBoard_perm_delete();
                if (roleDelete.contains(roleUser)) result = true;
            }
        }
        return result;
    }
}
