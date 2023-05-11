package vn.gov.knn.admin.file;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Service
public class FileService {
    @Autowired
    private FileMapper fileMapper;

    public FileVO getFileByUuid(String fileUuid) {
        return fileMapper.getFileByUuid(fileUuid);
    }

    public FileVO getFileBySeq(Integer fileSeq) {
        return fileMapper.getFileBySeq(fileSeq);
    }

    public boolean saveMultiFile(MultipartFile[] multipartFiles, FileVO fileVO) throws Exception {
        if (multipartFiles != null) {
            for (MultipartFile file : multipartFiles) {
                if (!file.getOriginalFilename().equals("")) {
                    this.saveFile(file, fileVO);
                }
            }
            return true;
        } else {
            return false;
        }
    }

    public boolean saveFile(MultipartFile file, FileVO fileVO) throws Exception {

        String[] docA = {"hwp", "txt", "pdf", "doc", "docx", "csv", "xls", "xlsx", "ppt", "pptx"};
        String[] imgA = {"jpeg", "jpg", "png", "gif", "bmp"};
        String[] compressA = {"zip", "7z", "gz", "tar", "rar"};
        String[] videoA = {"avi", "mp4", "3gp", "mpeg", "flv"};

        List<String> docList = new ArrayList<>(Arrays.asList(docA));
        List<String> imgList = new ArrayList<>(Arrays.asList(imgA));
        List<String> compressList = new ArrayList<>(Arrays.asList(compressA));
        List<String> video = new ArrayList<>(Arrays.asList(videoA));

        String file_uuid = UUID.randomUUID().toString();
        String file_name = file.getOriginalFilename();
        String file_ext = file_name.substring(file_name.lastIndexOf(".") + 1);
        String file_path = Paths.get("/ky_nang_nghe/", fileVO.getTarget_dir()).normalize().toString();
        int file_size = Math.toIntExact(file.getSize());

        if (docList.contains(file_ext)) {
            fileVO.setFile_type("Document");
        } else if (imgList.contains(file_ext)) {
            fileVO.setFile_type("Image");
        } else if (compressList.contains(file_ext)) {
            fileVO.setFile_type("Compress");
        } else if (compressList.contains(video)) {
            fileVO.setFile_type("Video");
        } else {
            fileVO.setFile_type("Unknown");
        }

        fileVO.setFile_uuid(file_uuid);
        fileVO.setFile_name(file_name);
        fileVO.setFile_ext(file_ext);
        fileVO.setFile_path(file_path);
        fileVO.setFile_size(file_size);
        fileVO.setFile_reg_dtm(new Date());

        boolean saveFiletoDisk = saveFiletoDisk(file, fileVO);
        if (saveFiletoDisk) {
            int saveFiletoDB = fileMapper.saveFile(fileVO);
            if (saveFiletoDB > 0) {
                return true;
            } else {
                System.out.println("Error while save file to DB");
                return false;
            }
        } else {
            return false;
        }
    }

    private boolean saveFiletoDisk(MultipartFile file, FileVO fileVO) throws IOException {
        Path path = Paths.get(fileVO.getFile_path()).toAbsolutePath().normalize();
        Files.createDirectories(path);
        File newFile = new File(fileVO.getFile_path() + "/" + fileVO.getFile_uuid());
        FileOutputStream fileOutputStream = null;
        try {
            fileOutputStream = new FileOutputStream(newFile);
            fileOutputStream.write(file.getBytes());
            try{
                fileOutputStream.close();
            }catch (Exception e){
                System.out.printf("Failed to close File Output Stream");
            }
        } catch (IOException e) {
            System.out.println("Error while save file to disk");
            return false;
        }
        return true;
    }

    public boolean deleteFileBySeq(Integer fileSeq) throws IOException {
        FileVO fileVO = this.getFileBySeq(fileSeq);
        if (fileVO != null) {
            String fileUuid = fileVO.getFile_uuid();
            String filePath = fileVO.getFile_path();
            String sourceFile = Paths.get(filePath, fileUuid).normalize().toString();
            if (Files.deleteIfExists(Paths.get(sourceFile))) {
                fileMapper.deleteFileByUuid(fileUuid);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public boolean deleteFileByUuid(String fileUuid) throws IOException {
        FileVO fileVO = this.getFileByUuid(fileUuid);
        if (fileVO != null) {
            String filePath = fileVO.getFile_path();
            String sourceFile = Paths.get(filePath, fileUuid).normalize().toString();
            if (Files.deleteIfExists(Paths.get(sourceFile))) {
                fileMapper.deleteFileByUuid(fileUuid);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public List<FileVO> getListFileByPostSeq(Integer postSeq) {
        return fileMapper.getListFileByPostSeq(postSeq);
    }

    public boolean deleteFileByPostSeq(Integer postSeq) throws IOException {
        List<FileVO> fileVOList = this.getListFileByPostSeq(postSeq);
        if (fileVOList != null) {
            for (FileVO fileVO : fileVOList) {
                this.deleteFileByUuid(fileVO.getFile_uuid());
            }
            return true;
        } else {
            return false;
        }
    }

    public FileVO getUUIDFileBySeq(Integer fileUuid) {
        return fileMapper.getUUIDFileBySeq(fileUuid);
    }
}
