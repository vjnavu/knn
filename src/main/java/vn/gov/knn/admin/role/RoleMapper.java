package vn.gov.knn.admin.role;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RoleMapper {
    List<Role> getListRole();

    List<Role> getRoleC1();

    List<Role> getRoleByRoleC1(int roleSeq);

    boolean updateRole(Role role);

    List<String> getUrlAdmin();

    List<String> getUrlDSD();

    List<String> getUrlNSAO();

    List<Role> getRoleC1ByRole(Role search);

    List<Role> getRoleC2ByRoleUser(Role search);

    List<Role> getListRoleC2();
}
