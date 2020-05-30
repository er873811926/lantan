package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.Users;

public interface UsersService {
	public List<Users> findUsersAll();
	//条件查询
	public List<Users> findUsersByCondition(Map<String,Object> map);
	public List<Users> findNameEmail(Map<String,Object> map);
	//根据主键查询
	public List<Users> findUsersByIds(List<Integer> id);
	public void addUsers(Users u);
	public void updateUsers(Map<String,Object> map);
	public void removeUsersById(int id );
	public int findUsersMaxNum(Map<String,Object> map);
}
