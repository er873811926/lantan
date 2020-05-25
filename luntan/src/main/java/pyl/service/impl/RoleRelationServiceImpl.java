package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.RoleRelationMapper;
import pyl.pojo.RoleRelation;
import pyl.service.RoleRelationService;

@Service
public class RoleRelationServiceImpl implements RoleRelationService{

	@Autowired
	private RoleRelationMapper rmapper=null;
	@Override
	public List<RoleRelation> findRoleRelationAll() {
		// TODO Auto-generated method stub
		return rmapper.findRoleRelationAll();
	}

	@Override
	public List<RoleRelation> findRoleRelationByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return rmapper.findRoleRelationByCondition(map);
	}

	@Override
	public List<RoleRelation> findRoleRelationByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return rmapper.findRoleRelationByIds(id);
	}

	@Override
	public void addRoleRelation(RoleRelation r) {
		// TODO Auto-generated method stub
		rmapper.insertRoleRelation(r);
	}

	@Override
	public void updateRoleRelation(Map<String, Object> map) {
		// TODO Auto-generated method stub
		rmapper.updateRoleRelation(map);
	}

	@Override
	public void removeRoleRelationById(int id) {
		// TODO Auto-generated method stub
		rmapper.deleteRoleRelationById(id);
	}

}
