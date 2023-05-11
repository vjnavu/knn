/*
  User: VTA
  Date: 7/22/2021 6:21 PM
*/
package vn.gov.knn.admin.support.captcha;

import nl.captcha.Captcha;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
public class CaptchaImageController {
    private CaptchaUtil captchaUtil;

    @GetMapping("/captcha/loginCaptcha")
    @ResponseBody
    public void loginCaptcha(HttpServletRequest req, HttpServletResponse res) {
        new CaptchaUtil().getImgCaptCha(req, res, "loginCaptcha");
    }

    @GetMapping("/captcha/sign-up")
    @ResponseBody
    public void registerCaptcha(HttpServletRequest req, HttpServletResponse res) {
        new CaptchaUtil().getImgCaptCha(req, res, "sign-up");
    }
    @GetMapping("/captcha/forgot-password")
    @ResponseBody
    public void forgotpasswordCaptcha(HttpServletRequest req, HttpServletResponse res) {
        new CaptchaUtil().getImgCaptCha(req, res, "forgot-password");
    }

    @GetMapping("/captcha/checkAnswer")
    @ResponseBody
    public boolean checkAnswer(@RequestParam Map<String, String> requestParam) {
        boolean result = false;
        String captChaName = requestParam.get("captCha");
        String answer = requestParam.get("answer");
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Captcha captcha = (Captcha) request.getSession().getAttribute(captChaName);

        if (answer != null && !"".equals(answer)) {
            if (captcha.isCorrect(answer)) {
                request.getSession().removeAttribute(captChaName);
                result = true;
            } else {
                result = false;
            }
        }
        return result;
    }
}
