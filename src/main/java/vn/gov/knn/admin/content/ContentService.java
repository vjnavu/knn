package vn.gov.knn.admin.content;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.admin.AdminService;

import java.util.List;

@Service
public class ContentService {

    @Autowired
    private ContentMapper contentMapper;
    @Autowired
    private AdminService adminService;

    public List<Content> getAllContent(Content content) {
        return contentMapper.getAllContent(content);
    }


    public List<Content> getListContent(Content content) {
        return contentMapper.getListContent(content);
    }

    public Content getContentBySeq(Integer ctnSeq) {
        Content content = contentMapper.getContentBySeq(ctnSeq);
        if (content.getCtn_mod_adm() != 0) {
            Admin admin = adminService.getAdminBySeq(content.getCtn_mod_adm());
            content.setCtn_mod_email(admin.getAd_email());
        }
        return content;
    }

    public int countContent(Content content) {
        return contentMapper.countContent(content);
    }

    public int saveContent(Content content) {
        return contentMapper.saveContent(content);
    }

    public int updateContent(Content content) {
        return contentMapper.updateContent(content);
    }

    public int deleteContent(Integer ctnSeq) {
        return contentMapper.deleteContent(ctnSeq);
    }

    public int countTotalContent() {
        return contentMapper.countTotalContent();
    }

    public int countActiveContent() {
        return contentMapper.countActiveContent();
    }
}
