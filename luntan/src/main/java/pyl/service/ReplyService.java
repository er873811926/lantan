package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.Reply;

public interface ReplyService {
	public List<Reply> findReplyAll();
	//条件查询
	public List<Reply> findReplyByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Reply> findReplyByIds(List<Integer> id);
	public void addReply(Reply r);
	public void updateReply(Map<String,Object> map);
	public void removeReplyById(int id );
}
