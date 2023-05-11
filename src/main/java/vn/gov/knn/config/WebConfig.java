package vn.gov.knn.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@ComponentScan(basePackages = {"vn.gov.knn"})
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/assets/**").addResourceLocations("classpath:/assets/");
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
        registry.addResourceHandler("/ckfinder/**").addResourceLocations("classpath:/static/ckfinder/");
        registry.addResourceHandler("/ckeditor/**").addResourceLocations("classpath:/static/ckeditor/");
    }
}
