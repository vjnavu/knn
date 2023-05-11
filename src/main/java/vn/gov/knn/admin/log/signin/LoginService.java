package vn.gov.knn.admin.log.signin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoginService {

    @Autowired
    private LoginMapper loginMapper;

    public List<Login> getListSignin(Login logSigin) {
        logSigin.setOffset((logSigin.getPage() - 1) * logSigin.getSize());
        return loginMapper.getListSignin(logSigin);
    }

    public int saveSignin(Login logSigin) {
        return loginMapper.saveSignin(logSigin);
    }

    public int countSign(Login login) {
        return loginMapper.countSign(login);
    }

    public int getNumberOfAccessesToday() {
        return loginMapper.getNumberOfAccessesToday();
    }

    public int getAllNumberOfAccesses() {
        return loginMapper.getAllNumberOfAccesses();
    }

    public List<Login> getAll() {
        return loginMapper.getAll();
    }
}
