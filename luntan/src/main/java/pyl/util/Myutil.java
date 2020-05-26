package pyl.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class Myutil {
	public static String playTime(Date date){
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format2.format(date);
	}
	
	public static String playDate(Date date){
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
		return format2.format(date);
	}
	
	public static Map<String,Object> fenPage(Map<String,Object> map,int pageSize,int pageNo){
		int currentPage=pageSize*(pageNo-1);
		map.put("currentPage", currentPage);
		map.put("pageSize", pageSize);
		return map;
	}
}
