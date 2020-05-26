package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.dto.ReplyNumEmailMax;
import pyl.mapper.ReplyMapper;
import pyl.pojo.Reply;
import pyl.service.ReplyService;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper replymapper=null;
	
	@Override
	public List<Reply> findReplyAll() {
		// TODO Auto-generated method stub
		return replymapper.findReplyAll();
	}

	@Override
	public List<Reply> findReplyByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return replymapper.findReplyByCondition(map);
	}

	@Override
	public List<Reply> findReplyByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return replymapper.findReplyByIds(id);
	}

	@Override
	public void addReply(Reply u) {
		// TODO Auto-generated method stub
		replymapper.insertReply(u);
	}

	@Override
	public void updateReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		replymapper.updateReply(map);
	}

	@Override
	public void removeReplyById(int id) {
		// TODO Auto-generated method stub
		replymapper.deleteReplyById(id);
	}

	@Override
	public List<ReplyNumEmailMax> findReplyNumEmailMax(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return replymapper.findReplyNumEmailMax(map);
	}

	

}
