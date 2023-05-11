package vn.gov.knn.admin.code;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.support.CurrentUser;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CodeController extends CurrentUser {
    @Autowired
    private CodeService codeService;

    @GetMapping(value = "/cms/code")
    public String getCodeList(Model model) {
        super.updateRoleSession();
        Map<Code, Map<Code, List<Code>>> codes = new LinkedHashMap<>();
        Code search = new Code();
        search.setCode_top1(0);
        search.setCode_top2(0);
        List<Code> code1s = codeService.getCodeByCodeTop(search);
        for (Code code : code1s) {
            search.setCode_top1(code.getCode_seq());
            search.setCode_top2(0);
            List<Code> code2s = codeService.getCodeByCodeTop(search);
            Map<Code, List<Code>> tmp = new LinkedHashMap<>();
            for (Code code2 : code2s) {
                search.setCode_top1(code.getCode_seq());
                search.setCode_top2(code2.getCode_seq());
                List<Code> code3s = codeService.getCodeByCodeTop(search);
                tmp.put(code2, code3s);
            }
            codes.put(code, tmp);
        }
        model.addAttribute("codes", codes);
        return "/vn/admin/code/list";
    }


    @GetMapping(value = "/cms/code/{codeId}")
    @ResponseBody
    public ResponseEntity<Map> getCodeDetail(@PathVariable String codeId){
        HashMap<String, Object> hashMap = new HashMap<>();
        HashMap codeDetail = codeService.getCodeById(codeId);
        if(codeDetail == null){
            hashMap.put("status","204");
            hashMap.put("message","Code không tồn tại");
        }else{
            hashMap.put("status","200");
            hashMap.put("message","Success");
            hashMap.put("code",codeDetail);
        }
        return new ResponseEntity(hashMap, HttpStatus.OK);
    }

    @GetMapping(value = "/cms/code/new-api/group")
    @ResponseBody
    public ResponseEntity<Map> saveNewGroupCode(@RequestParam("codeName") String codeName, @RequestParam("codeDesc") String codeDesc){
        HashMap<String, String> hashMap = new HashMap<>();
        int checkDuplicateCodeName = codeService.checkDuplicateCode(codeName);
        if(checkDuplicateCodeName > 0){
            hashMap.put("status","204");
            hashMap.put("message","Tên code "+ codeName +" đã tồn tại");
        }else{
            Code code = new Code();
            code.setCode_name(codeName);
            code.setCode_desc(codeDesc);
            int newGroupCode = codeService.addCode(code);
            if(newGroupCode > 0){
                hashMap.put("status","200");
                hashMap.put("message","Success");
            }else{
                hashMap.put("status","204");
                hashMap.put("message","Đã xảy ra lỗi khi thêm code");
            }
        }
        return new ResponseEntity(hashMap, HttpStatus.OK);
    }

    @GetMapping(value = "/cms/code/new-api/top1")
    @ResponseBody
    public ResponseEntity<Map> saveNewCodeTop1(@RequestParam("codeTop1Seq") String codeTop1Seq,@RequestParam("codeTop1Id") String codeTop1Id, @RequestParam("codeName") String codeName){
        HashMap<String, String> hashMap = new HashMap<>();

        int checkDuplicateCodeName = codeService.checkDuplicateCode(codeName);
        if(checkDuplicateCodeName > 0){
            hashMap.put("status","204");
            hashMap.put("message","Tên code "+ codeName +" đã tồn tại");
        }else{
            int newCodeTop1 = codeService.newCodeTop1(codeTop1Seq, codeTop1Id, codeName);
            if(newCodeTop1 > 0){
                hashMap.put("status","200");
                hashMap.put("message","Success");
            }else{
                hashMap.put("status","204");
                hashMap.put("message","Đã xảy ra lỗi khi thêm code");
            }
        }
        return new ResponseEntity(hashMap, HttpStatus.OK);
    }

    @GetMapping(value = "/cms/code/new-api/top2")
    @ResponseBody
    public ResponseEntity<Map> saveNewCodeTop2(
            @RequestParam("codeTop1Seq") String codeTop1Seq
            ,@RequestParam("codeTop2Seq") String codeTop2Seq
            ,@RequestParam("codeTop1Id") String codeTop2Id
            , @RequestParam("codeName") String codeName){
        HashMap<String, String> hashMap = new HashMap<>();

        int checkDuplicateCodeName = codeService.checkDuplicateCode(codeName);
        if(checkDuplicateCodeName > 0){
            hashMap.put("status","204");
            hashMap.put("message","Tên code "+ codeName +" đã tồn tại");
        }else{
            int newCodeTop1 = codeService.newCodeTop2(codeTop1Seq, codeTop2Seq, codeTop2Id, codeName);
            if(newCodeTop1 > 0){
                hashMap.put("status","200");
                hashMap.put("message","Success");
            }else{
                hashMap.put("status","204");
                hashMap.put("message","Đã xảy ra lỗi khi thêm code");
            }
        }
        return new ResponseEntity(hashMap, HttpStatus.OK);
    }

    @GetMapping(value = "/cms/code/edit-api")
    @ResponseBody
    public ResponseEntity<Map> editCode(@RequestParam("codeId") String codeId, @RequestParam("codeName") String codeName,  @RequestParam("codeDesc") String codeDesc){
        HashMap<String, String> hashMap = new HashMap<>();

        int checkDuplicateCodeName = codeService.checkDuplicateCode2(codeId, codeName);
        if(checkDuplicateCodeName > 0){
            hashMap.put("status","204");
            hashMap.put("message","Tên code "+ codeName +" đã tồn tại");
        }else{
            int updateResult = codeService.updateCodeName(codeId, codeName, codeDesc);
            if(updateResult > 0){
                hashMap.put("status","200");
                hashMap.put("message","Success");
            }else{
                hashMap.put("status","204");
                hashMap.put("message","Đã có lỗi khi cập nhật tên code"+ codeName);
            }
        }
        return new ResponseEntity(hashMap, HttpStatus.OK);
    }

    @GetMapping(value = "/cms/code/delete-api")
    @ResponseBody
    public ResponseEntity<Map> deleteCode(@RequestParam("codeId") String codeId){
        HashMap<String, String> hashMap = new HashMap<>();

        int deleteCode = codeService.deleteCode(codeId);
        if(deleteCode > 0){
            hashMap.put("status","200");
            hashMap.put("message","Success");
        }else{
            hashMap.put("status","204");
            hashMap.put("message","Đã xảy ra lỗi khi xoá Code");
        }
        return new ResponseEntity(hashMap, HttpStatus.OK);
    }


    @GetMapping(value = "/cms/code/new")
    public String addCodeG(Model model) {
        super.updateRoleSession();
        model.addAttribute("code", new Code());
        return "/vn/admin/code/form";
    }
    @PostMapping(value = "/cms/code/new")
    public String addCodeP(@ModelAttribute(value = "code") Code code,
                           RedirectAttributes redirectAttributes) {
        int checkDuplicateCodeName = codeService.checkDuplicateCode(code.getCode_name());
        if(checkDuplicateCodeName > 0){
            redirectAttributes.addFlashAttribute("errorMess", "Lỗi: Trùng tên code");
            return "redirect:/cms/code/new";
        }else{
            int saveResult = codeService.addCode(code);
            if (saveResult > 0) {
                redirectAttributes.addFlashAttribute("successMess", "Thêm mới thành công!");
                return "redirect:/cms/code";
            } else {
                redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi thêm mới thông tin");
                return "redirect:/cms/code/new";
            }
        }

    }
}
