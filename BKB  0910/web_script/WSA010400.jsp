<%@ page import="java.security.*" %>
<%@ page import="java.math.*" %>
<%!
//NULL轉為空字串及SQL Injection處理頁面
public String SQLIJ(String A){
String SQLRS = "";
if (A != null){
SQLRS = A;
} else {
SQLRS = "";
}

if (!SQLRS.equals("")){
SQLRS=SQLRS.replace("%","％");
SQLRS=SQLRS.replace("&","＆");
SQLRS=SQLRS.replace("#","＃");
SQLRS=SQLRS.replace("!","！");
SQLRS=SQLRS.replace("+","＋");
SQLRS=SQLRS.replace("<","＜");
SQLRS=SQLRS.replace(">","＞");
SQLRS=SQLRS.replace(";","；");
SQLRS=SQLRS.replace("'","’");
SQLRS=SQLRS.replace("--","－－");
  if(SQLRS.toUpperCase().equals("SELECT") || SQLRS.toUpperCase().equals("INSERT") || SQLRS.toUpperCase().equals("UPDATE") || SQLRS.toUpperCase().equals("DELETE")){
  SQLRS=SQLRS.toUpperCase().replace("SELECT","");
  SQLRS=SQLRS.toUpperCase().replace("INSERT","");
  SQLRS=SQLRS.toUpperCase().replace("UPDATE","");
  SQLRS=SQLRS.toUpperCase().replace("DELETE","");
  }
}
return SQLRS;
}

public String EYC(String A){
	String EYCDATE = String.valueOf(Integer.parseInt(A)-19110000); //民國年
	return EYCDATE;
}
public String EYC2(String A){
	String CYEDATE = A;
	String EYCDATE = CYEDATE.substring(0,4)+"/"+CYEDATE.substring(4,6)+"/"+CYEDATE.substring(6,8);
	return EYCDATE;
}
public String EYC3(String A){
	long DT = 19110000000000L;
	String EYCDATE = String.valueOf(Long.parseLong(A)-DT); //民國年
	return EYCDATE;
}
public String CYE(String A){
	String CYEDATE = String.valueOf(Integer.parseInt(A)+19110000); //民國年
	return CYEDATE;
}
public String CYE2(String A){
	String CYEDATE = String.valueOf(Integer.parseInt(A)+19110000); //民國年
	CYEDATE = CYEDATE.substring(0,4)+"/"+CYEDATE.substring(4,6)+"/"+CYEDATE.substring(6,8);
	return CYEDATE;
}
public String T2F(String A){
	String CYEDATE = A; //六碼時間
	CYEDATE = CYEDATE.substring(0,2)+":"+CYEDATE.substring(2,4)+":"+CYEDATE.substring(4);
	return CYEDATE;
}
public String getMD5(String str){
 String ret = null;
 try {
	 // 生成一個MD5加密計算摘要
	 MessageDigest md = MessageDigest.getInstance("MD5");
	 // 計算md5函數
	 md.update(str.getBytes());
	 // digest()最後確定返回md5 hash值，返回值為8為字符串。因為md5 hash值是16位的hex值，實際上就是8位的字符
	 // BigInteger函數則將8位的字符串轉換成16位hex值，用字符串來表示；得到字符串形式的hash值
	 ret = new BigInteger(1, md.digest()).toString(16);
 } catch (Exception e) {
	 //throw new SpeedException("MD5加密出現錯誤");
	 e.printStackTrace();
 }
	return ret;
}

public String SHA256(String strText){
  return SHA(strText, "SHA-256");
}

public String SHA512(final String strText){
  return SHA(strText, "SHA-512");
}

private String SHA(final String strText, final String strType){
  // 返回值
  String strResult = null;
 
  // 是否是有效字符串
  if(strText != null && strText.length() > 0){
    try{
      // SHA 加密開始
      // 創建加密對象 並傳入加密類型
      MessageDigest messageDigest = MessageDigest.getInstance(strType);
      // 傳入要加密的字符串
      messageDigest.update(strText.getBytes());
      // 得到 byte 類型結果
      byte byteBuffer[] = messageDigest.digest();
      // 將 byte 轉換為 string
      StringBuffer strHexString = new StringBuffer();
      // 遍歷 byte buffer
      for(int i=0; i<byteBuffer.length; i++){
        String hex = Integer.toHexString(0xff & byteBuffer[i]);
        if(hex.length() == 1){
          strHexString.append("0");
        }
        strHexString.append(hex);
      }
      // 得到返回結果
      strResult = strHexString.toString().toUpperCase();
    }catch(NoSuchAlgorithmException e){
      e.printStackTrace();
    }
  }
  return strResult;
}


%>

