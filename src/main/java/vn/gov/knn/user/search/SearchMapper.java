package vn.gov.knn.user.search;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SearchMapper {

    List<Search> getSearch(Search search);

    int countSearchResult(Search search);

    int countSearchPost(Search search);

    int countSearchContent(Search search);

    List<Search> getSearchPost(Search search);

    List<Search> getSearchContent(Search search);
}
