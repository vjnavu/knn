package vn.gov.knn.admin.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

@Service
public class ConfigService {
    @Autowired
    private ConfigMapper configMapper;
    @Autowired
    private FileService fileService;

    public Config getConfig() {
        return configMapper.getConfig();
    }

    public int updateConfig(Config config, MultipartFile configFile) throws Exception {
        Config oldConfig = this.getConfig();
        if (configFile != null && !configFile.isEmpty()) {
            boolean deleteOldFile = fileService.deleteFileBySeq(oldConfig.getConfig_logo());
            FileVO fileVO = new FileVO();
            fileVO.setTarget_dir("/config/");
            fileService.saveFile(configFile, fileVO);
            config.setConfig_logo(fileVO.getFile_seq());
        } else {
            config.setConfig_logo(oldConfig.getConfig_logo());
        }
        return configMapper.updateConfig(config);
    }
}
