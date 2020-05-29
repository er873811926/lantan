package pyl.web.shiro;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import pyl.pojo.RoleRelation;
import pyl.pojo.Users;
import pyl.service.RoleRelationService;
import pyl.service.UsersService;


public class UsersRealm extends AuthorizingRealm{
	
	@Autowired
	private UsersService usersservice=null;
	
	@Autowired
	private RoleRelationService rservice=null;
	
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken arg0) throws AuthenticationException {
		// TODO Auto-generated method stub
		UsernamePasswordToken token=(UsernamePasswordToken)arg0;
		String uname=token.getUsername();
		String upass=new String(token.getPassword());
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("uemail", uname);
		List<Users> list=usersservice.findUsersByCondition(map);
		Object principal="";
		Object credentials="";
		if(!list.isEmpty()){
			Users u=list.get(0);
			if(u.getUban().equals("1")){
				throw new LockedAccountException("msg:帐号被禁用,static:0");
			}
			principal=u.getUemail();
			credentials =u.getUpassword();
		}else{
			throw new UnknownAccountException("msg:帐号不存在,static:0,");
		}
		
		ByteSource salt=ByteSource.Util.bytes(uname);
		SimpleAuthenticationInfo sai= 
				new SimpleAuthenticationInfo(principal, credentials, salt,this.getName());
		return sai;
	}
	

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		// TODO Auto-generated method stub
		Object principal = arg0.getPrimaryPrincipal();
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("uemail", principal);
		List<RoleRelation> list=rservice.findRoleRelationByCondition(map);
		Set<String> roles=new HashSet<String>();
		if(!list.isEmpty()){
			for (RoleRelation r : list) {
				roles.add(r.getRoleName());
			}
		}
		SimpleAuthorizationInfo authenthorizationInfo=new SimpleAuthorizationInfo(roles);
		return authenthorizationInfo;
	}
	
	

}
