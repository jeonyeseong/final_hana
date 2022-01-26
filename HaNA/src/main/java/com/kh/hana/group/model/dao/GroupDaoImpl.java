package com.kh.hana.group.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.hana.group.model.vo.Group;
import com.kh.hana.group.model.vo.GroupBoard;
import com.kh.hana.group.model.vo.GroupMemberList;
import com.kh.hana.group.model.vo.GroupBoardComment;
import com.kh.hana.member.model.vo.Member;
import com.kh.hana.group.model.vo.GroupBoardEntity;

@Repository
public class GroupDaoImpl implements GroupDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public Group selectOneGroup(String groupId) {
		return session.selectOne("group.selectOneGroup",groupId);
	}

	@Override
	public int insertOneGroup(Group group) {
		return session.insert("group.insertOneGroup",group);
	}

	@Override
	public List<Group> selectGroupList(Member member) {
		return session.selectList("group.selectGroupList",member);
	}
  
    @Override
	public int insertGroupBoard(GroupBoardEntity groupBoard) {
		return session.insert("group.insertGroupBoard", groupBoard);
	}

	@Override
	public GroupBoard selectOneBoard(int no) {
		return session.selectOne("group.selectOneBoard",no);
	}

	@Override
	public List<Member> selectTagMemberList(GroupBoardEntity groupBoard) {
		return session.selectList("selectTagMemberList", groupBoard);
	}

	@Override
	public List<Map<String,String>> selectGroupMemberList(String groupId) {
		return session.selectList("selectGroupMemberList",groupId);
	}

	@Override
	public List<GroupBoardEntity> selectGroupBoardList(String groupId) {
		return session.selectList("selectGroupBoardList",groupId);
	}

	@Override
	public int insertEnrollGroupForm(Map<String, Object> map) {
		return session.insert("insertEnrollGroupForm", map);
	}

	@Override
	public List<Map<String, Object>> getGroupApplyRequest(String groupId) {
		return session.selectList("getGroupApplyRequest", groupId);
	}
	  
    @Override
    public int insertGroupBoardComment(GroupBoardComment groupBoardComment) {
	 	return session.insert("insertGroupBoardComment",groupBoardComment);
	}

	@Override
	public List<GroupBoardComment> selectGroupBoardCommentList(int boardNo) {
		return session.selectList("selectGroupBoardCommentList",boardNo);
	}
	
	@Override
	public int deleteBoardComment(int no) {
		return session.delete("deleteBoardComment",no);
	}

	@Override
	public int insertGroupMember(Map<String, Object> map) {
		return session.insert("insertGroupMember", map);
	}

	@Override
	public int deleteGroupApplyList(Map<String, Object> map) {
		return session.delete("deleteGroupApplyList", map);
	}

	@Override
	public int deleteGroupBoard(int no) {
		return session.delete("deleteGroupBoard",no);
	}

	@Override
	public int updateBoardContent(Map<String, Object> param) {
		return session.update("updateBoardContent",param);
	}

	@Override
	public Map<String, Object> selectOneLikeLog(Map<String, Object> param) {
		return session.selectOne("selectOneLikeLog",param);
	}

	@Override
	public int deleteLikeLog(Map<String, Object> param) {
		return session.delete("deleteLikeLog",param);
	}

	@Override
	public int insertLikeLog(Map<String, Object> param) {
		return session.insert("insertLikeLog",param);
	}

	@Override
	public int selectLikeCount(Map<String, Object> param) {
		return session.selectOne("selectLikeCount",param);
	}



}
