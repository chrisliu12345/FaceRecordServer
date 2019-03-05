package com.gd.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import com.gd.domain.base.BaseModel;
import com.gd.domain.resource.Resource;
import com.gd.domain.resource_authority.ResourceAuthority;


import com.gd.service.resource.IResourceService;
import com.gd.service.resource_authority.IResourceAuthorityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.stereotype.Component;


/**
 * Created by Athos on 2016-10-16.
 */
@Component("mySecurityMetadataSource")
public class MySecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

    private static Map<String, Collection<ConfigAttribute>> aclResourceMap = null;

    @Autowired
    private IResourceService resourceService;
    @Autowired
    private IResourceAuthorityService resourceAuthorityService;

    @Autowired
    private EhCacheCacheManager ehCacheCacheManager;

    @Override
    public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
        String url = ((FilterInvocation) object).getRequestUrl();
        Collection<ConfigAttribute> configAttributes = new ArrayList<ConfigAttribute>();
        int firstQuestionMarkIndex = url.indexOf("?");
        if (firstQuestionMarkIndex != -1) {
            url = url.substring(0, firstQuestionMarkIndex);
        }

        List<Resource> resourceList = new ArrayList<>();
//        Cache cache = this.ehCacheCacheManager.getCache("resourceCache");
//        if (cache != null && cache.get(url) != null && cache.get(url).get() != null) {
//            resourceList = (List<Resource>) cache.get(url).get();
//        } else {
        Resource resource = new Resource();
        resource.setUrl(url);
        resourceList = this.resourceService.queryForObject(resource);
//            if (resourceList.size() > 0) {
//                cache.put(url, resourceList);
//            }
//        }
        if (resourceList.size() == 0) {
            return null;
        }

        ResourceAuthority resourceAuthority = new ResourceAuthority();
        String id = resourceList.get(0).getId();


        List<ResourceAuthority> resourceAuthorityList;
//        Cache raCache = this.ehCacheCacheManager.getCache("resourceAuthCache");
//        if (raCache != null && raCache.get(id) != null && raCache.get(id).get() != null) {
//            resourceAuthorityList = (List<ResourceAuthority>) raCache.get(id).get();
//        } else {
        resourceAuthority.setResourceId(id);
        resourceAuthorityList = this.resourceAuthorityService.queryForObject(resourceAuthority);
//            if (resourceAuthorityList.size()>0){
//                raCache.put(id,resourceAuthorityList);
//            }
//        }
        if (resourceAuthorityList.size() > 0) {
            for (ResourceAuthority resourceAuthority1 : resourceAuthorityList) {
                ConfigAttribute ca = new SecurityConfig(resourceAuthority1.getAuthorityId());
                configAttributes.add(ca);
            }
            return configAttributes;
        } else {
            return null;
        }
    }

    //4
    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        System.out.println("metadata : getAllConfigAttributes");
        return null;
    }

    //3
    @Override
    public boolean supports(Class<?> clazz) {
        System.out.println("metadata : supports");
        return true;
    }


}
