package vn.gov.knn.admin.visitor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VisitorService {
    @Autowired
    private VisitorMapper visitorMapper;

    public int saveVisitor(Visitor newVisitor) {
        return visitorMapper.saveVisitor(newVisitor);
    }

    public int deleteVisitorByDate() {
        return visitorMapper.deleteVisitorByDate();
    }

    public int updateVisitor(Visitor update) {
        return visitorMapper.updateVisitor(update);
    }

    public Visitor getLastVisitor() {
        return visitorMapper.getLastVisitor();
    }

    public List<Visitor> getAllVisitor() {
        return visitorMapper.getAllVisitor();
    }

    public List<Visitor> getVisitorList(Visitor visitor){
        return visitorMapper.getVisitorList(visitor);
    }
}
