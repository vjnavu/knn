package vn.gov.knn.admin.log.signin;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LoginMapper {

    List<Login> getListSignin(Login logSigin);

    int saveSignin(Login logSigin);

    int countSign(Login login);

    int getNumberOfAccessesToday();

    int getAllNumberOfAccesses();

    List<Login> getAll();
}
