package pyl.dto;

import java.io.Serializable;

public class ReplyNumEmailMax implements Serializable{
	private int num;
	private String uemail;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	
}
