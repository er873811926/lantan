package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.RoleRelation;
import pyl.pojo.Users;

public interface RoleRelationService {
	public List<RoleRelation> findRoleRelationAll();
	//条件查询
	public List<RoleRelation> findRoleRelationByCondition(Map<String,Object> map);
	//根据主键查询
	public List<RoleRelation> findRoleRelationByIds(List<Integer> id);
	public void addRoleRelation(RoleRelation r);
	public void updateRoleRelation(Map<String,Object> map);
	public void removeRoleRelationById(int id);
}
