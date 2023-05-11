package vn.gov.knn.admin.exam;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ExamMapper {
    List<Exam> getListExam(Exam exam);

    int countExam(Exam exam);

    int saveNewExam(Exam exam);

    Exam getExamBySeq(int examSeq);

    int deleteExam(int examSeq);

    int updateExam(Exam exam);

    List<Exam> getAllExam();

    List<Exam> getListExamByExamType(Exam exam);

    Exam getExamByLimit(int limit, String type);
}
