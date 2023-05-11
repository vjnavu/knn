package vn.gov.knn.admin.admin;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
interface AdminMapper {
    List<Admin> getAllAdmin();

    int countAdmin();

    int countAdminPagin(Admin admin);

    Admin getAdminBySeq(int adminSeq);

    int updateLastLogin(Admin admin);

    int saveNewAdmin(Admin admin);

    int updatePassByEmail(Admin admin);

    Admin getAdminByEmail(String email);

    int updateAdmin(Admin admin);

    int updatePassword(Admin admin);

    int updateInfo(Admin admin);

    int deleteAdmin(int adminSeq);

    int countTotalAdmin();

    int countActiveMember();

    List<Admin> getAdminList(Admin admin);

    Integer countAdminByStatus(Admin search);

    int updateLoginFalse(String ad_email);

    int updateStatus(Admin admin);

    int updateNumberLoginFalse(String ad_email);
}
