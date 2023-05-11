package vn.gov.knn.user.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.gov.knn.admin.agency.Agency;
import vn.gov.knn.admin.agency.AgencyService;
import vn.gov.knn.admin.album.Album;
import vn.gov.knn.admin.album.AlbumService;
import vn.gov.knn.admin.board.post.Post;
import vn.gov.knn.admin.board.post.PostService;
import vn.gov.knn.admin.certificate.cert1.Cert1;
import vn.gov.knn.admin.certificate.cert1.Cert1Service;
import vn.gov.knn.admin.exam.Exam;
import vn.gov.knn.admin.exam.ExamService;
import vn.gov.knn.admin.layout.Layout;
import vn.gov.knn.admin.layout.LayoutService;
import vn.gov.knn.admin.support.DataProcessing;
import vn.gov.knn.admin.visitor.VisitorService;
import vn.gov.knn.user.common.CommonService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HomeUController {
    @Autowired
    private CommonService commonService;
    @Autowired
    private LayoutService layoutService;
    @Autowired
    private PostService postService;
    @Autowired
    private Cert1Service cert1Service;
    @Autowired
    private AgencyService agencyService;
    @Autowired
    private VisitorService visitorService;

    @Autowired
    private ExamService examService;

    @Autowired
    private AlbumService albumService;

    @GetMapping(value = "")
    public String home(Model model) {
        commonService.sentInfoWeb(model);
        List<Layout> mvs = layoutService.getAllMVS();
        List<Post> posts = postService.getPostByLimit(3);
        posts = DataProcessing.ckeckNew(posts);
        List<List<Cert1>> cert1s = cert1Service.getCerByNumber(8);
        List<Agency> agencies = agencyService.getAgencyByLimit(4);

        /*List<Post> videos = postService.getVideoByLimit(2);
        List<Post> events = postService.getEventByLimit(2);
        List<Post> devDsd = postService.getDevByLimit(4);*/

        List<Post> videos = postService.getPostbyBoardSeqLimit(2, 2);
        List<Album> events = albumService.getAlbumByLimit(2);
        List<Post> devDsd = postService.getPostbyBoardSeqLimit(5, 4);

        Layout search = new Layout();
        search.setLo_type("CQLQ");
        search.setSize(5);
        List<Layout> concerns = layoutService.getLayoutByTypeLimit(search);
        List<List<Layout>> collabs = layoutService.getLayoutCollab();

        Exam examVn = examService.getExamByLimit(1, "vn");
        Exam examIn = examService.getExamByLimit(1, "in");

        model.addAttribute("mvs", mvs);
        model.addAttribute("posts", posts);
        model.addAttribute("cert1s", cert1s);
        model.addAttribute("agencies", agencies);
        model.addAttribute("videos", videos);
        model.addAttribute("events", events);
        model.addAttribute("devDsd", devDsd);
        model.addAttribute("concerns", concerns);
        model.addAttribute("collabs", collabs);
        model.addAttribute("examVn", examVn);
        model.addAttribute("examIn", examIn);

        return "/vn/user/home/home";
    }

    @PostMapping(value = "/language/change")
    @ResponseBody
    public void changeLanguage(@RequestParam(value = "language") Integer language,
                               HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("language");
        if (language == 1) {
            session.setAttribute("language", "vn");
        } else {
            session.setAttribute("language", "en");
        }
    }
}
