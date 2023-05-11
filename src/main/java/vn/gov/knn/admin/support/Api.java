/*
  User: VTA
  Date: 7/21/2021 10:54 AM
*/
package vn.gov.knn.admin.support;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Base64;

@Controller
public class Api {
    @GetMapping(value = "/cms/bcrypt")
    @ResponseBody
    String createBcrypt(@RequestParam(value = "encodeString", required = true) String encodeString){
        String encode = BCrypt.hashpw(encodeString, BCrypt.gensalt(12));
        return encode;
    }

    @GetMapping(value = "/cms/randomString")
    @ResponseBody
    String randomString(){
        String inputString = "NguyenDucAnh_ducanh1998";
        String encodedString = Base64.getEncoder().encodeToString(inputString.getBytes());
        return encodedString;
    }
}
