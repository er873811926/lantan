package pyl.pojo;
/**
 * ROLE
 * 
 * @author bianj
 * @version 1.0.0 2020-05-22
 */
public class Role implements java.io.Serializable {
    /** 版本号 */
    private static final long serialVersionUID = -9207343095281861214L;

    /* This code was generated by TableGo tools, mark 1 begin. */

    /** roleId */
    private Integer roleId;

    /** roleName */
    private String roleName;

    /* This code was generated by TableGo tools, mark 1 end. */

    /* This code was generated by TableGo tools, mark 2 begin. */

    /**
     * 获取roleId
     * 
     * @return roleId
     */
    public Integer getRoleId() {
        return this.roleId;
    }

    /**
     * 设置roleId
     * 
     * @param roleId
     */
    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    /**
     * 获取roleName
     * 
     * @return roleName
     */
    public String getRoleName() {
        return this.roleName;
    }

    /**
     * 设置roleName
     * 
     * @param roleName
     */
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    /* This code was generated by TableGo tools, mark 2 end. */
}