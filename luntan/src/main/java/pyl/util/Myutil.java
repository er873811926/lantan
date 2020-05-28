package pyl.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	
	public static String replacFace(String face){
		String str=face;
		Pattern p=Pattern.compile("face\\[(\\d+)\\]");
		Matcher m=p.matcher(face);
		while(m.find()){
			String n=m.group(1);
			System.out.println(n);
			str=str.replace("face["+n+"]", "<img src='/luntan/static/res/layui/images/face/"+n+".gif'></img>");
		}
		str=str.replace("[pre]", "<pre>");
		str=str.replace("[/pre]", "</pre>");
		str=str.replace("[hr]", "<hr>");
		return str;
	}
	
}
