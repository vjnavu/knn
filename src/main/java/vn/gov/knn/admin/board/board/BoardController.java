package vn.gov.knn.admin.board.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.config.Config;
import vn.gov.knn.admin.config.ConfigService;
import vn.gov.knn.admin.menu.MenuService;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class BoardController extends CurrentUser {
    @Autowired
    private HttpServletRequest request;

    @Autowired
    private BoardService boardService;

    @Autowired
    private ConfigService configService;

    @Autowired
    private MenuService menuService;

    @GetMapping(value = "/cms/board")
    public String getBoardList(Model model, @ModelAttribute("categorySearch") Board board) {
        super.updateRoleSession();
        List<Board> boardList = boardService.getBoardList(board);
        int totalRow = boardService.countBoard(board);
        int totalBoard = boardService.countTotalBoard();
        int activeBoard = boardService.countActiveBoard();
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(board.getPage(), board.getSize(), totalRow));
        model.addAttribute("boardList", boardList);
        model.addAttribute("totalBoard", totalBoard);
        model.addAttribute("activeBoard", activeBoard);
        return "/vn/admin/board/board/list";
    }

    @GetMapping(value = "/cms/board/new")
    public String addBoard(Model model, @ModelAttribute ("boardForm") Board boardForm) {
        super.updateRoleSession();
        this.getFilterWordandFileExt(model);
        boardForm.setBoard_display_tf(true);
        model.addAttribute("boardForm", boardForm);
        model.addAttribute("formAction", "new");
        return "/vn/admin/board/board/form";
    }

    @PostMapping(value = "/cms/board/new")
    public String saveNewBoard(
            @ModelAttribute("boardForm") Board board,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        board.setBoard_reg_dt(new Date());
        board.setBoard_reg_adm(admin.getAd_seq());
        board.setBoard_delete("N");
        if (board.isBoard_display_tf()) board.setBoard_display("Y");
        else board.setBoard_display("N");
        int result = boardService.saveBoard(board);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm bảng tin thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi thêm bảng tin");
        }
        return "redirect:/cms/board";
    }

    @GetMapping(value = "/cms/board/update/{boardSeq}")
    public String updateBoardGet(@PathVariable int boardSeq, Model model) {
        super.updateRoleSession();
        Board boardForm = boardService.getBoardBySeq(boardSeq);
        this.getFilterWordandFileExt(model);
        if (boardForm.getBoard_display().equals("N")) boardForm.setBoard_display_tf(false);
        else boardForm.setBoard_display_tf(true);
        model.addAttribute("formAction", "update");
        model.addAttribute("boardForm", boardForm);
        return "/vn/admin/board/board/form";
    }

    @PostMapping(value = "/cms/board/update")
    public String updateBoard(
            RedirectAttributes redirectAttributes,
            @ModelAttribute("boardForm") Board board,
            HttpServletRequest request) {
        if (board.isBoard_display_tf()) board.setBoard_display("Y");
        else board.setBoard_display("N");
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        board.setBoard_mod_adm(admin.getAd_seq());
        board.setBoard_mod_dt(new Date());
        int result = boardService.updateBoard(board);
        if (result > 0) {
            redirectAttributes.addFlashAttribute(
                    "successMess", "Chỉnh sửa thông tin bảng tin thành công");
        } else {
            redirectAttributes.addFlashAttribute(
                    "errorMess", "Đã xảy ra lỗi khi chỉnh sửa thông tin bảng tin");
        }
        return "redirect:/cms/board";
    }

    private void getFilterWordandFileExt(Model model) {
        Config config = configService.getConfig();
        String wordFilter = config.getConfig_block_word();
        if (wordFilter != null) {
            String[] arrFilter = wordFilter.split(",");
            model.addAttribute("wordFilter", arrFilter);
        }
    }

    @GetMapping(value = "/cms/board/delete/{boardSeq}")
    @ResponseBody
    public Boolean deleteBoard(@PathVariable int boardSeq) {
        super.updateRoleSession();
        int delResult = boardService.deleteBoard(boardSeq);
        if (delResult > 0) {
            return true;
        } else {
            return false;
        }
    }

    @GetMapping(value = "/board/check/{boardSeq}")
    @ResponseBody
    public boolean checkUseBoard(@PathVariable int boardSeq) {
        boolean check = menuService.ckeckUseBoard(boardSeq);
        return check;
    }
}
