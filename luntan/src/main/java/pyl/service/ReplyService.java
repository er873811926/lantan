package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.dto.ReplyNumEmailMax;
import pyl.pojo.Reply;

public interface ReplyService {
	public List<Reply> findReplyAll();
	//条件查询
	public List<Reply> findReplyByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Reply> findReplyByIds(List<Integer> id);
	public void addReply(Reply r);
	public void updateReply(Map<String,Object> map);
	//查询某贴子的回帖总数
	public int findReplyMaxNum(Map<String,Object> map);
	public void removeReplyById(int id );
	public List<ReplyNumEmailMax> findReplyNumEmailMax(Map<String,Object> map);
}
