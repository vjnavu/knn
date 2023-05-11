package vn.gov.knn.admin.menu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.board.board.Board;
import vn.gov.knn.admin.board.board.BoardService;
import vn.gov.knn.admin.content.Content;
import vn.gov.knn.admin.content.ContentService;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MenuController extends CurrentUser {

    @Autowired
    private MenuService menuService;
    @Autowired
    private ContentService contentService;
    @Autowired
    private BoardService boardService;

    @GetMapping(value = "/cms/menu/search/content")
    @ResponseBody
    public List<Content> conList(
            @RequestParam(value = "keyWord", required = false) String keyWord,
            @RequestParam(value = "size", required = true) Integer size,
            @RequestParam(value = "searchItem", required = false) String searchItem,
            @RequestParam(value = "page", required = false) Integer page) {
        Content content = new Content();
        content.setKeyWord(keyWord);
        content.setSize(size);
        content.setPage(page);
        content.setSearchItem(searchItem);
        Pagination pagination = new Pagination();
        int countContent = contentService.countContent(content);
        String paging =
                pagination
                        .createPagingString(content.getPage(), content.getSize(), countContent)
                        .get("page");
        List<Content> contentList = contentService.getListContent(content);
        ArrayList data = new ArrayList();
        data.add(contentList);
        data.add(paging);
        return data;
    }

    @GetMapping(value = "/cms/menu/search/board")
    @ResponseBody
    public List<Board> searchBoard(
            @RequestParam("keyWord") String keyWord,
            @RequestParam("size") Integer size,
            @RequestParam("searchItem") String searchItem,
            @RequestParam("page") int page) {

        Board searchCate = new Board();
        searchCate.setKeyWord(keyWord);
        searchCate.setSearchItem(searchItem);
        searchCate.setSize(size);
        if (page != 0) {
            searchCate.setPage(page);
        }

        List<Board> listCate = boardService.getBoardList(searchCate);
        Pagination pagination = new Pagination();
        int countCate = boardService.countBoard(searchCate);
        String paging =
                pagination
                        .createPagingString(searchCate.getPage(), searchCate.getSize(), countCate)
                        .get("page");
        ArrayList data = new ArrayList();
        data.add(listCate);
        data.add(paging);
        return data;
    }

    @GetMapping(value = "/cms/menu")
    public String checkMenu(Model model) {
        super.updateRoleSession();
        List<Menu> menus = menuService.getListMenu();
        model.addAttribute("menus", menus);
        return "/vn/admin/menu/view";
    }

    @GetMapping(value = "/cms/menu/new/{menuSeq}")
    public String addSubMenu(
            @PathVariable int menuSeq,
            Model model,
            @ModelAttribute("conSearch") Content conSearch,
            @ModelAttribute("catSearch") Board catSearch) {
        super.updateRoleSession();
        if (menuSeq != 0) {
            Menu menuParent = menuService.getMenuBySeq(menuSeq);
            model.addAttribute("menuParent", menuParent);
        }
        model.addAttribute("menu", new Menu());

        List<Board> cats = boardService.getBoardList(catSearch);
        int totalRow = boardService.countBoard(catSearch);
        Pagination pagination = new Pagination();
        model.addAttribute(
                "pagingCat",
                pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        model.addAttribute("cats", cats);

        List<Content> cons = contentService.getListContent(conSearch);
        int totalRow1 = contentService.countContent(conSearch);
        Pagination pagination1 = new Pagination();
        model.addAttribute(
                "pagingCon",
                pagination1.createPagingString(conSearch.getPage(), conSearch.getSize(), totalRow1));
        model.addAttribute("cons", cons);
        return "/vn/admin/menu/form";
    }

    @GetMapping(value = "/cms/menu/delete/{menuSeq}")
    public String deleteMenu(
            @PathVariable int menuSeq,
            RedirectAttributes redirectAttributes) {
        super.updateRoleSession();
        int delResult = menuService.deleteMenuBySeq(menuSeq);
        if (delResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "xóa thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/menu";
    }

    @GetMapping(value = "/cms/menu/update/{menuSeq}")
    public String updateMenuGet(
            @PathVariable int menuSeq,
            Model model,
            @ModelAttribute("conSearch") Content conSearch,
            @ModelAttribute("catSearch") Board catSearch) {
        super.updateRoleSession();
        Menu menu = menuService.getMenuBySeq(menuSeq);
        if (!menu.getMn_target_blank().equals("Y")) menu.setMn_target_blank_tf(false);
        else menu.setMn_target_blank_tf(true);
        if (!menu.getMn_display_vn().equals("Y")) menu.setMn_display_vn_tf(false);
        else menu.setMn_display_vn_tf(true);
        if (!menu.getMn_display_en().equals("Y")) menu.setMn_display_en_tf(false);
        else menu.setMn_display_en_tf(true);
        model.addAttribute("menu", menu);
        List<Menu> menus = menuService.getListMenuParent();
        model.addAttribute("menus", menus);
        List<Board> cats = boardService.getBoardList(catSearch);
        int totalRow = boardService.countBoard(catSearch);
        Pagination pagination = new Pagination();
        model.addAttribute(
                "pagingCat",
                pagination.createPagingString(catSearch.getPage(), catSearch.getSize(), totalRow));
        model.addAttribute("cats", cats);

        List<Content> cons = contentService.getListContent(conSearch);
        int totalRow1 = contentService.countContent(conSearch);
        Pagination pagination1 = new Pagination();
        model.addAttribute(
                "pagingCon",
                pagination1.createPagingString(conSearch.getPage(), conSearch.getSize(), totalRow1));
        model.addAttribute("cons", cons);

        return "/vn/admin/menu/Uform";
    }

    @PostMapping(value = "/cms/menu/update")
    public String updateMenuPost(
            @ModelAttribute(value = "menu") Menu menu,
            RedirectAttributes redirectAttributes) {
        if (!menu.isMn_target_blank_tf()) menu.setMn_target_blank("N");
        else menu.setMn_target_blank("Y");
        if (!menu.isMn_display_vn_tf()) menu.setMn_display_vn("N");
        else menu.setMn_display_vn("Y");
        if (!menu.isMn_display_en_tf()) menu.setMn_display_en("N");
        else menu.setMn_display_en("Y");
        int upResult = menuService.updateMenu(menu);
        if (upResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/menu";
    }

    @PostMapping(value = "/cms/menu/new")
    public String addMenu(
            @ModelAttribute("menu") Menu menu,
            RedirectAttributes redirectAttributes) {
        if (!menu.isMn_target_blank_tf()) menu.setMn_target_blank("N");
        else menu.setMn_target_blank("Y");
        if (!menu.isMn_display_vn_tf()) menu.setMn_display_vn("N");
        else menu.setMn_display_vn("Y");
        if (!menu.isMn_display_en_tf()) menu.setMn_display_en("N");
        else menu.setMn_display_en("Y");
        int saveResult = menuService.saveMenu(menu);
        if (saveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi");
        }
        return "redirect:/cms/menu";
    }
}
