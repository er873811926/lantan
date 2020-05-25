package pyl.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import pyl.pojo.Smodule;

@Repository
public interface SmoduleMapper {
	public List<Smodule> findSmoduleAll();
	//条件查询
	public List<Smodule> findSmoduleByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Smodule> findSmoduleByIds(List<Integer> id);
	public void insertSmodule(Smodule u);
	public void updateSmodule(Map<String,Object> map);
	public void deleteSmoduleById(int id);
}
