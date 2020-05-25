package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.RoleRelation;
import pyl.pojo.Users;

@Repository
public interface RoleRelationMapper {
	public List<RoleRelation> findRoleRelationAll();
	//条件查询
	public List<RoleRelation> findRoleRelationByCondition(Map<String,Object> map);
	//根据主键查询
	public List<RoleRelation> findRoleRelationByIds(List<Integer> id);
	public void insertRoleRelation(RoleRelation r);
	public void updateRoleRelation(Map<String,Object> map);
	public void deleteRoleRelationById(int id );
}
