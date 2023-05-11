package vn.gov.knn.user.search;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import vn.gov.knn.admin.support.Pagination;
import vn.gov.knn.user.common.CommonService;

import java.util.List;

@Controller
public class SearchController {
    @Autowired
    CommonService commonService;

    @Autowired
    SearchService searchService;

    @GetMapping("/search")
    public String getResultSearch(Model model, @ModelAttribute(value = "generalSearch") Search search) {
        commonService.sentInfoWeb(model);
        List<Search> searchList = searchService.getSearch(search);
        int totalRow = searchService.countSearchResult(search);
        int totalRowPost = searchService.countSearchPost(search);
        int totalRowContent = searchService.countSearchContent(search);
        model.addAttribute("totalRowP", totalRowPost);
        model.addAttribute("totalRowC", totalRowContent);
        model.addAttribute("keyWord", search.getKeyWord());
        model.addAttribute("totalRow", totalRow);
        Pagination pagination = new Pagination();
        model.addAttribute("paging", pagination.createPagingString(search.getPage(), search.getSize(), totalRow));
        int totalPage = 0;
        if (totalRow % 10 == 0) {
            totalPage = (int) totalRow / 10;
        } else {
            totalPage = (int) totalRow / 10 + 1;
        }
        model.addAttribute("page", search.getPage());
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("result", searchList);
        model.addAttribute("type", "all");
        return "/vn/user/search/search";
    }

    @GetMapping("/search/post")
    public String getResultSearchPost(Model model, @ModelAttribute(value = "generalSearch") Search search) {
        commonService.sentInfoWeb(model);
        List<Search> searchListPost = searchService.getSearchPost(search);
        int totalRow = searchService.countSearchResult(search);
        int totalRowPost = searchService.countSearchPost(search);
        int totalRowContent = searchService.countSearchContent(search);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("totalRowP", totalRowPost);
        model.addAttribute("totalRowC", totalRowContent);
        model.addAttribute("keyWord", search.getKeyWord());
        Pagination pagination = new Pagination();
        model.addAttribute("paging", pagination.createPagingString(search.getPage(), search.getSize(), totalRowPost));
        int totalPage = 0;
        if (totalRowPost % 10 == 0) {
            totalPage = (int) totalRowPost / 10;
        } else {
            totalPage = (int) totalRowPost / 10 + 1;
        }
        model.addAttribute("page", search.getPage());
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("result", searchListPost);
        model.addAttribute("type", "post");
        return "/vn/user/search/search";
    }

    @GetMapping("/search/content")
    public String getResultSearchContents(Model model, @ModelAttribute(value = "generalSearch") Search search) {
        commonService.sentInfoWeb(model);
        List<Search> searchListContent = searchService.getSearchContent(search);
        int totalRow = searchService.countSearchResult(search);
        int totalRowPost = searchService.countSearchPost(search);
        int totalRowContent = searchService.countSearchContent(search);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("totalRowP", totalRowPost);
        model.addAttribute("totalRowC", totalRowContent);
        model.addAttribute("keyWord", search.getKeyWord());
        Pagination pagination = new Pagination();
        model.addAttribute("paging", pagination.createPagingString(search.getPage(), search.getSize(), totalRowContent));
        int totalPage = 0;
        if (totalRowContent % 10 == 0) {
            totalPage = (int) totalRowContent / 10;
        } else {
            totalPage = (int) totalRowContent / 10 + 1;
        }
        model.addAttribute("page", search.getPage());
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("result", searchListContent);
        model.addAttribute("type", "content");
        return "/vn/user/search/search";
    }
}
