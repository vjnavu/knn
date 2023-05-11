package vn.gov.knn.admin.visitor;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface VisitorMapper {
    List<Visitor> getAllVisitor();

    List<Visitor> getVisitorList(Visitor visitor);

    int saveVisitor(Visitor newVisitor);

    int updateVisitor(Visitor update);

    int deleteVisitorByDate();

    Visitor getLastVisitor();
}
