package com.kh.hana.member.model.service;
 
import java.util.List;
import java.util.Map;

import com.kh.hana.member.model.vo.Follower;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.shop.model.vo.Shop;

public interface MemberService {

	int memberEnroll(Member member);

	int updateMember(Member member, Member oldMember, String id);

	Member selectPersonality(String id);

	int updateShopInfo(Shop shop);

	int addFollowing(Map<String, Object> map);

	int countFollowing(String id);

	Member selectOneMember(String id);

	int countFollower(String id);

	List<Follower> followerList(String id);

 
	List<Follower> followingList(String id);
 
	Shop selectOneShopInfo(String memberId);
 

}
