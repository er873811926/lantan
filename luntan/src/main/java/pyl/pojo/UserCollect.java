package pyl.pojo;
/*
 
* Welcome to use the TableGo Tools.
 * 
 * http://www.tablego.cn
 
 * http://vipbooks.iteye.com
 * http://blog.csdn.net/vipbooks
 * http://www.cnblogs.com/vipbooks
 * 
 * Author: bianj
 * Email: tablego@qq.com
 * Version: 6.0.0
 */
/**
 * USER_COLLECT
 * 
 * @author bianj
 * @version 1.0.0 2020-05-29
 */
public class UserCollect implements java.io.Serializable {
    /** 版本号 */
    private static final long serialVersionUID = 6126943434639027266L;

    /* This code was generated by TableGo tools, mark 1 begin. */

    /** collectId */
    private Integer collectId;

    /** uemail */
    private String uemail;

    /** postsNo */
    private String postsNo;

    /** postsTitle */
    private String postsTitle;

    /* This code was generated by TableGo tools, mark 1 end. */

    /* This code was generated by TableGo tools, mark 2 begin. */

    /**
     * 获取collectId
     * 
     * @return collectId
     */
    public Integer getCollectId() {
        return this.collectId;
    }

    /**
     * 设置collectId
     * 
     * @param collectId
     */
    public void setCollectId(Integer collectId) {
        this.collectId = collectId;
    }

    /**
     * 获取uemail
     * 
     * @return uemail
     */
    public String getUemail() {
        return this.uemail;
    }

    /**
     * 设置uemail
     * 
     * @param uemail
     */
    public void setUemail(String uemail) {
        this.uemail = uemail;
    }

    /**
     * 获取postsNo
     * 
     * @return postsNo
     */
    public String getPostsNo() {
        return this.postsNo;
    }

    /**
     * 设置postsNo
     * 
     * @param postsNo
     */
    public void setPostsNo(String postsNo) {
        this.postsNo = postsNo;
    }

    /**
     * 获取postsTitle
     * 
     * @return postsTitle
     */
    public String getPostsTitle() {
        return this.postsTitle;
    }

    /**
     * 设置postsTitle
     * 
     * @param postsTitle
     */
    public void setPostsTitle(String postsTitle) {
        this.postsTitle = postsTitle;
    }

    /* This code was generated by TableGo tools, mark 2 end. */
}