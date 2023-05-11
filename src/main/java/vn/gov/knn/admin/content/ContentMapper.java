package vn.gov.knn.admin.content;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ContentMapper {
    List<Content> getAllContent(Content content);

    List<Content> getListContent(Content content);

    int countContent(Content content);

    Content getContentBySeq(Integer ctnSeq);

    int saveContent(Content content);

    int updateContent(Content content);

    int deleteContent(Integer ctnSeq);

    int countTotalContent();

    int countActiveContent();
}
