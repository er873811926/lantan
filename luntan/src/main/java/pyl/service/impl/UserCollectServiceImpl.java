package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.UserCollectMapper;
import pyl.pojo.UserCollect;
import pyl.service.UserCollectService;

@Service
public class UserCollectServiceImpl implements UserCollectService{
	
	@Autowired
	private UserCollectMapper userCollectmapper=null;
	
	@Override
	public List<UserCollect> findUserCollectAll() {
		// TODO Auto-generated method stub
		return userCollectmapper.findUserCollectAll();
	}

	@Override
	public List<UserCollect> findUserCollectByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userCollectmapper.findUserCollectByCondition(map);
	}

	@Override
	public List<UserCollect> findUserCollectByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return userCollectmapper.findUserCollectByIds(id);
	}

	@Override
	public void addUserCollect(UserCollect u) {
		// TODO Auto-generated method stub
		userCollectmapper.insertUserCollect(u);
	}

	@Override
	public void updateUserCollect(Map<String, Object> map) {
		// TODO Auto-generated method stub
		userCollectmapper.updateUserCollect(map);
	}

	@Override
	public void removeUserCollectById(int id) {
		// TODO Auto-generated method stub
		userCollectmapper.deleteUserCollectById(id);
	}

}
