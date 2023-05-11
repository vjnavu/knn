package vn.gov.knn.admin.board.qa;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QAMapper {
    List<QA> getListQa(QA qa);

    int countQA(QA qa);

    QA getQABySeq(int qaSeq);

    int updateQA(QA qa);

    List<QA> getQaByLimit(int qaSeq);

    int saveNewQA(QA qa);

    int countTotalQA();

    int countNonReply();

    int deleteQa(Integer qaSeq);

    int userUpdateQA(QA qa);

}
