<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.cht.messaging.sns.*" %>
<%@ page import="java.io.*,java.net.*" %>
<%!
public class Sns_Client{
  String m_strIp;
  int m_nPort;
  String ST01 = "";

  public Sns_Client(String ip, int port){
    m_strIp = ip;
    m_nPort = port;
  }

  // Demonstrate how to submit message to mobile
  /**
   * 傳送訊息的範例Method - 若return_code值為0則表示發訊成功、此時return_desc值為訊息代碼(可用來查詢簡訊是否成功發送)，
   * 若return_code不為0表示發訊失敗，查詢return_desc判斷失敗原因，若無return_code表示無法從SNS Server取得回應，由console訊息判斷失敗原因。
   * @param account String - 登入帳號
   * @param password String - 登入密碼
   * @param recv_msisdn String - 對方手機號碼
   * @param text String - 簡訊內容
   */
  public String submitMessage(String account, String password, String recv_msisdn, String text){
    ST01 = "";
	SnsClient_V1 sns = new SnsClient_V1(m_strIp, m_nPort);
    SubmitDataModel sdm = new SubmitDataModel();
    // Login server
    sdm.setType(IConstants.SERV_LOGIN);
    sdm.setAccount(account);
    sdm.setPassword(password);
    if(sns.login(sdm) == false){
      ST01 += "login server fail(" + sns.getLastMessage() + ")" + "<br>";
      sns.logout();
      sdm = null;
      return ST01;
    }
    // Setting up proper parameters and submit it, then get the response message.
    sdm.reset();
    sdm.setType(IConstants.SERV_SUBMIT_MSG);
    sdm.setCoding((byte)1);
    sdm.setRcvMsisdn(recv_msisdn);
    sdm.setTranType(IConstants.DEFAULT_TRAN_TYPE);
    sdm.setLength((byte)text.getBytes().length);
    sdm.setMessage(text);
    RecvDataModel rdm = sns.submitMessage(sdm);
    if(rdm != null){
      ST01 += "return_code:" + rdm.getCode() + ",";
      ST01 += "return_desc:" + new String(rdm.getDesc()).trim();
    }else{// could not receive response from SNS server
      ST01 += "return_code:" + rdm.getCode() + ",";
      ST01 += "return_desc:" + new String(rdm.getDesc()).trim();
    }
    // Logout server
    sns.logout();
    sdm = null;
    
    return ST01;
  }

  // Demonstrate how to submit message(byte[]) to mobile
    /**
     * 傳送訊息的範例Method - 若return_code值為0則表示發訊成功、此時return_desc值為訊息代碼(可用來查詢簡訊是否成功發送)，
     * 若return_code不為0表示發訊失敗，查詢return_desc判斷失敗原因，若無return_code表示無法從SNS Server取得回應，由console訊息判斷失敗原因。
     * @param account String - 登入帳號
     * @param password String - 登入密碼
     * @param recv_msisdn String - 對方手機號碼
     * @param msg - 以符合dcs編碼的簡訊內容(byte[])
     * @param dcs - 編碼值，Big5, ASCII(dcs=0x01)、UCS2(UTF-16BE, dcs=0x08)
     * @param udhi - 具有填入UDH的權限為1，否則為0
     */
    public String submitMessage(String account, String password, String recv_msisdn, byte[] msg, byte dcs, byte udhi)
    {
        ST01 = "";
		SnsClient_V1 sns = new SnsClient_V1(m_strIp, m_nPort);
        SubmitDataModel sdm = new SubmitDataModel();
        // Login server
        sdm.setType(IConstants.SERV_LOGIN);
        sdm.setAccount(account);
        sdm.setPassword(password);
        if (sns.login(sdm) == false)
        {
            ST01 += "login server fail(" + sns.getLastMessage() + ")" + "<br>";
			sns.logout();
			sdm = null;
			return ST01;
        }
        // Setting up proper parameters and submit it, then get the response message.
        sdm.reset();
        sdm.setType(IConstants.SERV_SUBMIT_MSG);
        sdm.setCoding(dcs);
        sdm.setRcvMsisdn(recv_msisdn);
        sdm.setTranType(IConstants.DEFAULT_TRAN_TYPE);
        sdm.setLength((byte)msg.length);
        sdm.setUdhi(udhi);
        sdm.setMessage(msg);
        RecvDataModel rdm = sns.submitMessage(sdm);
        if (rdm != null)
        {
            ST01 += "return_code:" + rdm.getCode() + ",";
			ST01 += "return_desc:" + new String(rdm.getDesc()).trim();
        }
        else  // could not receive response from SNS server
        {
			ST01 = "Submit fail:" + sns.getLastMessage();
			//ST01 += "return_desc:" + new String(rdm.getDesc()).trim();
        }
             
        // Logout server
        sns.logout();
        sdm = null;
		return ST01;
    } 
	
