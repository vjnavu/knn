package vn.gov.knn.user.search;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SearchService {
    @Autowired
    private SearchMapper searchMapper;

    public List<Search> getSearch(Search search) {
        search.setOffset((search.getPage() - 1) * search.getSize());
        return searchMapper.getSearch(search);
    }

    public int countSearchResult(Search search) {
        return searchMapper.countSearchResult(search);
    }

    public int countSearchPost(Search search) {
        return searchMapper.countSearchPost(search);
    }

    public int countSearchContent(Search search) {
        return searchMapper.countSearchContent(search);
    }

    public List<Search> getSearchPost(Search search) {
        search.setOffset((search.getPage() - 1) * search.getSize());
        return searchMapper.getSearchPost(search);
    }

    public List<Search> getSearchContent(Search search) {
        search.setOffset((search.getPage() - 1) * search.getSize());
        return searchMapper.getSearchContent(search);
    }
}
