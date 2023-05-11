package vn.gov.knn.admin.layout;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LayoutMapper {

    List<Layout> getAllLayout(Layout layoutSearch);

//    List<Layout> getLayoutByLimit(int limit);

    int countLayout(Layout layout);

    Layout getLayoutBySeq(Integer layoutSeq);

    int updateLayout(Layout layout);

    int saveNewLayout(Layout layout);

    int deleteLayout(Integer layoutSeq);

    List<Layout> getAllMVS();

    List<Layout> getLayoutByTypeLimit(Layout search);

    List<Layout> getLayoutCollab();
}
