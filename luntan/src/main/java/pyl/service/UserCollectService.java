package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.UserCollect;

public interface UserCollectService {
	public List<UserCollect> findUserCollectAll();
	//条件查询
	public List<UserCollect> findUserCollectByCondition(Map<String,Object> map);
	//根据主键查询
	public List<UserCollect> findUserCollectByIds(List<Integer> id);
	public void addUserCollect(UserCollect u);
	public void updateUserCollect(Map<String,Object> map);
	public void removeUserCollectById(int id );
}
