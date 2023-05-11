package vn.gov.knn.admin.code;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CodeMapper {
    int checkDuplicateCode(String codeName);
    int checkDuplicateCode2(@Param("codeId")String codeId, @Param("codeName") String codeName);
    int updateCodeName(@Param("codeId")String codeId, @Param("codeName") String codeName, @Param("codeDesc") String codeDesc);
    int deleteCode(String codeId);
    Integer countCode(Code code);
    int addCode(Code code);
    List<Code> getCodeByCodeTop(Code code);
    HashMap getCodeById(String codeId);
}
