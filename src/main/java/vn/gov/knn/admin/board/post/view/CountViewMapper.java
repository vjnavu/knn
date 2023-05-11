package vn.gov.knn.admin.board.post.view;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CountViewMapper {
  CountView getCountView(CountView countView);

  void updateSessionId(CountView countView);

  void saveCountView(CountView countView);

  int deleteBySessionId(String sessionId);
}
