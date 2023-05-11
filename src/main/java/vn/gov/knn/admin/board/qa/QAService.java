package vn.gov.knn.admin.board.qa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QAService {
    @Autowired
    private QAMapper qaMapper;

    public List<QA> getListQa(QA qa) {
        qa.setOffset((qa.getPage() - 1) * qa.getSize());
        return qaMapper.getListQa(qa);
    }

    public int countQA(QA qa) {
        return qaMapper.countQA(qa);
    }

    public QA getQABySeq(int qaSeq) {
        return qaMapper.getQABySeq(qaSeq);
    }

    public int updateQA(QA qa) {
        return qaMapper.updateQA(qa);
    }

    public List<QA> getQaByLimit(int qaSeq) {
        return qaMapper.getQaByLimit(qaSeq);
    }

    public int saveNewQA(QA qa) {
        return qaMapper.saveNewQA(qa);
    }

    public int countTotalQA() {
        return qaMapper.countTotalQA();
    }

    public int countNonReply() {
        return qaMapper.countNonReply();
    }

    public int deleteQa(Integer qaSeq) {
        return qaMapper.deleteQa(qaSeq);
    }

    public int userUpdateQA(QA qa) {
        return qaMapper.userUpdateQA(qa);
    }

}
