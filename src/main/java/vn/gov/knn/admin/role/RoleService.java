package vn.gov.knn.admin.role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class RoleService {
    @Autowired
    private RoleMapper roleMapper;

    public List<Role> getListRole() {
        return roleMapper.getListRole();
    }

    public List<Role> getRoleC1() {
        return roleMapper.getRoleC1();
    }

    public List<Role> getRoleByRoleC1(int roleSeq) {
        return roleMapper.getRoleByRoleC1(roleSeq);
    }

    public boolean updateRole(List<Role> roles) {
        boolean result = true;
        for (Role role : roles) {
            if (!roleMapper.updateRole(role)) {
                result = false;
                break;
            }
        }
        return result;
    }

    public List<String> getRoleByAccount(int ad_role) {
        List<String> listUrl = new ArrayList<>();
        if (ad_role == 1) {
            listUrl = roleMapper.getUrlAdmin();

        } else if (ad_role == 2) {
            listUrl = roleMapper.getUrlDSD();
        } else {
            listUrl = roleMapper.getUrlNSAO();
        }
        return listUrl;
    }

    public List<Role> getRoleC1ByRole(Role search) {
        return roleMapper.getRoleC1ByRole(search);
    }

    public List<Role> getRoleC2ByRoleUser(Role search) {
        return roleMapper.getRoleC2ByRoleUser(search);
    }

    public List<Role> getListRoleC2() {
        return roleMapper.getListRoleC2();
    }
}
