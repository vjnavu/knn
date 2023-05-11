package vn.gov.knn.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
@Configuration
class configureContentTypeDefault implements WebMvcConfigurer {
    @Override
    public void configureContentNegotiation( ContentNegotiationConfigurer configurer )
    {
        configurer.defaultContentType(MediaType.valueOf(MediaType.APPLICATION_OCTET_STREAM_VALUE));
    }
}
