package com.lab.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan("com.lab.controller")
@EnableWebMvc
public class SpringMvcConfig implements WebMvcConfigurer {

    // 配置视图解析器（JSP）
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/jsp/");
        resolver.setSuffix(".jsp");
        resolver.setContentType("text/html;charset=UTF-8");
        return resolver;
    }

    // 配置静态资源访问
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        String uploadPhysicalPath = "file:D:/big_three/javaee/equipment_ssm/src/main/webapp/static/upload/";
        // 映射上传的图片路径
        registry.addResourceHandler("/static/upload/**")
//                .addResourceLocations("file:src/main/webapp/static/upload/");
                    .addResourceLocations(uploadPhysicalPath)
                    .setCachePeriod(0);
        // 映射其他静态资源
        registry.addResourceHandler("/static/**")
//                .addResourceLocations("/static/");
                    .addResourceLocations("classpath:/static/");
    }

    // 配置文件上传解析器
    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(10 * 1024 * 1024); // 最大上传大小10MB
        resolver.setDefaultEncoding("UTF-8");
        return resolver;
    }
}