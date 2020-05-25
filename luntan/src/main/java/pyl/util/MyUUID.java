package pyl.util;

import java.util.Random;
import java.util.UUID;

/**
 * UUID生成
 * @author Administrator
 *
 */
public class MyUUID {
	
	public static String getUuid(){
		return UUID.randomUUID().toString();
	}
	
	public static String getSuiJinumber(){
		StringBuffer sb=new StringBuffer();
		Random r=new Random();
		for (int i = 0; i < 8; i++) {
			sb.append(r.nextInt(9)+1);
		}
		return sb.toString();
	}
}
