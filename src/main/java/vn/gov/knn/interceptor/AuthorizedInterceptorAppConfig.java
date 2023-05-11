package vn.gov.knn.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Component
public class AuthorizedInterceptorAppConfig implements WebMvcConfigurer {
    @Autowired
    private CmsInterceptor cmsInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(cmsInterceptor);
    }
    @Bean
    public HttpFirewall getHttpFirewall() {
        return new DefaultHttpFirewall();
    }
}
