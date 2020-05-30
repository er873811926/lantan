package pyl.pojo;

/**
 * 举报数(REPLY)
 * 
 * @author bianj
 * @version 1.0.0 2020-05-22
 */
public class Reply implements java.io.Serializable {
    /** 版本号 */
    private static final long serialVersionUID = 4472147934843622836L;

    /* This code was generated by TableGo tools, mark 1 begin. */

    /** replyId */
    private Integer replyId;

    /** postsNo */
    private String postsNo;

    /** replyContent */
    private String replyContent;

    /** uEmail */
    private String uemail;

    /** ip */
    private String ip;

    /** replyTime */
    private String replyTime;

    /** hot */
    private String hot;

    /** likes */
    private Integer likes;

    /** top */
    private String top;

    /** ban */
    private String ban;

    private String postsTitle;
    
    private String unickname;
    private String uphoto;
    /* This code was generated by TableGo tools, mark 1 end. */

    /* This code was generated by TableGo tools, mark 2 begin. */
    
    
    public String getUphoto() {
		return uphoto;
	}

	public void setUphoto(String uphoto) {
		this.uphoto = uphoto;
	}

	/**
     * 获取replyId
     * 
     * @return replyId
     */
    public Integer getReplyId() {
        return this.replyId;
    }

    public String getUnickname() {
		return unickname;
	}

	public void setUnickname(String unickname) {
		this.unickname = unickname;
	}

	/**
     * 设置replyId
     * 
     * @param replyId
     */
    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
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
     * 获取replyContent
     * 
     * @return replyContent
     */
    public String getReplyContent() {
        return this.replyContent;
    }

    /**
     * 设置replyContent
     * 
     * @param replyContent
     */
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }
    
    

    public String getUemail() {
		return uemail;
	}

	public void setUemail(String uemail) {
		this.uemail = uemail;
	}

	public String getPostsTitle() {
		return postsTitle;
	}

	public void setPostsTitle(String postsTitle) {
		this.postsTitle = postsTitle;
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
     * 获取replyTime
     * 
     * @return replyTime
     */
    public String getReplyTime() {
        return this.replyTime;
    }

    /**
     * 设置replyTime
     * 
     * @param replyTime
     */
    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
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
     * 获取likes
     * 
     * @return likes
     */
    public Integer getLikes() {
        return this.likes;
    }

    /**
     * 设置likes
     * 
     * @param likes
     */
    public void setLikes(Integer likes) {
        this.likes = likes;
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
     * 获取ban
     * 
     * @return ban
     */
    public String getBan() {
        return this.ban;
    }

    /**
     * 设置ban
     * 
     * @param ban
     */
    public void setBan(String ban) {
        this.ban = ban;
    }

    /* This code was generated by TableGo tools, mark 2 end. */
}