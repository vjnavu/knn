package vn.gov.knn.admin.content;

import org.jsoup.Jsoup;
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
import java.util.Date;
import java.util.List;

@Controller
public class ContentController extends CurrentUser {

    @Autowired
    private ContentService contentService;

    @Autowired
    private ConfigService configService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private HttpServletRequest request;

    @GetMapping(value = "/cms/content")
    public String getContentList(
            Model model,
            @ModelAttribute("contentSearch") Content content) {
        super.updateRoleSession();
        List<Content> contentList = contentService.getListContent(content);
        int totalRow = contentService.countContent(content);
        int totalContent = contentService.countTotalContent();
        int activeContent = contentService.countActiveContent();
        Pagination pagination = new Pagination();
        model.addAttribute(
                "paging", pagination.createPagingString(content.getPage(), content.getSize(), totalRow));
        model.addAttribute("contentList", contentList);
        model.addAttribute("totalContent", totalContent);
        model.addAttribute("activeContent", activeContent);
        return "/vn/admin/content/list";
    }

    @GetMapping(value = "/cms/content/new")
    public String getNewContent(Model model, @ModelAttribute("contentForm") Content contentForm) {
        super.updateRoleSession();
        this.getFilterWord(model);
        contentForm.setCtn_display_tf(true);
        model.addAttribute("contentForm", contentForm);
        model.addAttribute("formAction", "new");
        return "/vn/admin/content/form";
    }

    @PostMapping(value = "/cms/content/new")
    public String saveNewContent(
            @ModelAttribute("contentForm") Content contentForm,
            RedirectAttributes redirectAttributes) {
        Admin currentUser = (Admin) request.getSession().getAttribute("CurrentUser");
        contentForm.setCtn_reg_dt(new Date());
        contentForm.setCtn_reg_adm(currentUser.getAd_seq());
        if (!contentForm.getCtn_hyper_text_vn().equals(""))
            contentForm.setCtn_text_vn(Jsoup.parse(contentForm.getCtn_hyper_text_vn()).wholeText());
        if (!contentForm.getCtn_hyper_text_en().equals(""))
            contentForm.setCtn_text_en(Jsoup.parse(contentForm.getCtn_hyper_text_en()).wholeText());
        if (!contentForm.isCtn_display_tf()) contentForm.setCtn_display("N");
        else contentForm.setCtn_display("Y");
        contentForm.setCtn_delete("N");
        int contentSaveResult = contentService.saveContent(contentForm);
        if (contentSaveResult > 0) {
            redirectAttributes.addFlashAttribute("successMess", "Thêm bài viết thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi lưu bài viết");
        }
        return "redirect:/cms/content";
    }

    @GetMapping(value = "/cms/content/view/{contentSeq}")
    public String viewContent(@PathVariable Integer contentSeq, Model model) {
        super.updateRoleSession();
        Content contentView = contentService.getContentBySeq(contentSeq);
        model.addAttribute("contentView", contentView);
        return "/vn/admin/content/view";
    }

//    @GetMapping(value = "/cms/content/seq")
//    @ResponseBody
//    public Content getContentBySeq(
//            @RequestParam(value = "contentSeq", required = true) int contentSeq) {
//        return contentService.getContentBySeq(contentSeq);
//    }

    @GetMapping(value = "/cms/content/update/{contentSeq}")
    public String updateGet(@PathVariable int contentSeq, Model model) {
        super.updateRoleSession();
        Content content = contentService.getContentBySeq(contentSeq);
        if (content.getCtn_display().equals("Y")) content.setCtn_display_tf(true);
        else content.setCtn_display_tf(false);
        model.addAttribute("contentForm", content);
        model.addAttribute("formAction", "update");
        return "/vn/admin/content/form";
    }

    @PostMapping(value = "/cms/content/update")
    public String updateContent(
            @ModelAttribute("contentForm") Content content,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {
        Admin currentUser = (Admin) request.getSession().getAttribute("CurrentUser");
        content.setCtn_mod_adm(currentUser.getAd_seq());
        content.setCtn_mod_dt(new Date());
        if (!content.getCtn_hyper_text_vn().equals(""))
            content.setCtn_text_vn(Jsoup.parse(content.getCtn_hyper_text_vn()).wholeText());
        if (!content.getCtn_hyper_text_en().equals(""))
            content.setCtn_text_en(Jsoup.parse(content.getCtn_hyper_text_en()).wholeText());
        if (!content.isCtn_display_tf()) content.setCtn_display("N");
        else content.setCtn_display("Y");
        int contentUpdateResult = contentService.updateContent(content);
        if (contentUpdateResult > 0) {
            redirectAttributes.addFlashAttribute(
                    "successMess", "Chỉnh sửa thông tin bài viết thành công");
        } else {
            redirectAttributes.addFlashAttribute(
                    "errorMess", "Đã xảy ra lỗi khi chỉnh sửa thông tin bài viết");
        }
        return "redirect:/cms/content";
    }

    @GetMapping(value = "/cms/content/delete/{contentSeq}")
    @ResponseBody
    public Boolean deleteContent(
            @PathVariable int contentSeq) {
        super.updateRoleSession();
        int result = contentService.deleteContent(contentSeq);
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    private void getFilterWord(Model model) {
        Config config = configService.getConfig();
        String wordFilter = config.getConfig_block_word();
        if (wordFilter != null) {
            String[] arrFilter = wordFilter.split(",");
            model.addAttribute("wordFilter", arrFilter);
        }
    }

    @GetMapping(value = "/content/check/{contentSeq}")
    @ResponseBody
    public boolean checkUseContent(@PathVariable int contentSeq) {
        boolean check = menuService.ckeckUseContent(contentSeq);
        return check;
    }
}
