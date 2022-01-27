package com.kh.hana.shop.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.service.ShopService;
import com.kh.hana.shop.model.vo.HashTag;
import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
@RequestMapping("/shop")
public class ShopController {
    @Autowired
    private ShopService shopService;
    
    @GetMapping("/shopMain")
    public void shopMain() {
        
    }
    
    @GetMapping("/shopList")
    public ResponseEntity<?> selectShopList(@RequestParam String id, @RequestParam String locationX, @RequestParam String locationY) {
        Map<String, Object> data = new HashMap<>();
        data.put("id", id);
        data.put("locationX", locationX);
        data.put("locationY", locationY);
        
//      8.23km내
        double maxX = Double.parseDouble(locationX) + 0.0927;
        double maxY = Double.parseDouble(locationY) + 0.074;
        
        String maxLocationX = Double.toString(maxX);
        String maxLocationY = Double.toString(maxY);
        
        data.put("maxLocationX", maxLocationX);
        data.put("maxLocationY", maxLocationY);
        
        log.info("data = {}", data);
        
        List<Map<String, Object>> shopList = shopService.selectShopList(data);
        log.info("length = {}", shopList.size());
        
        return ResponseEntity.ok(shopList);
    }
    
    @PostMapping("/insertHashTag")
    public String insertHashTag(HashTag hashTag, RedirectAttributes redirectAttr) {
        log.info("hashTag = {}", hashTag);
        hashTag.setTagId("shop");
        
        int result = shopService.insertHashTag(hashTag);
        log.info("hashTag Result = {}", result);
        
        return "redirect:/member/shopSetting/hashtag";
    }
    
    @GetMapping("/hashTagAutocomplete")
    public ResponseEntity<?> hashTagAutocomplete( String search) {
        log.info("search = {}", search);
        List<HashTag> tagList = shopService.hashTagAutocomplete(search);
        log.info("tagList = {}", tagList);
        
        return ResponseEntity.ok(tagList);
    }
    
    
    @GetMapping("/hashTagSearch")
    public ResponseEntity<?> hashTagSearch(@RequestParam(value="tagDataArr[]") List<String> tagDataArr) {
    	log.info("tagDataArr = {}", tagDataArr);
		
    	return ResponseEntity.ok(tagDataArr);
    }
    
    
}