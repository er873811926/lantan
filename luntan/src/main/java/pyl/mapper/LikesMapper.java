package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.Likes;

@Repository
public interface LikesMapper {
	public List<Likes> findLikesAll();
	//条件查询
	public List<Likes> findLikesByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Likes> findLikesByIds(List<Integer> id);
	public void insertLikes(Likes u);
	public void updateLikes(Map<String,Object> map);
	public void deleteLikesById(int id );
}
