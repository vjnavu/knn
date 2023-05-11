package vn.gov.knn.admin.code;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class CodeService {
    @Autowired
    private CodeMapper codeMapper;

    public int checkDuplicateCode(String codeName){
        return codeMapper.checkDuplicateCode(codeName);
    }
    public int checkDuplicateCode2(String codeId, String codeName){
        return codeMapper.checkDuplicateCode2(codeId, codeName);
    }

    public int updateCodeName(String codeId, String codeName, String codeDesc){
        return codeMapper.updateCodeName(codeId, codeName, codeDesc);
    }
    public int deleteCode(String codeId){
        return codeMapper.deleteCode(codeId);
    }

    public int newCodeTop1(String codeTop1Seq,String codeTop1Id, String codeName){
        Code code = new Code();
        code.setCode_name(codeName);
        code.setCode_reg_dt(new Date());
        code.setCode_top1(Integer.parseInt(codeTop1Seq));
        code.setCode_top2(0);
        code.setCode_id(this.genSeq(codeTop1Id,Integer.parseInt(codeTop1Seq),0));

        int saveCode = codeMapper.addCode(code);
        while (saveCode <= 0) {
            code.setCode_id(this.genSeq(codeTop1Id,Integer.parseInt(codeTop1Seq),0));
            saveCode = codeMapper.addCode(code);
        }
        return saveCode;
    }

    public int newCodeTop2(String codeTop1Seq,String codeTop2Seq,String codeTop2Id, String codeName){
        Code code = new Code();
        code.setCode_name(codeName);
        code.setCode_reg_dt(new Date());
        code.setCode_top1(Integer.parseInt(codeTop1Seq));
        code.setCode_top2(Integer.parseInt(codeTop2Seq));
        code.setCode_id(this.genSeq(codeTop2Id,Integer.parseInt(codeTop1Seq),Integer.parseInt(codeTop2Seq)));

        int saveCode = codeMapper.addCode(code);
        while (saveCode <= 0) {
            code.setCode_id(this.genSeq(codeTop2Id,Integer.parseInt(codeTop1Seq),Integer.parseInt(codeTop2Seq)));
            saveCode = codeMapper.addCode(code);
        }
        return saveCode;
    }

    public int addCode(Code code) {
        code.setCode_reg_dt(new Date());
        code.setCode_top1(0);
        code.setCode_top2(0);
        code.setCode_id(this.genSeq("CO",0,0));
        int saveCode = codeMapper.addCode(code);
        while (saveCode <= 0) {
            code.setCode_id(this.genSeq("CO",0,0));
            saveCode = codeMapper.addCode(code);
        }
        return saveCode;

    }

    /*True when delete code --> update status delete yes -> no*/
    public String genSeq(String idStartWith, int top1, int top2) {
        //String seq = "CO";
        String seq = idStartWith;
        Code code = new Code();
        code.setCode_top1(top1);
        code.setCode_top2(top2);
        Integer codeSeq = codeMapper.countCode(code);
        if (codeSeq == 0) {
            seq = seq + "01";
        } else {
            String number = String.valueOf(codeSeq + 1);
            if (number.length() == 1) {
                seq = seq + "0" + number;
            } else {
                seq = seq + number;
            }
        }
        return seq;
    }

    public HashMap getCodeById(String codeId){
        return codeMapper.getCodeById(codeId);
    }
    public List<Code> getCodeByCodeTop(Code code) {
        return codeMapper.getCodeByCodeTop(code);
    }
}
