package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.LikesMapper;
import pyl.pojo.Likes;
import pyl.service.LikesService;

@Service
public class LikesServiceImpl implements LikesService{
	
	@Autowired
	private LikesMapper likesmapper=null;
	
	@Override
	public List<Likes> findLikesAll() {
		// TODO Auto-generated method stub
		return likesmapper.findLikesAll();
	}

	@Override
	public List<Likes> findLikesByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return likesmapper.findLikesByCondition(map);
	}

	@Override
	public List<Likes> findLikesByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return likesmapper.findLikesByIds(id);
	}

	@Override
	public void addLikes(Likes u) {
		// TODO Auto-generated method stub
		likesmapper.insertLikes(u);
	}

	@Override
	public void updateLikes(Map<String, Object> map) {
		// TODO Auto-generated method stub
		likesmapper.updateLikes(map);
	}

	@Override
	public void removeLikesById(int id) {
		// TODO Auto-generated method stub
		likesmapper.deleteLikesById(id);
	}

}
