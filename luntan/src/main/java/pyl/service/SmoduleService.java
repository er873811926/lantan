package pyl.service;

import java.util.List;
import java.util.Map;

import pyl.pojo.Smodule;

public interface SmoduleService {
	public List<Smodule> findSmoduleAll();
	//条件查询
	public List<Smodule> findSmoduleByCondition(Map<String,Object> map);
	//根据主键查询
	public List<Smodule> findSmoduleByIds(List<Integer> id);
	public void addSmodule(Smodule u);
	public void updateSmodule(Map<String,Object> map);
	public void removeSmoduleById(int id);
}
