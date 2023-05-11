package vn.gov.knn.admin.authentication;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.admin.AdminService;
import vn.gov.knn.admin.agency.Agency;
import vn.gov.knn.admin.agency.AgencyService;
import vn.gov.knn.admin.board.post.Post;
import vn.gov.knn.admin.board.post.PostService;
import vn.gov.knn.admin.board.qa.QA;
import vn.gov.knn.admin.board.qa.QAService;
import vn.gov.knn.admin.config.Config;
import vn.gov.knn.admin.config.ConfigService;
import vn.gov.knn.admin.log.signin.Login;
import vn.gov.knn.admin.log.signin.LoginService;
import vn.gov.knn.admin.role.Role;
import vn.gov.knn.admin.role.RoleService;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.DataProcessing;
import vn.gov.knn.admin.visitor.VisitorService;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class AuthenticationController extends CurrentUser {
    @Autowired
    private HttpServletRequest request;

    @Autowired
    private AdminService adminService;

    @Autowired
    private PostService postService;

    @Autowired
    private AgencyService agencyService;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private LoginService loginService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private ConfigService configService;

    @Autowired
    private QAService qaService;

    @Autowired
    private VisitorService visitorService;

    @GetMapping(value = "/cms/sign-in")
    public String LoginGet(
            @ModelAttribute("loginForm") Admin adminInfo,
            Model model) {
        model.addAttribute("checkCfrs","1");
        HttpSession session = request.getSession();
        if (session.getAttribute("CurrentUser") != null) {
            return "redirect:/cms/home";
        } else {
            Config config = configService.getConfig();
            model.addAttribute("emailAdmin", config.getConfig_email());
            return "vn/admin/authentication/sign-in";
        }
    }

    @PostMapping(value = "/cms/sign-in")
    public String LoginPost(
            @ModelAttribute("loginForm") Admin adminInfo,
            Model model,
            HttpServletResponse response,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            BindingResult bindingResult
    ) {
        // Xoa Session truoc do
        request.getSession(false).invalidate();
        Admin getAdmin = new Admin();
        getAdmin = adminService.getAdminByEmail(adminInfo.getAd_email());
        if (getAdmin != null) {
            if ("Y".equals(getAdmin.getAd_status())) {
                getAdmin = adminService.checkPasswordByEmail(adminInfo);
                if (getAdmin != null) {
                    session = request.getSession();
                    session.setAttribute("CurrentUser", getAdmin);
                    List<String> listUrl = roleService.getRoleByAccount(getAdmin.getAd_role());
                    if (listUrl != null) session.setAttribute("listUrl", listUrl);
                    adminService.updateLastLogin(getAdmin);
                    Login logSigin = new Login();
                    logSigin.setLogin_adm(getAdmin.getAd_seq());
                    logSigin.setLogin_dt(new Date());
                    String xForwardedForHeader = request.getHeader("X-Forwarded-For");
                    String ipAddress;
                    if (xForwardedForHeader == null) {
                        ipAddress = request.getRemoteAddr();
                    } else {
                        ipAddress = new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
                    }
                    ipAddress = DataProcessing.getClientIpAddr(request);
                    logSigin.setLogin_ip(ipAddress);

                    // lấy thông tin hệ điều hành và trình duyệt
                    String browserDetails = request.getHeader("User-Agent");
                    String userAgent = browserDetails;
                    String user = userAgent.toLowerCase();

                    String os = "";
                    String browser = "";

                    // =================OS=======================
                    if (userAgent.toLowerCase().indexOf("windows") >= 0) {
                        os = "Windows";
                    } else if (userAgent.toLowerCase().indexOf("mac") >= 0) {
                        os = "Mac";
                    } else if (userAgent.toLowerCase().indexOf("x11") >= 0) {
                        os = "Unix";
                    } else if (userAgent.toLowerCase().indexOf("android") >= 0) {
                        os = "Android";
                    } else if (userAgent.toLowerCase().indexOf("iphone") >= 0) {
                        os = "IPhone";
                    } else {
                        os = "UnKnown, More-Info: " + userAgent;
                    }
                    // ===============Browser===========================
                    if (user.contains("msie")) {
                        String substring = userAgent.substring(userAgent.indexOf("MSIE")).split(";")[0];
                        browser = substring.split(" ")[0].replace("MSIE", "IE") + "-" + substring.split(" ")[1];
                    } else if (user.contains("safari") && user.contains("version")) {
                        browser =
                                (userAgent.substring(userAgent.indexOf("Safari")).split(" ")[0]).split("/")[0]
                                        + "-"
                                        + (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0])
                                        .split("/")[1];
                    } else if (user.contains("opr") || user.contains("opera")) {
                        if (user.contains("opera"))
                            browser =
                                    (userAgent.substring(userAgent.indexOf("Opera")).split(" ")[0]).split("/")[0]
                                            + "-"
                                            + (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0])
                                            .split("/")[1];
                        else if (user.contains("opr"))
                            browser =
                                    ((userAgent.substring(userAgent.indexOf("OPR")).split(" ")[0]).replace("/", "-"))
                                            .replace("OPR", "Opera");
                    } else if (user.contains("edg")) {
                        browser =
                                (userAgent.substring(userAgent.indexOf("Edg")).split(" ")[0]).replace("/", "-");
                    } else if (user.contains("chrome")) {
                        browser =
                                (userAgent.substring(userAgent.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
                    } else if ((user.indexOf("mozilla/7.0") > -1)
                            || (user.indexOf("netscape6") != -1)
                            || (user.indexOf("mozilla/4.7") != -1)
                            || (user.indexOf("mozilla/4.78") != -1)
                            || (user.indexOf("mozilla/4.08") != -1)
                            || (user.indexOf("mozilla/3") != -1)) {
                        browser = "Netscape-?";

                    } else if (user.contains("firefox")) {
                        browser =
                                (userAgent.substring(userAgent.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
                    } else if (user.contains("rv")) {
                        browser = "IE-" + user.substring(user.indexOf("rv") + 3, user.indexOf(")"));
                    } else {
                        browser = "UnKnown, More-Info: " + userAgent;
                    }
                    logSigin.setLogin_os(os);
                    logSigin.setLogin_browser(browser);
                    loginService.saveSignin(logSigin);
                } else {
                    adminService.updateLoginFalse(adminInfo.getAd_email());
                    Admin checkLoginFalse = adminService.getAdminByEmail(adminInfo.getAd_email());
                    Integer failNumber = checkLoginFalse.getAd_login_fail();
                    if(failNumber == 5){
                        checkLoginFalse.setAd_status("N");
                        adminService.updateStatus(checkLoginFalse);
                        redirectAttributes.addFlashAttribute("message","Tài khoản của bạn đã bị khóa do đăng nhập sai quá 5 lần vui lòng liên hệ hotline để được hỗ trợ");
                        return "redirect:/cms/sign-in";
                        /*bindingResult.addError(
                                new FieldError("loginForm", "ad_pw", "Tài khoản của bạn đã bị khóa do đăng nhập sai quá 5 lần vui lòng liên hệ hotline để được hỗ trợ"));*/
                    }else {
                        redirectAttributes.addFlashAttribute("message","Tên đăng nhập hoặc mật khẩu không đúng! Đăng nhập thất bại "+failNumber+" / 5");
                        return "redirect:/cms/sign-in";
                        /*bindingResult.addError(
                                new FieldError("loginForm", "ad_pw", "Tên đăng nhập hoặc mật khẩu không đúng! Đăng nhập thất bại "+failNumber+" / 5"));*/
                    }
                    /*return "/vn/admin/authentication/sign-in";*/
                }
                Map<Role, List<Role>> menus = new LinkedHashMap<>();
                Role search = new Role();
                search.setRole_save(getAdmin.getAd_role());
                List<Role> role1 = roleService.getRoleC1ByRole(search);
                for (Role role : role1) {
                    search.setRole_seq(role.getRole_seq());
                    search.setRole_save(getAdmin.getAd_role());
                    List<Role> role2 = roleService.getRoleC2ByRoleUser(search);
                    if (role2.size() > 0) {
                        menus.put(role, role2);
                    }
                }
                if (getAdmin.getAd_role() == 3) {
                    for (Map.Entry<Role, List<Role>> entry : menus.entrySet()) {
                        for (Role tmp : entry.getValue()) {
                            if (tmp.getRole_seq() == 13) {
                                tmp.setRole_name("Cập Nhật cơ quan");
                                tmp.setRole_url("/cms/agency/update/" + getAdmin.getAd_agency_seq());
                                break;
                            }
                        }
                    }
                }
                session.setAttribute("menus", menus);
                adminService.updateNumberLoginFalse(adminInfo.getAd_email());
                return "redirect:/cms/home";
            } else if ("D".equals(getAdmin.getAd_status())) {
                /*bindingResult.addError(
                        new FieldError("loginForm", "ad_pw", "Tài khoản chưa được phê duyệt"));
                return "/vn/admin/authentication/sign-in";*/
                redirectAttributes.addFlashAttribute("message","Tài khoản chưa được phê duyệt");
                return "redirect:/cms/sign-in";
            } else {
                /*bindingResult.addError(
                        new FieldError("loginForm", "ad_pw", "Tài khoản này tạm thời bị khóa"));
                return "/vn/admin/authentication/sign-in";*/

                redirectAttributes.addFlashAttribute("message","Tài khoản này tạm thời bị khóa");
                return "redirect:/cms/sign-in";
            }
        } else {
            /*bindingResult.addError(
                    new FieldError("loginForm", "ad_pw", "Tên đăng nhập hoặc mật khẩu không đúng"));
            return "/vn/admin/authentication/sign-in";*/
            redirectAttributes.addFlashAttribute("message","Tên đăng nhập hoặc mật khẩu không đúng");
            return "redirect:/cms/sign-in";
        }
    }

    @GetMapping(value = "/cms/sign-out")
    public String LogoutGet(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/cms/sign-in";
    }

    @GetMapping(value = "/cms/sign-up")
    public String RegisterGet(
            @ModelAttribute("registerForm") Admin adminInfo, Model model) {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("CurrentUser");
        List<Agency> agencyList = agencyService.getAllAgency();
        model.addAttribute("agencyList", agencyList);
        if (admin != null) {
            if (admin.getAd_role() == 1 || admin.getAd_role() == 2 || admin.getAd_role() == 3) {
                return "redirect:/cms/home";
            } else {
                return "redirect:/main";
            }
        } else {
            Config config = configService.getConfig();
            model.addAttribute("emailAdmin", config.getConfig_email());
            return "vn/admin/authentication/sign-up";
        }
    }

    @PostMapping(value = "/cms/sign-up")
    public String RegisterPost(
            Model model,
            HttpServletRequest request,
            @ModelAttribute("registerForm") Admin adminRegis,
            @RequestParam("ad_file") MultipartFile file
    )
            throws Exception {
        if (adminService.checkDupEmail(adminRegis.getAd_email())) {
            String savePass = adminRegis.getAd_pw();
            adminRegis.setAd_pw(BCrypt.hashpw(adminRegis.getAd_pw(), BCrypt.gensalt(12)));
            adminRegis.setAd_status("D");
            adminRegis.setAd_reg_dt(new Date());
            if (adminService.saveAdmin(adminRegis, file) > 0) {

//                MimeMessage message = mailSender.createMimeMessage();
//                MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
//                String htmlMsg =
//                        "<div style=\"font-size: 14px; font-family:'Helvetica Neue',Helvetica,Arial,sans-serif\">\n"
//                                + "        <section\n"
//                                + "            style=\"height: 120px;\n"
//                                + "        border-bottom: 1px solid #e5e5e5;\n"
//                                + "        background: #fff url(https://ci3.googleusercontent.com/proxy/zwmcs_krisCqqvdBJny-1mH0rjxB31lnUc14a3DcTWz3mc0VpB0oCty9ytPb2mddPfJgspJpSfmR6FnNvU6Pn5a5wa_kEkTb0mh6P1jUg-GLhKk=s0-d-e1-ft#https://www.koica.go.kr/sites/koica_kr/images/common/bg-mail.jpg);\">\n"
//                                + "            <div style=\"display:table;width: 100%; max-width: 850px; margin: 0 auto; height: 100%;\">\n"
//                                + "                <div style=\"display: table-cell; vertical-align: middle; text-align: center;\">\n"
//                                + "                    <img src=\"http://www.kynangnghe.gov.vn//Upload/Images/Logo/14072020/nl_image_132391634464898604.gif\"\n"
//                                + "                        alt=\"\">\n"
//                                + "                </div>\n"
//                                + "            </div>\n"
//                                + "        </section>\n"
//                                + "        <section style=\"background: #f5f6fa; padding: 70px 0;\">\n"
//                                + "            <div style=\"display: table; width: 100%; max-width: 850px; margin: 0 auto;\">\n"
//                                + "                <div style=\"display: table-cell; vertical-align: middle; padding: 0 40px;\">\n"
//                                + "                    <div style=\"text-align: center; margin: 0 0 30px 0;\">\n"
//                                + "                        <strong style=\"font-weight: normal; font-size: 22px;\">Tạo tài khoản thành công</strong>\n"
//                                + "                    </div>\n"
//                                + "                    <div\n"
//                                + "                        style=\"background: #fff;border: 1px solid #dcdcdc;font-size: 14px;color: #666;padding: 45px;line-height: 1.9;\">\n"
//                                + "                        <p style=\"margin: 0; padding: 0;\">Tạo tài khoản thành công</p>"
//                                + "                        <p style=\"margin: 0; padding: 20px 0 0 0;font-size: 13px; font-weight: bold;\">Email:</p>\n"
//                                + "                        <p style=\"margin: 0;padding: 10px 0 0 0; font-size: 18px; font-weight: bold; color: #009df5;\">\n"
//                                + "                            "
//                                + adminRegis.getAd_email()
//                                + "                        <p style=\"margin: 0; padding: 20px 0 0 0;font-size: 13px; font-weight: bold;\">Mật khẩu:</p>\n"
//                                + "                        <p style=\"margin: 0;padding: 10px 0 0 0; font-size: 18px; font-weight: bold; color: #009df5;\">\n"
//                                + "                            "
//                                + savePass
//                                + "</p>\n"
//                                + "                        <p style=\"font-weight: bold; font-size: 13px;\">Vui lòng không chia sẻ mã xác thực này. Xin cảm ơn !</p>\n"
//                                + "                    </div>\n"
//                                + "                </div>\n"
//                                + "            </div>\n"
//                                + "        </section>\n"
//                                + "        <section style=\"background: #464d5d;padding: 40px 0;line-height: 1.7;\">\n"
//                                + "            <div style=\"display: table;width: 100%;max-width: 850px;margin: 0 auto;\">\n"
//                                + "                <div style=\"display: table-cell;vertical-align: middle; padding: 0 40px;\">\n"
//                                + "                    <p style=\"color: #d6d6d6;font-size: 13px;padding: 10px 140px 10px 0;\">\n"
//                                + "                        ※ Vì e-mail này được gửi tự động nên không thể nhận được thư trả lời ngay cả khi bạn trả lời.\n"
//                                + "                        <br>\n"
//                                + "                        Bản quyền © 2022 bởi VỤ KỸ NĂNG NGHỀ\n"
//                                + "                    </p>\n"
//                                + "                </div>\n"
//                                + "            </div>\n"
//                                + "        </section>\n"
//                                + "    </div>";
//                message.setContent(htmlMsg, "text/html;charset = UTF-8");
//                helper.setTo(adminRegis.getAd_email());
//                helper.setSubject("VỤ KỸ NĂNG NGHỀ");
//                this.mailSender.send(message);
//
//                model.addAttribute(
//                        "message", "Tài khoản đang chờ phê duyệt, vui lòng xác nhận tại gmail của bạn");
//                model.addAttribute("loginForm", new Admin());

                return "vn/admin/authentication/regis-success";
            } else {
                model.addAttribute("registerForm", adminRegis);
                model.addAttribute("message", "Tạo tài khoản thất bại! Liên hệ hotline để được trợ giúp");
                return "vn/admin/authentication/sign-up";
            }
        } else {
            model.addAttribute("message", "Email đã được đăng ký, vui lòng kiểm tra lại");
            model.addAttribute("registerForm", adminRegis);
            return "vn/admin/authentication/sign-up";
        }
    }

    @GetMapping(value = "/cms/forgot-password")
    public String forgotPassword(@ModelAttribute("forgotForm") Admin user,
                                 Model model) {
        HttpSession session = request.getSession();
        if (session.getAttribute("CurrentUser") != null) {
            return "redirect:/cms/home";
        } else {
            Config config = configService.getConfig();
            model.addAttribute("emailAdmin", config.getConfig_email());
            return "vn/admin/authentication/forgot-password";
        }
    }

    @GetMapping(value = "/cms/home")
    public String home(Model model) throws Exception {
        super.updateRoleSession();
        List<Post> posts = postService.getPostByLimit(4);
        List<QA> qas = qaService.getQaByLimit(4);
        Admin search = new Admin();
        search.setAd_status("Y");
        search.setAd_role(2);
        Integer dsd = adminService.countAdminByStatus(search);

        search.setAd_status("Y");
        search.setAd_role(3);
        Integer nsao = adminService.countAdminByStatus(search);

        search.setAd_status("D");
        search.setAd_role(0);
        Integer request = adminService.countAdminByStatus(search);

        search.setAd_role(0);
        search.setAd_status("N");
        Integer block = adminService.countAdminByStatus(search);
        model.addAttribute("qas", qas);
        model.addAttribute("posts", posts);
        model.addAttribute("dsd", dsd);
        model.addAttribute("nsao", nsao);
        model.addAttribute("request", request);
        model.addAttribute("block", block);

        return "vn/admin/home/home";
    }

    @GetMapping(value = "/cms/confirm/email")
    @ResponseBody
    public boolean confirmEmail(
            @RequestParam(value = "email") String email)
            throws MessagingException {
        Admin admin = adminService.getAdminByEmail(email);
        if (admin != null) {
            return false;
        } else {
            String sRandom = DataProcessing.randomString();
            HttpSession session = request.getSession();
            session.setAttribute("confirmEmail", sRandom);
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            String htmlMsg =
                    "<div style=\"font-size: 14px; font-family:'Helvetica Neue',Helvetica,Arial,sans-serif\">\n"
                            + "        <section\n"
                            + "            style=\"height: 120px;\n"
                            + "        border-bottom: 1px solid #e5e5e5;\n"
                            + "        background: #fff url(https://ci3.googleusercontent.com/proxy/zwmcs_krisCqqvdBJny-1mH0rjxB31lnUc14a3DcTWz3mc0VpB0oCty9ytPb2mddPfJgspJpSfmR6FnNvU6Pn5a5wa_kEkTb0mh6P1jUg-GLhKk=s0-d-e1-ft#https://www.koica.go.kr/sites/koica_kr/images/common/bg-mail.jpg);\">\n"
                            + "            <div style=\"display:table;width: 100%; max-width: 850px; margin: 0 auto; height: 100%;\">\n"
                            + "                <div style=\"display: table-cell; vertical-align: middle; text-align: center;\">\n"
                            + "                    <img src=\"http://www.kynangnghe.gov.vn//Upload/Images/Logo/14072020/nl_image_132391634464898604.gif\"\n"
                            + "                        alt=\"\">\n"
                            + "                </div>\n"
                            + "            </div>\n"
                            + "        </section>\n"
                            + "        <section style=\"background: #f5f6fa; padding: 70px 0;\">\n"
                            + "            <div style=\"display: table; width: 100%; max-width: 850px; margin: 0 auto;\">\n"
                            + "                <div style=\"display: table-cell; vertical-align: middle; padding: 0 40px;\">\n"
                            + "                    <div style=\"text-align: center; margin: 0 0 30px 0;\">\n"
                            + "                        <strong style=\"font-weight: normal; font-size: 22px;\">MÃ XÁC THỰC EMAIL</strong>\n"
                            + "                    </div>\n"
                            + "                    <div\n"
                            + "                        style=\"background: #fff;border: 1px solid #dcdcdc;font-size: 14px;color: #666;padding: 45px;line-height: 1.9;\">\n"
                            + "                        <p style=\"margin: 0; padding: 0;\">Xin chào, chúng tôi rất vui khi nhận được yêu cầu xác thực email từ bạn.\n"
                            + "                            bằng email của bạn.</p>"
                            + "                        <p style=\"margin: 0; padding: 20px 0 0 0;font-size: 13px; font-weight: bold;\">Mã xác thực:</p>\n"
                            + "                        <p style=\"margin: 0;padding: 10px 0 0 0; font-size: 18px; font-weight: bold; color: #009df5;\">\n"
                            + "                            "
                            + sRandom
                            + "</p>\n"
                            + "                        <p style=\"font-weight: bold; font-size: 13px;\">Vui lòng không chia sẻ mã xác thực này. Xin cảm ơn !</p>\n"
                            + "                    </div>\n"
                            + "                </div>\n"
                            + "            </div>\n"
                            + "        </section>\n"
                            + "        <section style=\"background: #464d5d;padding: 40px 0;line-height: 1.7;\">\n"
                            + "            <div style=\"display: table;width: 100%;max-width: 850px;margin: 0 auto;\">\n"
                            + "                <div style=\"display: table-cell;vertical-align: middle; padding: 0 40px;\">\n"
                            + "                    <p style=\"color: #d6d6d6;font-size: 13px;padding: 10px 140px 10px 0;\">\n"
                            + "                        ※ Vì e-mail này được gửi tự động nên không thể nhận được thư trả lời ngay cả khi bạn trả lời.\n"
                            + "                        <br>\n"
                            + "                        Bản quyền © 2022 bởi VỤ KỸ NĂNG NGHỀ\n"
                            + "                    </p>\n"
                            + "                </div>\n"
                            + "            </div>\n"
                            + "        </section>\n"
                            + "    </div>";
            message.setContent(htmlMsg, "text/html;charset = UTF-8");
            helper.setTo(email);
            helper.setSubject("VỤ KỸ NĂNG NGHỀ");
            this.mailSender.send(message);
            return true;
        }
    }

    @GetMapping("/code/check")
    @ResponseBody
    public boolean checkCode(
            @RequestParam(value = "code") String code) {
        HttpSession session = request.getSession();
        String realCode = (String) session.getAttribute("confirmEmail");
        if (realCode != null) {
            if (realCode.equals(code)) return true;
            else return false;
        } else return false;
    }

    @GetMapping(value = "/forgot/email/code")
    @ResponseBody
    public boolean checkEmailForgot(
            @RequestParam(value = "email") String email)
            throws MessagingException {
        Admin user = adminService.getAdminByEmail(email);
        if (user == null) {
            return false;
        } else {
            String sRandom = DataProcessing.randomString();
            HttpSession session = request.getSession();
            session.setAttribute("confirmForgotPw", sRandom);
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            String htmlMsg =
                    "<div style=\"font-size: 14px; font-family:'Helvetica Neue',Helvetica,Arial,sans-serif\">\n"
                            + "        <section\n"
                            + "            style=\"height: 120px;\n"
                            + "        border-bottom: 1px solid #e5e5e5;\n"
                            + "        background: #fff url(https://ci3.googleusercontent.com/proxy/zwmcs_krisCqqvdBJny-1mH0rjxB31lnUc14a3DcTWz3mc0VpB0oCty9ytPb2mddPfJgspJpSfmR6FnNvU6Pn5a5wa_kEkTb0mh6P1jUg-GLhKk=s0-d-e1-ft#https://www.koica.go.kr/sites/koica_kr/images/common/bg-mail.jpg);\">\n"
                            + "            <div style=\"display:table;width: 100%; max-width: 850px; margin: 0 auto; height: 100%;\">\n"
                            + "                <div style=\"display: table-cell; vertical-align: middle; text-align: center;\">\n"
                            + "                    <img src=\"http://www.kynangnghe.gov.vn//Upload/Images/Logo/14072020/nl_image_132391634464898604.gif\"\n"
                            + "                        alt=\"\">\n"
                            + "                </div>\n"
                            + "            </div>\n"
                            + "        </section>\n"
                            + "        <section style=\"background: #f5f6fa; padding: 70px 0;\">\n"
                            + "            <div style=\"display: table; width: 100%; max-width: 850px; margin: 0 auto;\">\n"
                            + "                <div style=\"display: table-cell; vertical-align: middle; padding: 0 40px;\">\n"
                            + "                    <div style=\"text-align: center; margin: 0 0 30px 0;\">\n"
                            + "                        <strong style=\"font-weight: normal; font-size: 22px;\">MÃ XÁC THỰC EMAIL</strong>\n"
                            + "                    </div>\n"
                            + "                    <div\n"
                            + "                        style=\"background: #fff;border: 1px solid #dcdcdc;font-size: 14px;color: #666;padding: 45px;line-height: 1.9;\">\n"
                            + "                        <p style=\"margin: 0; padding: 0;\">Xin chào, chúng tôi nhận được yêu cầu\n"
                            + "                            lấy lại mật khẩu của bạn.</p>"
                            + "                        <p style=\"margin: 0; padding: 20px 0 0 0;font-size: 13px; font-weight: bold;\">Mã xác thực:</p>\n"
                            + "                        <p style=\"margin: 0;padding: 10px 0 0 0; font-size: 18px; font-weight: bold; color: #009df5;\">\n"
                            + "                            "
                            + sRandom
                            + "</p>\n"
                            + "                        <p style=\"font-weight: bold; font-size: 13px;\">Vui lòng không chia sẻ mã xác thực này. Xin cảm ơn !</p>\n"
                            + "                    </div>\n"
                            + "                </div>\n"
                            + "            </div>\n"
                            + "        </section>\n"
                            + "        <section style=\"background: #464d5d;padding: 40px 0;line-height: 1.7;\">\n"
                            + "            <div style=\"display: table;width: 100%;max-width: 850px;margin: 0 auto;\">\n"
                            + "                <div style=\"display: table-cell;vertical-align: middle; padding: 0 40px;\">\n"
                            + "                    <p style=\"color: #d6d6d6;font-size: 13px;padding: 10px 140px 10px 0;\">\n"
                            + "                        ※ Vì e-mail này được gửi tự động nên không thể nhận được thư trả lời ngay cả khi bạn trả lời.\n"
                            + "                        <br>\n"
                            + "                        Bản quyền © 2022 bởi VỤ KỸ NĂNG NGHỀ\n"
                            + "                    </p>\n"
                            + "                </div>\n"
                            + "            </div>\n"
                            + "        </section>\n"
                            + "    </div>";
            message.setContent(htmlMsg, "text/html;charset = UTF-8");
            helper.setTo(email);
            helper.setSubject("VỤ KỸ NĂNG NGHỀ");
            this.mailSender.send(message);
            return true;
        }
    }

    @GetMapping("/forgot/email/confirm")
    @ResponseBody
    public boolean checkCodeForgot(
            @RequestParam(value = "codeForgot") String codeForgot) {
        HttpSession session = request.getSession();
        String realCode = (String) session.getAttribute("confirmForgotPw");
        if (realCode.equals(codeForgot)) return true;
        else return false;
    }

    @PostMapping(value = "/cms/forgot-password")
    public String forgotPost(
            Model model,
            @ModelAttribute("forgotForm") Admin adminForm,
            RedirectAttributes redirectAttributes)
            throws MessagingException {
        String sRandom = DataProcessing.randomString();
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
        String htmlMsg =
                "<div style=\"font-size: 14px; font-family:'Helvetica Neue',Helvetica,Arial,sans-serif\">\n"
                        + "        <section\n"
                        + "            style=\"height: 120px;\n"
                        + "        border-bottom: 1px solid #e5e5e5;\n"
                        + "        background: #fff url(https://ci3.googleusercontent.com/proxy/zwmcs_krisCqqvdBJny-1mH0rjxB31lnUc14a3DcTWz3mc0VpB0oCty9ytPb2mddPfJgspJpSfmR6FnNvU6Pn5a5wa_kEkTb0mh6P1jUg-GLhKk=s0-d-e1-ft#https://www.koica.go.kr/sites/koica_kr/images/common/bg-mail.jpg);\">\n"
                        + "            <div style=\"display:table;width: 100%; max-width: 850px; margin: 0 auto; height: 100%;\">\n"
                        + "                <div style=\"display: table-cell; vertical-align: middle; text-align: center;\">\n"
                        + "                    <img src=\"http://www.kynangnghe.gov.vn//Upload/Images/Logo/14072020/nl_image_132391634464898604.gif\"\n"
                        + "                        alt=\"\">\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "        </section>\n"
                        + "        <section style=\"background: #f5f6fa; padding: 70px 0;\">\n"
                        + "            <div style=\"display: table; width: 100%; max-width: 850px; margin: 0 auto;\">\n"
                        + "                <div style=\"display: table-cell; vertical-align: middle; padding: 0 40px;\">\n"
                        + "                    <div style=\"text-align: center; margin: 0 0 30px 0;\">\n"
                        + "                        <strong style=\"font-weight: normal; font-size: 22px;\">Quên Mật Khẩu</strong>\n"
                        + "                    </div>\n"
                        + "                    <div\n"
                        + "                        style=\"background: #fff;border: 1px solid #dcdcdc;font-size: 14px;color: #666;padding: 45px;line-height: 1.9;\">\n"
                        + "                        <p style=\"margin: 0; padding: 0;\">Email của bạn là : \n"
                        + adminForm.getAd_email()
                        + "                            </p>"
                        + "                        <p style=\"margin: 0; padding: 20px 0 0 0;font-size: 13px; font-weight: bold;\">Mật khẩu mới :</p>\n"
                        + "                        <p style=\"margin: 0;padding: 10px 0 0 0; font-size: 18px; font-weight: bold; color: #009df5;\">\n"
                        + "                            "
                        + sRandom
                        + "</p>\n"
                        + "                        <p style=\"font-weight: bold; font-size: 13px;\">Vui lòng không chia sẻ mật khẩu cho bất kỳ ai. Xin cảm ơn !</p>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "        </section>\n"
                        + "        <section style=\"background: #464d5d;padding: 40px 0;line-height: 1.7;\">\n"
                        + "            <div style=\"display: table;width: 100%;max-width: 850px;margin: 0 auto;\">\n"
                        + "                <div style=\"display: table-cell;vertical-align: middle; padding: 0 40px;\">\n"
                        + "                    <p style=\"color: #d6d6d6;font-size: 13px;padding: 10px 140px 10px 0;\">\n"
                        + "                        ※ Vì e-mail này được gửi tự động nên không thể nhận được thư trả lời ngay cả khi bạn trả lời.\n"
                        + "                        <br>\n"
                        + "                        Bản quyền © 2022 bởi VỤ KỸ NĂNG NGHỀ\n"
                        + "                    </p>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "        </section>\n"
                        + "    </div>";
        message.setContent(htmlMsg, "text/html;charset = UTF-8");
        message.setFrom(new InternetAddress("Sender Name" + "<" + "no-reply@domain.com" + ">"));
        helper.setTo(adminForm.getAd_email());
        helper.setSubject("VỤ KỸ NĂNG NGHỀ");
        this.mailSender.send(message);
        adminForm.setAd_pw(BCrypt.hashpw(sRandom, BCrypt.gensalt(12)));
        adminService.updatePassByEmail(adminForm);
        Admin admin = adminService.getAdminByEmail(adminForm.getAd_email());
        admin.setAd_pw(sRandom);
        model.addAttribute("admin", admin);
//        redirectAttributes.addFlashAttribute(
//                "message", "Chúng tôi đã gửi mật khẩu mới cho bạn, vui lòng kiểm tra email");
        return "/vn/admin/authentication/forgot-success";
    }
}
