package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.dto.ReplyNumEmailMax;
import pyl.pojo.Reply;

@Repository
public interface ReplyMapper {
	public List<Reply> findReplyAll();
	//条件查询
	public List<Reply> findReplyByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Reply> findReplyByIds(List<Integer> id);
	public void insertReply(Reply r);
	public void updateReply(Map<String,Object> map);
	public void deleteReplyById(int id );
	
	//查询回帖数
	public List<ReplyNumEmailMax> findReplyNumEmailMax(Map<String,Object> map);
}
