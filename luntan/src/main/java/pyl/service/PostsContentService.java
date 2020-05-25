package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.PostsContent;

public interface PostsContentService {
	public List<PostsContent> findPostsContentAll();
	//条件查询
	public List<PostsContent> findPostsContentByCondition(Map<String,Object> map);
	//根据主键查询
	public List<PostsContent> findPostsContentByIds(List<Integer> id);
	public void addPostsContent(PostsContent u);
	public void updatePostsContent(Map<String,Object> map);
	public void removePostsContentById(int id );
}
