package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.UserMessageMapper;
import pyl.pojo.UserMessage;
import pyl.service.UserMessageService;

@Service
public class UserMessageServiceImpl implements UserMessageService{
	
	@Autowired
	private UserMessageMapper userMessagemapper=null;
	
	@Override
	public List<UserMessage> findUserMessageAll() {
		// TODO Auto-generated method stub
		return userMessagemapper.findUserMessageAll();
	}

	@Override
	public List<UserMessage> findUserMessageByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userMessagemapper.findUserMessageByCondition(map);
	}

	@Override
	public List<UserMessage> findUserMessageByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return userMessagemapper.findUserMessageByIds(id);
	}

	@Override
	public void addUserMessage(UserMessage u) {
		// TODO Auto-generated method stub
		userMessagemapper.insertUserMessage(u);
	}

	@Override
	public void updateUserMessage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		userMessagemapper.updateUserMessage(map);
	}

	@Override
	public void removeUserMessageById(int id) {
		// TODO Auto-generated method stub
		userMessagemapper.deleteUserMessageById(id);
	}

	@Override
	public void removeUserMessageAll() {
		// TODO Auto-generated method stub
		userMessagemapper.deleteUserMessageAll();
	}

	@Override
	public int findUserMessageMaxNum(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userMessagemapper.findUserMessageMaxNum(map);
	}

}
