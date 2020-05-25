package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.Posts;

@Repository
public interface PostsMapper {
	public List<Posts> findPostsAll();
	//条件查询
	public List<Posts> findPostsByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Posts> findPostsByIds(List<Integer> id);
	public void insertPosts(Posts p);
	public void updatePosts(Map<String,Object> map);
	public void deletePostsById(int id );
}
