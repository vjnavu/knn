package vn.gov.knn.admin.role;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.gov.knn.admin.support.CurrentUser;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RoleController extends CurrentUser {
    @Autowired
    private RoleService roleService;

    @GetMapping(value = "/cms/role")
    public String getListRole(Model model) {
        Map<Role, List<Role>> roles = new LinkedHashMap<>();
        List<Role> role1 = roleService.getRoleC1();
        String dsd = "";
        String nsao = "";
        for (Role role : role1) {
            List<Role> role2 = roleService.getRoleByRoleC1(role.getRole_seq());
            for (Role re : role2) {
                if (re.getRole_dsd_yn().equals("Y")) {
                    if (dsd.equals("")) dsd = String.valueOf(re.getRole_seq());
                    else dsd = dsd + "," + String.valueOf(re.getRole_seq());
                }
                if (re.getRole_nsao_yn().equals("Y")) {
                    if (nsao.equals("")) nsao = String.valueOf(re.getRole_seq());
                    else nsao = nsao + "," + String.valueOf(re.getRole_seq());
                }
            }
            roles.put(role, role2);
        }
        model.addAttribute("roles", roles);
        model.addAttribute("roleForm", new Role());
        model.addAttribute("dsd", dsd);
        model.addAttribute("nsao", nsao);
        return "/vn/admin/role/role";
    }

    @GetMapping(value = "/cms/role/update")
    @ResponseBody
    public boolean updateRole(@RequestParam("dsd[]") int[] dsd,
                              @RequestParam("nsao[]") int[] nsao) {
        List<Role> list = roleService.getListRoleC2();
        for (Role role : list) {
            if (ArrayUtils.contains(dsd, role.getRole_seq())) {
                role.setRole_dsd_yn("Y");
            } else {
                role.setRole_dsd_yn("N");
            }
            if (ArrayUtils.contains(nsao, role.getRole_seq())) {
                role.setRole_nsao_yn("Y");
            } else {
                role.setRole_nsao_yn("N");
            }
        }
        boolean update = roleService.updateRole(list);
        if (update) super.updateRoleSession();
        return update;
    }
}
