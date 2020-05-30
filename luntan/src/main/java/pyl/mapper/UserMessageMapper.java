package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.UserMessage;

@Repository
public interface UserMessageMapper {
	public List<UserMessage> findUserMessageAll();
	//条件查询
	public List<UserMessage> findUserMessageByCondition(Map<String,Object> map);
	//根据主键查询
	public List<UserMessage> findUserMessageByIds(List<Integer> id);
	public void insertUserMessage(UserMessage u);
	public void updateUserMessage(Map<String,Object> map);
	public void deleteUserMessageById(int id );
	public int findUserMessageMaxNum(Map<String,Object> map);
	public void deleteUserMessageAll();
	
}
