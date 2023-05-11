package vn.gov.knn.admin.support;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import vn.gov.knn.admin.admin.Admin;
import vn.gov.knn.admin.admin.AdminService;
import vn.gov.knn.admin.role.Role;
import vn.gov.knn.admin.role.RoleService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CurrentUser {
    @Autowired
    public HttpServletRequest request;
    @Autowired
    private RoleService roleService;
    @Autowired
    private AdminService adminService;

    public void sentCurrentUser(Model model) {
        Admin currentUser = (Admin) request.getSession().getAttribute("CurrentUser");
        model.addAttribute("currentUser", currentUser);
    }

    public Admin getCurrentUser() {
        return (Admin) request.getSession().getAttribute("CurrentUser");
    }

    public void updateRoleSession() {
        HttpSession session = request.getSession();
        Admin currentUser = (Admin) session.getAttribute("CurrentUser");
        if (currentUser != null) {
            List<String> listUrl = roleService.getRoleByAccount(currentUser.getAd_role());
            session.removeAttribute("listUrl");
            if (listUrl != null) session.setAttribute("listUrl", listUrl);
        }

        Admin admin = adminService.getAdminBySeq(currentUser.getAd_seq());
        if (admin != null) {
            session.removeAttribute("CurrentUser");
            session.setAttribute("CurrentUser", admin);
        }

        Map<Role, List<Role>> menus = new LinkedHashMap<>();
        Role search = new Role();
        search.setRole_save(currentUser.getAd_role());
        List<Role> role1 = roleService.getRoleC1ByRole(search);
        for (Role role : role1) {
            search.setRole_seq(role.getRole_seq());
            search.setRole_save(currentUser.getAd_role());
            List<Role> role2 = roleService.getRoleC2ByRoleUser(search);
            if (role2.size() > 0) {
                menus.put(role, role2);
            }
        }
        if (currentUser.getAd_role() == 3) {
            for (Map.Entry<Role, List<Role>> entry : menus.entrySet()) {
                for (Role tmp : entry.getValue()) {
                    if (tmp.getRole_seq() == 13) {
                        tmp.setRole_name("Cập Nhật cơ quan");
                        tmp.setRole_url("/cms/agency/update/" + currentUser.getAd_agency_seq());
                        break;
                    }
                }
            }
        }
        session.removeAttribute("menus");
        session.setAttribute("menus", menus);
    }
}
