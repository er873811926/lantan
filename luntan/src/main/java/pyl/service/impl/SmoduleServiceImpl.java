package pyl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pyl.mapper.SmoduleMapper;
import pyl.pojo.Smodule;
import pyl.service.SmoduleService;

@Service
public class SmoduleServiceImpl implements SmoduleService{
	
	@Autowired
	private SmoduleMapper Smodulemapper=null;
	
	@Override
	public List<Smodule> findSmoduleAll() {
		// TODO Auto-generated method stub
		return Smodulemapper.findSmoduleAll();
	}

	@Override
	public List<Smodule> findSmoduleByCondition(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return Smodulemapper.findSmoduleByCondition(map);
	}

	@Override
	public List<Smodule> findSmoduleByIds(List<Integer> id) {
		// TODO Auto-generated method stub
		return Smodulemapper.findSmoduleByIds(id);
	}

	@Override
	public void addSmodule(Smodule u) {
		// TODO Auto-generated method stub
		Smodulemapper.insertSmodule(u);
	}

	@Override
	public void updateSmodule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Smodulemapper.updateSmodule(map);
	}

	@Override
	public void removeSmoduleById(int id) {
		// TODO Auto-generated method stub
		Smodulemapper.deleteSmoduleById(id);
	}

}
