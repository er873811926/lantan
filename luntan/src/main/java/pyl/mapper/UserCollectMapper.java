package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.UserCollect;

@Repository
public interface UserCollectMapper {
	public List<UserCollect> findUserCollectAll();
	//条件查询
	public List<UserCollect> findUserCollectByCondition(Map<String,Object> map);
	//根据主键查询
	public List<UserCollect> findUserCollectByIds(List<Integer> id);
	public void insertUserCollect(UserCollect u);
	public void updateUserCollect(Map<String,Object> map);
	public void deleteUserCollectById(int id );
}
