package vn.gov.knn.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import vn.gov.knn.admin.board.post.view.CountViewService;
import vn.gov.knn.admin.support.DataProcessing;
import vn.gov.knn.admin.visitor.Visitor;
import vn.gov.knn.admin.visitor.VisitorService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.Date;
import java.util.List;

@Component
public class CustomSessionListner implements HttpSessionListener {
    @Autowired
    private VisitorService visitorService;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private CountViewService countViewService;

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        String url = request.getRequestURL().toString();
        if (!url.contains("/cms/")
                && !request.getRequestURL().toString().contains("/assets/cms")
                && !request.getRequestURL().toString().contains("/cms/sign-in")
                && !request.getRequestURL().toString().contains("/cms/sign-up")
                && !request.getRequestURL().toString().contains("/cms/forgot-password")
                && !request.getRequestURL().toString().contains("/ckfinder/")
                && !request.getRequestURL().toString().contains("/cms/confirm/email")
                && !request.getRequestURL().toString().contains("/code/check")
                && !request.getRequestURL().toString().contains("/content/check/")
                && !request.getRequestURL().toString().contains("/board/check/")
                && !request.getRequestURL().toString().contains("/cms/admin/email/check")
                && !request.getRequestURL().toString().contains("/forgot/email/code")
                && !request.getRequestURL().toString().contains("/forgot/email/confirm")
                && !request.getRequestURL().toString().contains("/cms/vietnam/districtList")
                && !request.getRequestURL().toString().contains("/cms/vietnam/communestList")
                && !request.getRequestURL().toString().contains("/cms/admin/email/check")
                && !request.getRequestURL().toString().contains("/cms/sign-out")) {
            Date currentDate = new Date();
            List<Visitor> visitors = visitorService.getAllVisitor();
            if (visitors.size() == 0) {
                Visitor newVisitor = new Visitor();
                newVisitor.setVs_dt(currentDate);
                newVisitor.setVs_total(1);
                visitorService.saveVisitor(newVisitor);
            } else {
                Visitor lastVisitor = visitorService.getLastVisitor();
                if (DataProcessing.isSameDay(lastVisitor.getVs_dt(), currentDate)) {
                    lastVisitor.setVs_total(lastVisitor.getVs_total() + 1);
                    visitorService.updateVisitor(lastVisitor);
                } else {
                    Visitor newVisitor = new Visitor();
                    newVisitor.setVs_dt(currentDate);
                    newVisitor.setVs_total(1);
                    visitorService.saveVisitor(newVisitor);
                }
            }
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        /*        System.out.println("session Destroyed");
         *//*Xóa bản ghi trong view post *//*
        HttpSession session = request.getSession();
        String id = session.getId();
        countViewService.deleteBySessionId(id);*/
    }
}