  // Demonstrate how to query message status
  /**
	* 查詢訊息傳送狀態的範例Method - 若return_code值為0則表示訊息已送達對方，此時return_desc值顯示Successful及傳送成功時間，
	* 若return_code不為0，則表示訊息未送達對方，由return_desc判斷失敗原因，若無return_code表示無法從SNS Server取得回應，由console訊息判斷失敗原因。
	* @param account String - 登入帳號
	* @param password String - 登入密碼
	* @param recv_msisdn String - 對方手機號碼
	 * @param msg - 以符合dcs編碼的簡訊內容(byte[])
	 * @param dcs - 編碼值，Big5, ASCII(dcs=0x01)、UCS2(UTF-16BE, dcs=0x08)
	 * @param udhi - 具有填入UDH的權限為1，否則為0
   */
  public String qryMessageStatus(String account, String password, String recv_msisdn, String msg_id){
    ST01 = "";
	SnsClient_V1 sns = new SnsClient_V1(m_strIp, m_nPort);
    SubmitDataModel sdm = new SubmitDataModel();
    // Login server
    sdm.setType(IConstants.SERV_LOGIN);
    sdm.setAccount(account);
    sdm.setPassword(password);
    if(sns.login(sdm) == false){
      ST01 += "login server fail(" + sns.getLastMessage() + ")" + "<br>";
      sns.logout();
      sdm = null;
      return ST01;
    }
    // Setting up proper parameters and then submit it, then get the response message.
    sdm.reset();
    sdm.setType(IConstants.SERV_QUERY_STATE);
    sdm.setRcvMsisdn(recv_msisdn);
    sdm.setMessageID(msg_id);
    RecvDataModel rdm = sns.qryMessageStatus(sdm);
    if(rdm != null){
      ST01 += rdm.getCode() + ",";
      ST01 += new String(rdm.getDesc()).trim();
    }else{// could not receive response from SNS server
      ST01 += "Submit fail:" + sns.getLastMessage() + "<br>";
    }
    // Logout server
    sns.logout();
    sdm = null;
    
    return ST01;
  }

