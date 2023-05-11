package vn.gov.knn.admin.config;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ConfigMapper {

    Config getConfig();

    int updateConfig(Config config);
}
