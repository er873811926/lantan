package pyl.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Myutil {
	public static String playTime(Date date){
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format2.format(date);
	}
}
