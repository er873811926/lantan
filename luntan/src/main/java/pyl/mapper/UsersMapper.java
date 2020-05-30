package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.Users;

@Repository
public interface UsersMapper {
	public List<Users> findUsersAll();
	//条件查询
	public List<Users> findUsersByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Users> findUsersByIds(List<Integer> id);
	public void insertUsers(Users u);
	public void updateUsers(Map<String,Object> map);
	public void deleteUsersById(int id );
	public int findUsersMaxNum(Map<String,Object> map);
}
