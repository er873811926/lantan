package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.UsersMapper;
import pyl.pojo.Users;
import pyl.service.UsersService;

@Service
public class UsersServiceImpl implements UsersService{
	
	@Autowired
	private UsersMapper usersmapper=null;
	
	@Override
	public List<Users> findUsersAll() {
		// TODO Auto-generated method stub
		return usersmapper.findUsersAll();
	}

	@Override
	public List<Users> findUsersByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return usersmapper.findUsersByCondition(map);
	}

	@Override
	public List<Users> findUsersByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return usersmapper.findUsersByIds(id);
	}

	@Override
	public void addUsers(Users u) {
		// TODO Auto-generated method stub
		usersmapper.insertUsers(u);
	}

	@Override
	public void updateUsers(Map<String, Object> map) {
		// TODO Auto-generated method stub
		usersmapper.updateUsers(map);
	}

	@Override
	public void removeUsersById(int id) {
		// TODO Auto-generated method stub
		usersmapper.deleteUsersById(id);
	}

}
