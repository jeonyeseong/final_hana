package com.kh.hana.chat.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hana.chat.model.dao.ChatDao;
import com.kh.hana.chat.model.vo.Chat;
import com.kh.hana.chat.model.vo.ChatRoom;
import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.member.model.vo.Board;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.member.model.vo.memberBoard;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatDao chatDao;

	@Override
	public List<ChatRoom> roomList(String id) {
		return chatDao.roomList(id);
	}

	@Override
	public Chat test() {
		return chatDao.test();
	}

	@Override
	public List<Chat> roomchat(int no) {
		return chatDao.roomchat(no);
	}

	@Override
	public ChatRoom selectChatRoom(int roomNo) {
		return chatDao.selectChatRoom(roomNo);
	}

	@Override
	public int insertMessage(Chat chat) {
		return chatDao.insertMessage(chat);
	}

	@Override
	public List<Member> memberList() {
		return chatDao.memberList();
	}


	@Override
	public List<ChatRoom> chatRoomCheck(Map<String, Object> param) {
		return chatDao.chatRoomCheck(param);
	}

	@Override
	public int createChatRoom(Map<String, Object> param) {	
		return chatDao.createChatRoom(param);
	}

	@Override
	public int insertEnterMessage(Map<String, Object> param) {
		int result2 = 0;
		int result = chatDao.insertEnterMessage(param);
		if(result > 0)
			result2 = chatDao.insertEnterMessage2(param);
		return result2;
	}

	@Override
	public int findRoomNo(Map<String, Object> param) {
		return chatDao.findRoomNo(param);
	}

	@Override
	public ChatRoom selectOneChatRoom(int no) {
		return chatDao.selectOneChatRoom(no);
	}

	@Override
	public int CreateGroupChat(Group group) {
		int result = chatDao.CreateGroupChat(group);
		int roomNo = chatDao.selectGroupRoomNo(group);
		group.setMemberCount(roomNo);
		int result2 = 0;
		log.info("CreateGroupChat serviceImpl roomNo넣음= {}", group);
		if(result > 0)
			result2 = chatDao.insertGroupMessage(group);
		return result2;
	}

	@Override
	public List<Member> memberList(String value) {
		return chatDao.memberList(value);
	}

	@Override
	public String searchPicture(String member) {
		return chatDao.searchPicture(member);
	}

	@Override
	public List<Map<String, Object>> roomchat2(Map<String, Object> param) {
		return chatDao.roomchat2(param);
	}

	@Override
	public int exitRoom(int roomNo) {
		return chatDao.exitRoom(roomNo);
	}

	@Override
	public int insertFileMessage(Chat chat) {
		return chatDao.insertFileMessage(chat);
	}

	@Override
	public int updateUnreadCount(Chat chat) {
		return chatDao.updateUnreadCount(chat);
	}

	@Override
	public List<String> selectListReceiver(Chat chat) {
		return chatDao.selectListReceiver(chat);
	}

	@Override
	public int dmalarm(String id) {
		return chatDao.dmalarm(id);
	}

	@Override
	public int roomUnreadChat(Chat chat) {
		return chatDao.roomUnreadChat(chat);
	}

	@Override
	public int insertGroupMessage22(Map<String, Object> param) {
		return chatDao.insertGroupMessage22(param);
	}

	@Override
	public List<GroupBoard> selectListGroupBoard(String memberId) {
		return chatDao.selectListGroupBoard(memberId);
	}

	@Override
	public List<memberBoard> selectListMemberBoard(String memberId) {
		return chatDao.selectListMemberBoard(memberId);
	}

	@Override
	public List<Member> recommendMemberList(String memberId) {
		List<Member> member1 = chatDao.followingRecommendList(memberId);
		List<Member> member2 = chatDao.groupRecommendList(memberId);
		List<Member> member = new ArrayList<Member>();
		if(member1.size() > 0 && member2.size() >0) {
			member.addAll(member1);
			member.addAll(member2);
		}
		else if(member1.size() == 0 && member2.size() != 0) {
			member.addAll(member2);
		}
		else if(member1.size() != 0 && member2.size() == 0) {
			member.addAll(member1);
		}
			
		return member;
	}







}