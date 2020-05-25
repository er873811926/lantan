package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.PostsContent;

@Repository
public interface PostsContentMapper {
	public List<PostsContent> findPostsContentAll();
	//条件查询
	public List<PostsContent> findPostsContentByCondition(Map<String,Object> map);
	//根据主键查询
	public List<PostsContent> findPostsContentByIds(List<Integer> id);
	public void insertPostsContent(PostsContent pc);
	public void updatePostsContent(Map<String,Object> map);
	public void deletePostsContentById(int id );
}
