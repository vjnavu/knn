package vn.gov.knn.admin.admin;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Service
public class AdminService {
    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private FileService fileService;

    public List<Admin> getAdminList(Admin admin) {
        return adminMapper.getAdminList(admin);
    }

    public int countAdmin() {
        return adminMapper.countAdmin();
    }

    public int countAdminPagin(Admin admin) {
        return adminMapper.countAdminPagin(admin);
    }

    public Admin checkPasswordByEmail(Admin adminForm) {
        Admin getAdminResult = adminMapper.getAdminByEmail(adminForm.getAd_email());
        if (getAdminResult != null) {
            if (BCrypt.checkpw(adminForm.getAd_pw(), getAdminResult.getAd_pw())) {
                return getAdminResult;
            } else {
                return null;
            }
        }
        return null;
    }

    public int updateLastLogin(Admin admin) {
        admin.setAd_last_login(new Date());
        return adminMapper.updateLastLogin(admin);
    }

    public int saveNewAdmin(Admin admin) {
        return adminMapper.saveNewAdmin(admin);
    }

    public boolean checkDupEmail(String email) {
        Admin admin = adminMapper.getAdminByEmail(email);
        if (admin == null) return true;
        else return false;
    }

    public Admin getAdminByEmail(String email) {
        return adminMapper.getAdminByEmail(email);
    }

    public int updatePassByEmail(Admin admin) {
        return adminMapper.updatePassByEmail(admin);
    }

    public int saveAdmin(Admin admin, MultipartFile file) throws Exception {
        int savedFileSeq = 1;
        if (file != null) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/admin/");
            fileService.saveFile(file, fileVO);
            savedFileSeq = fileVO.getFile_seq();
        }
        admin.setAd_profile_picture(savedFileSeq);
        return adminMapper.saveNewAdmin(admin);
    }

    public String updateAdmin(RedirectAttributes redirectAttributes, Admin admin) {
        if (admin.getAd_pw() != null && !admin.getAd_pw().equals("")) {
            admin.setAd_pw(BCrypt.hashpw(admin.getAd_pw(), BCrypt.gensalt(12)));
        }
        admin.setAd_mod_dt(new Date());
        if (adminMapper.updateAdmin(admin) == 1) {
            redirectAttributes.addFlashAttribute("successMess", "Cập nhật thành công");
        } else {
            redirectAttributes.addFlashAttribute("errorMess", "Cập nhật thất bại");
        }
        return "redirect:/cms/admin";
    }

    public int updateInfo(Admin admin) {
        return adminMapper.updateInfo(admin);
    }

    public Admin getAdminBySeq(int seq) {
        return adminMapper.getAdminBySeq(seq);
    }

    public int deleteAdmin(Integer adminSeq) throws IOException {
        Admin getAdminInfo = this.getAdminBySeq(adminSeq);
        boolean deleteFile = fileService.deleteFileBySeq(getAdminInfo.getAd_profile_picture());
        return adminMapper.deleteAdmin(adminSeq);
    }

    public int updatePassword(Admin admin) {
        return adminMapper.updatePassword(admin);
    }

    public List<Admin> getAllAdmin() {
        return adminMapper.getAllAdmin();
    }

    public int countTotalAdmin() {
        return adminMapper.countTotalAdmin();
    }

    public int countActiveMember() {
        return adminMapper.countActiveMember();
    }

    public Integer countAdminByStatus(Admin search) {
        return adminMapper.countAdminByStatus(search);
    }

    public int updateLoginFalse(String ad_email) {
        return adminMapper.updateLoginFalse(ad_email);
    }

    public int updateStatus(Admin admin) {
        return adminMapper.updateStatus(admin);
    }

    public int updateNumberLoginFalse(String ad_email) {
        return adminMapper.updateNumberLoginFalse(ad_email);
    }
}
