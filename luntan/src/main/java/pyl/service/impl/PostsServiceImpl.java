package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.PostsMapper;
import pyl.pojo.Posts;
import pyl.service.PostsService;

@Service
public class PostsServiceImpl implements PostsService{
	
	@Autowired
	private PostsMapper postsmapper=null;
	
	@Override
	public List<Posts> findPostsAll() {
		// TODO Auto-generated method stub
		return postsmapper.findPostsAll();
	}

	@Override
	public List<Posts> findPostsByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return postsmapper.findPostsByCondition(map);
	}

	@Override
	public List<Posts> findPostsByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return postsmapper.findPostsByIds(id);
	}

	@Override
	public void addPosts(Posts p) {
		// TODO Auto-generated method stub
		postsmapper.insertPosts(p);
	}

	@Override
	public void updatePosts(Map<String, Object> map) {
		// TODO Auto-generated method stub
		postsmapper.updatePosts(map);
	}

	@Override
	public void removePostsById(int id) {
		// TODO Auto-generated method stub
		postsmapper.deletePostsById(id);
	}

}
