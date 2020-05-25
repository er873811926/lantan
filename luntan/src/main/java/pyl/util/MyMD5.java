package pyl.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;

public class MyMD5 {
	private static String values;
	public static String addMD5(String pass,int num) {
		try {
			encrypt(pass,num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return values;
	}
	private static void encrypt(String pass,int num) throws Exception{
		int n=num;
		MessageDigest md = MessageDigest.getInstance("MD5"); 
		String miwen=null;
		md.update(pass.getBytes());
		miwen=new String(md.digest());
		n--;
		if(n==0){
		values=	miwen;	
		return ;
		}
		encrypt(miwen,n);
	}
	
}
