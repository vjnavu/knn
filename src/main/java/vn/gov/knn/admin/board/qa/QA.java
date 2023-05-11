package vn.gov.knn.admin.board.qa;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class QA extends Paging {
    private int qa_seq;
    private String qa_title;
    private String qa_email;
    private String qa_question;
    private Date qa_question_dt;
    private String qa_answer;
    private int qa_answer_adm;
    private Date qa_answer_dt;
    private String qa_password;
    private String qa_type;

    private String admin_email;
}
