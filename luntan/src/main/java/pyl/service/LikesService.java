package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.Likes;

public interface LikesService {
	public List<Likes> findLikesAll();
	//条件查询
	public List<Likes> findLikesByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Likes> findLikesByIds(List<Integer> id);
	public void addLikes(Likes u);
	public void updateLikes(Map<String,Object> map);
	public void removeLikesById(int id );
}
