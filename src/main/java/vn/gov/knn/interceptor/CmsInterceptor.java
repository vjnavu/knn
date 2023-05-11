package vn.gov.knn.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.menu.Menu;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Component
public class CmsInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        String language = (String) request.getSession().getAttribute("language");
        if(language == null){
            request.removeAttribute("language");
            request.setAttribute("language","vn");
        }
        Admin currentUser = (Admin) session.getAttribute("CurrentUser");
        String url = request.getRequestURL().toString();
        List<String> acceptUrl = (List<String>) session.getAttribute("listUrl");
        boolean result = true;

        Map<Menu, List<Menu>> menus = (Map<Menu, List<Menu>>) session.getAttribute("menuHome");
        if (menus != null && !url.contains("/cms/")
                && !request.getRequestURL().toString().contains("/assets/cms")
                && !request.getRequestURL().toString().contains("/cms/sign-in")
                && !request.getRequestURL().toString().contains("/cms/sign-up")
                && !request.getRequestURL().toString().contains("/cms/forgot-password")
                && !request.getRequestURL().toString().contains("/ckfinder/")
                && !request.getRequestURL().toString().contains("/cms/confirm/email")
                && !request.getRequestURL().toString().contains("/code/check")
                && !request.getRequestURL().toString().contains("/content/check/")
                && !request.getRequestURL().toString().contains("/board/check/")
                && !request.getRequestURL().toString().contains("/cms/admin/email/check")
                && !request.getRequestURL().toString().contains("/forgot/email/code")
                && !request.getRequestURL().toString().contains("/forgot/email/confirm")
                && !request.getRequestURL().toString().contains("/cms/vietnam/districtList")
                && !request.getRequestURL().toString().contains("/cms/vietnam/communestList")
                && !request.getRequestURL().toString().contains("/cms/admin/email/check")
                && !request.getRequestURL().toString().contains("/cms/sign-out")
                && !request.getRequestURL().toString().contains("/assets/user")
                && !request.getRequestURL().toString().contains("/jarvis/file")
        ) {
            for (Map.Entry<Menu, List<Menu>> entry : menus.entrySet()) {
                String urlCut = this.cutUrl(url);
                if (urlCut.equals(entry.getKey().getMn_link())) {
                    session.removeAttribute("activeMenu");
                    session.setAttribute("activeMenu", entry.getKey().getMn_seq());
                    break;
                } else {
                    if (entry.getValue().size() > 0) {
                        for (int i = 0; i < entry.getValue().size(); i++) {
                            if (urlCut.equals(entry.getValue().get(i).getMn_link())) {
                                session.removeAttribute("activeMenu");
                                session.setAttribute("activeMenu", entry.getValue().get(i).getMn_seq());
                                break;
                            }
                        }
                    }
                }
            }
        }

        if (url.contains("/cms/")
                && !request.getRequestURL().toString().contains("/assets/cms")
                && !request.getRequestURL().toString().contains("/cms/sign-in")
                && !request.getRequestURL().toString().contains("/cms/sign-up")
                && !request.getRequestURL().toString().contains("/cms/forgot-password")
                && !request.getRequestURL().toString().contains("/ckfinder/")
                && !request.getRequestURL().toString().contains("/cms/confirm/email")
                && !request.getRequestURL().toString().contains("/code/check")
                && !request.getRequestURL().toString().contains("/content/check/")
                && !request.getRequestURL().toString().contains("/board/check/")
                && !request.getRequestURL().toString().contains("/cms/admin/email/check")
                && !request.getRequestURL().toString().contains("/forgot/email/code")
                && !request.getRequestURL().toString().contains("/forgot/email/confirm")
                && !request.getRequestURL().toString().contains("/cms/vietnam/districtList")
                && !request.getRequestURL().toString().contains("/cms/vietnam/communestList")
                && !request.getRequestURL().toString().contains("/cms/admin/email/check")
                && !request.getRequestURL().toString().contains("/cms/sign-out")
        ) {
            if (currentUser == null) {
                response.sendRedirect("/cms/sign-in");
                result = false;
            } else {
                Integer role = currentUser.getAd_role();
                if (role != 1 && role != 2 && role != 3) {
                    this.redirectWithAlert(
                            request,
                            response,
                            "Tài Khoản này không được phép truy cập trang quản lý. Vui lòng liên hệ hotline.",
                            "/cms/sign-in");
                    request.getSession().invalidate();
                    result = false;
                } else {
                    if (url.contains("/cms/home") || url.contains("/cms/admin/info") || url.contains("/cms/admin/password/change")) {
                        result = true;
                    } else {
                        if (currentUser.getAd_role() == 3 && url.contains("/cms/agency") && !url.contains("/cms/agency/update")) {
                            this.redirectWithAlert(
                                    request,
                                    response,
                                    "Tài khoản của bạn chưa được cấp phép sử dụng chức năng này",
                                    "/cms/agency/update/" + currentUser.getAd_agency_seq());
                            result = false;
                        } else {
                            if (checkMatcher(acceptUrl, url) || url.contains("/cms/visitor/chart")) {
                                result = true;
                            } else {
                                this.redirectWithAlert(
                                        request,
                                        response,
                                        "Tài khoản của bạn chưa được cấp phép sử dụng chức năng này",
                                        "-1");
                                result = false;
                            }
                        }

                    }
                }
            }
        } else {
            result = true;
        }
        return result;
    }

    @Override
    public void postHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler,
            ModelAndView modelAndView)
            throws Exception {
    }

    @Override
    public void afterCompletion(
            HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    }

    private void redirectWithAlert(
            HttpServletRequest request, HttpServletResponse response, String alert, String redirectUrl)
            throws Exception {
        FlashMap flashMap = new FlashMap();
        if (alert != null && !alert.equals("")) {
            flashMap.put("alert", alert);
        }
        FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
        flashMapManager.saveOutputFlashMap(flashMap, request, response);
        if (redirectUrl.equals("-1")) {
            String requestHeader = request.getHeader("Referer");
            requestHeader = requestHeader.replaceAll("\n","");
            requestHeader = requestHeader.replaceAll("\r","");
            response.sendRedirect(requestHeader);
        } else {
            response.sendRedirect(redirectUrl);
        }
    }

    private static boolean checkMatcher(List<String> urlMatcher, String url) {
        boolean result = false;
        for (int i = 0; i < urlMatcher.size(); i++) {
            if (url.contains(urlMatcher.get(i).trim()) && !urlMatcher.get(i).equals("")) {
                result = true;
                break;
            }
        }
        return result;
    }

    public String cutUrl(String url) {
        String arUrl[] = url.split("");
        int index = 0;
        int count = 0;
        for (int i = 0; i < arUrl.length; i++) {
            if (arUrl[i].equals("/")) {
                if (count == 2) {
                    index = i;
                    break;
                } else {
                    count++;
                }
            }
        }
        url = url.substring(index);
        /*System.out.println(url);*/
        return url;
    }

}
