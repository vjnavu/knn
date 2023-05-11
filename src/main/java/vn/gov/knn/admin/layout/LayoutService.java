package vn.gov.knn.admin.layout;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class LayoutService {
    @Autowired
    private FileService fileService;

    @Autowired
    private LayoutMapper layoutMapper;

    public int countLayout(Layout layout) {
        return layoutMapper.countLayout(layout);
    }

    public Layout getLayoutBySeq(Integer layoutSeq) {
        return layoutMapper.getLayoutBySeq(layoutSeq);
    }

    public int saveNewLayout(Layout layout, MultipartFile file) throws Exception {
        int savedFileSeq = 0;
        if (file != null) {
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/layout/" + layout.getLo_type());
            fileService.saveFile(file, fileVO);
            savedFileSeq = fileVO.getFile_seq();
        }
        layout.setLo_img(savedFileSeq);
        return layoutMapper.saveNewLayout(layout);
    }

    public int updateLayout(Layout layout, MultipartFile file) throws Exception {
        Layout getOldLayout = this.getLayoutBySeq(layout.getLo_seq());
        if (file != null && !file.isEmpty()) {
            boolean deleteOldFile = fileService.deleteFileBySeq(getOldLayout.getLo_img());
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/layout/" + getOldLayout.getLo_type());
            fileService.saveFile(file, fileVO);
            layout.setLo_img(fileVO.getFile_seq());
        } else {
            layout.setLo_img(getOldLayout.getLo_img());
        }

        return layoutMapper.updateLayout(layout);
    }

    public int deleteLayout(Integer layoutSeq) throws IOException {
        Layout getLayoutInfo = this.getLayoutBySeq(layoutSeq);
        boolean deleteFile = fileService.deleteFileBySeq(getLayoutInfo.getLo_img());
        return layoutMapper.deleteLayout(layoutSeq);
    }

    public List<Layout> getAllLayout(Layout layoutSearch) {
        return layoutMapper.getAllLayout(layoutSearch);
    }

    public List<Layout> getAllMVS() {
        return layoutMapper.getAllMVS();
    }

    public List<Layout> getLayoutByTypeLimit(Layout search) {
        return layoutMapper.getLayoutByTypeLimit(search);
    }

    public List<List<Layout>> getLayoutCollab() {
        List<List<Layout>> result = new ArrayList<>();
        List<Layout> layouts = layoutMapper.getLayoutCollab();
        List<Layout> tmp = new ArrayList<>();
        for (int i = 0; i < layouts.size(); i++) {
            if (tmp.size() < 8) {
                if (i == layouts.size() - 1) {
                    tmp.add(layouts.get(i));
                    result.add(tmp);
                } else {
                    tmp.add(layouts.get(i));
                }
            } else {
                result.add(tmp);
                tmp = new ArrayList<>();
            }
        }
        return result;
    }
}
