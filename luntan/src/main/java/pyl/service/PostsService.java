package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.Posts;

public interface PostsService {
	public List<Posts> findPostsAll();
	//条件查询
	public List<Posts> findPostsByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Posts> findPostsByIds(List<Integer> id);
	public void addPosts(Posts p);
	public void updatePosts(Map<String,Object> map);
	public int findPostsMaxNum(Map<String,Object> map);
	public void removePostsById(int id );
}
