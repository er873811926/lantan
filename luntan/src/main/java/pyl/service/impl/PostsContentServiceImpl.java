package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.PostsContentMapper;
import pyl.pojo.PostsContent;
import pyl.service.PostsContentService;

@Service
public class PostsContentServiceImpl implements PostsContentService{
	
	@Autowired
	private PostsContentMapper postsContentmapper=null;
	
	@Override
	public List<PostsContent> findPostsContentAll() {
		// TODO Auto-generated method stub
		return postsContentmapper.findPostsContentAll();
	}

	@Override
	public List<PostsContent> findPostsContentByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return postsContentmapper.findPostsContentByCondition(map);
	}

	@Override
	public List<PostsContent> findPostsContentByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return postsContentmapper.findPostsContentByIds(id);
	}

	@Override
	public void addPostsContent(PostsContent pc) {
		// TODO Auto-generated method stub
		postsContentmapper.insertPostsContent(pc);
	}

	@Override
	public void updatePostsContent(Map<String, Object> map) {
		// TODO Auto-generated method stub
		postsContentmapper.updatePostsContent(map);
	}

	@Override
	public void removePostsContentById(int id) {
		// TODO Auto-generated method stub
		postsContentmapper.deletePostsContentById(id);
	}

}