  // Demonstrate how to receive message from mobile
  /**
   * 接收訊息的範例Method - 若return_code值為0則表示接收成功、此時return_desc值為訊息內容
   * 若return_code不為0表示收訊失敗，查詢return_desc判斷失敗原因，若無return_code表示無法從SNS Server取得回應，由console訊息判斷失敗原因。
   * @param account String - 登入帳號
   * @param password String - 登入密碼
   */
  public String getMessage(String account, String password){
    SnsClient_V1 sns = new SnsClient_V1(m_strIp, m_nPort);
    SubmitDataModel sdm = new SubmitDataModel();
    // Login server
    sdm.setType(IConstants.SERV_LOGIN);
    sdm.setAccount(account);
    sdm.setPassword(password);
    if(sns.login(sdm) == false){
      ST01 += "login server fail(" + sns.getLastMessage() + ")" + "<br>";
      sns.logout();
      sdm = null;
      return ST01;
    }
    // Setting up proper parameters and submit it, then get the response message.
    sdm.reset();
    sdm.setType(IConstants.SERV_GET_MSG);
    RecvDataModel rdm = sns.getMessage(sdm);
    if(rdm != null){// 如果收到的訊息是中文的話，需以UnicodeBig編碼
      if(rdm.getCoding() == 8){
        String strMsg = null;
        try{
          strMsg = new String(rdm.getDesc(), "UTF-16BE");
          ST01 += "return_code:" + rdm.getCode() + ",";
          ST01 += "return_desc:" + strMsg.trim() + ",";
		  ST01 += "return_sendMsisdn:" + rdm.getSendMsisdn();
        }catch(UnsupportedEncodingException ex){
          ST01 += ex.getMessage() + "<br>";
        }
      }else{// 收到非中文訊息則直接印出
        ST01 += "return_code:" + rdm.getCode() + ",";
        ST01 += "return_desc:" + new String(rdm.getDesc()).trim() + ",";
		ST01 += "return_sendMsisdn:" + rdm.getSendMsisdn();
      }
    }else{// could not receive response from SNS server
      ST01 += "return_code:X,";
      ST01 += "return_desc:Submit fail:" + sns.getLastMessage() + ",";
	  ST01 += "return_sendMsisdn:" + rdm.getSendMsisdn();
    }
    // Logout server
    sns.logout();
    sdm = null;
    
    return ST01;
  }
}
public String numberToLetter(int num) {
    if (num <= 0) {
        return "";
    }
    String letter = "";
    num--;
    do {
        if (letter.length() > 0) {
            num--;
        }
        letter = ((char) (num % 26 + (int) 'A')) + letter;
        num = (int) ((num - num % 26) / 26);
    } while (num > 0);
    return letter;
}
public String sendsms_fun(String content,String phone,String ip,int port,String un,String pw) {
	String MSG01 ="";
	String output ="";
	try{
		Sns_Client sns_Client1 = new Sns_Client(ip, port);
		byte[] msg = content.getBytes("UTF-16BE");
		System.out.print(msg.length+"<br>");
		if(msg.length>1072){
			byte[] msg1 = new byte[1071];
			System.arraycopy(msg, 0, msg1, 0, 1071);
			msg = msg1;
		}
		int t1=msg.length/134;  //商數
		int t2=msg.length%134;  //餘數
		if(t2!=0)t1++;  //有餘數+1
		byte dcs = new Byte((byte)0x08);
		byte udhi = new Byte((byte)1);
		
		System.out.print(msg.length+"<br>");
		System.out.print(t1+"<br>");
		//if(true)return;
		int cc = 1;
		if(msg.length > 140){
			while(msg.length > 139){
				System.out.print("進入迴圈"+"<br>");
				byte[] by1 = new byte[140];
				by1[0] = 0x05; by1[1] = 0x00; by1[2] = 0x03; by1[3] = 0x4F; by1[4] = (byte)t1; by1[5] = (byte)cc;
				System.arraycopy(msg, 0, by1, 6, 134);
				output = sns_Client1.submitMessage(un, pw, phone, by1, dcs, udhi);
				byte[] by2 = new byte[msg.length-134];
				System.arraycopy(msg, 134, by2, 0, msg.length-134);
				msg = by2;
				cc++;
			}
			System.out.print(cc+"<br>");
			byte[] by1 = new byte[140];
			by1[0] = 0x05; by1[1] = 0x00; by1[2] = 0x03; by1[3] = 0x4F; by1[4] = (byte)t1; by1[5] = (byte)cc;
			System.arraycopy(msg, 0, by1, 6, msg.length);
			output = sns_Client1.submitMessage(un, pw, phone, by1, dcs, udhi);
		}else{
			output = sns_Client1.submitMessage(un, pw, phone, msg, dcs, (byte)0);  //短簡訊0長簡訊1
		}
		System.out.print(output+"<br>");
	}catch(Exception e){
		e.printStackTrace();
		MSG01=e.toString()+"錯誤，請洽系統管理人員";
		System.out.print(MSG01+"<br>");
	}
	return output;
}
%>
<%
//門號0911511235
String ip = "203.66.172.133";
int port = 8001;
String un = "11235";
String pw = "11235";
%>