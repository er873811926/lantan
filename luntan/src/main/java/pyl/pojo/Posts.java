package pyl.pojo;


/**
 * POSTS
 * 
 * @author bianj
 * @version 1.0.0 2020-05-22
 */
public class Posts implements java.io.Serializable {
    /** 版本号 */
    private static final long serialVersionUID = 210313353874849341L;

    /* This code was generated by TableGo tools, mark 1 begin. */

    /** postsId */
    private Integer postsId;

    /** postsNo */
    private String postsNo;

    /** postsTitle */
    private String postsTitle;

    /** smoduleId */
    private Integer smoduleId;

    /** smoduleName */
    private String smoduleName;

    /** ip */
    private String ip;

    /** top */
    private String top;

    /** hot */
    private String hot;

    /** pageView */
    private Integer pageView;
    
    /** reward赏金 */
    private Integer reward;
    
    /** replyNum回帖总数 */
    private Integer replyNum;
    
    /** u_email */
    private String uemail;

    /** uptime */
    private String uptime;
    
    private String unickname;
    private String uphoto;
    
    /* This code was generated by TableGo tools, mark 1 end. */

    /* This code was generated by TableGo tools, mark 2 begin. */
    
    public String getUphoto() {
		return uphoto;
	}

	/**
     * 获取postsId
     * 
     * @return postsId
     */
    public Integer getPostsId() {
        return this.postsId;
    }

    public String getUnickname() {
		return unickname;
	}

	public void setUnickname(String unickname) {
		this.unickname = unickname;
	}

	/**
     * 设置postsId
     * 
     * @param postsId
     */
    public void setPostsId(Integer postsId) {
        this.postsId = postsId;
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

    /**
     * 获取smoduleId
     * 
     * @return smoduleId
     */
    public Integer getSmoduleId() {
        return this.smoduleId;
    }

    /**
     * 设置smoduleId
     * 
     * @param smoduleId
     */
    public void setSmoduleId(Integer smoduleId) {
        this.smoduleId = smoduleId;
    }

    /**
     * 获取smoduleName
     * 
     * @return smoduleName
     */
    public String getSmoduleName() {
        return this.smoduleName;
    }

    /**
     * 设置smoduleName
     * 
     * @param smoduleName
     */
    public void setSmoduleName(String smoduleName) {
        this.smoduleName = smoduleName;
    }

    /**
     * 获取ip
     * 
     * @return ip
     */
    public String getIp() {
        return this.ip;
    }

    /**
     * 设置ip
     * 
     * @param ip
     */
    public void setIp(String ip) {
        this.ip = ip;
    }

    /**
     * 获取top
     * 
     * @return top
     */
    public String getTop() {
        return this.top;
    }

    /**
     * 设置top
     * 
     * @param top
     */
    public void setTop(String top) {
        this.top = top;
    }

    /**
     * 获取hot
     * 
     * @return hot
     */
    public String getHot() {
        return this.hot;
    }

    /**
     * 设置hot
     * 
     * @param hot
     */
    public void setHot(String hot) {
        this.hot = hot;
    }

    /**
     * 获取pageView
     * 
     * @return pageView
     */
    public Integer getPageView() {
        return this.pageView;
    }

    /**
     * 设置pageView
     * 
     * @param pageView
     */
    public void setPageView(Integer pageView) {
        this.pageView = pageView;
    }

	public Integer getReward() {
		return reward;
	}

	public void setReward(Integer reward) {
		this.reward = reward;
	}

	public Integer getReplyNum() {
		return replyNum;
	}

	public void setReplyNum(Integer replyNum) {
		this.replyNum = replyNum;
	}

	public String getUemail() {
		return uemail;
	}

	public void setUemail(String uEmail) {
		this.uemail = uEmail;
	}

	public String getUptime() {
		return uptime;
	}

	public void setUptime(String uptime) {
		this.uptime = uptime;
	}

	public void setUphoto(String uphoto) {
		// TODO Auto-generated method stub
		this.uphoto=uphoto;
	}

    
    /* This code was generated by TableGo tools, mark 2 end. */
}