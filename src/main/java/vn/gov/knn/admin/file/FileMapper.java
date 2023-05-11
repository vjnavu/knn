package vn.gov.knn.admin.file;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FileMapper {
    FileVO getFileByUuid(String fileUuid);

    FileVO getFileBySeq(Integer fileSeq);

    int saveFile(FileVO fileVO);

    int deleteFileByUuid(String fileUuid);

    List<FileVO> getListFileByPostSeq(Integer postSeq);

    FileVO getUUIDFileBySeq(Integer fileUuid);
}
