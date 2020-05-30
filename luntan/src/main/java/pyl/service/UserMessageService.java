package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.UserMessage;

public interface UserMessageService {
	public List<UserMessage> findUserMessageAll();
	//条件查询
	public List<UserMessage> findUserMessageByCondition(Map<String,Object> map);
	//根据主键查询
	public List<UserMessage> findUserMessageByIds(List<Integer> id);
	public void addUserMessage(UserMessage u);
	public void updateUserMessage(Map<String,Object> map);
	public void removeUserMessageById(int id );
	public void removeUserMessageAll();
	public int findUserMessageMaxNum(Map<String,Object> map);
}
