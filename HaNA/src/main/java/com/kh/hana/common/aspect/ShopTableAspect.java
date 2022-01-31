package com.kh.hana.common.aspect;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.kh.hana.shop.model.service.ShopService;
import com.kh.hana.shop.model.vo.Reservation;
import com.kh.hana.shop.model.vo.Table;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Aspect
public class ShopTableAspect {
	
	@Autowired
	public ShopService shopService;

	@Pointcut("execution(* com.kh.hana.shop.controller.ShopController.updateShopTable(..)) || execution(* com.kh.hana.shop.controller.ShopController.updateShopTable(..))")
	public void aroundManageTablePointcut() {};
	
	@Around("aroundManageTablePointcut()")
	public Object aroundManageShopTable(ProceedingJoinPoint joinPoint) throws Throwable {
		Object[] arg = joinPoint.getArgs();
		Table table = (Table) arg[0];
		
		Map<String, Object> infoMap = new HashMap<>();
		infoMap.put("tableId", table.getTableId());
		
		List<Reservation> resultTable = shopService.selectTableReservation(infoMap);
		
		if(!resultTable.isEmpty()) {
			return ResponseEntity.ok("등록된 예약이 있어 수정 및 삭제가 불가합니다.");
		} else {
			Object returnObj = joinPoint.proceed();
			
			return returnObj;
		}
		
		
	}
}
