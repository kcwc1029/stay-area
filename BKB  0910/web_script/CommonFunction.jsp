<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.logging.*" %>
<%@ page import="org.json.*" %>
<%!
//取得檔案修改時間
public String getFileTime(String path){
  try{
    File file = new File(path);
    if(file.exists()){
      return "" + file.lastModified();
    }else{
      return "";
    }
  }catch(Exception e){
    return "";
  }
}

//系統時間
public String getYMDHMSS(){
  SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
  String SC01 = date.format(new Date());

  return SC01;
}

public String getYMDHMS(){
  SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmss");
  String SC01 = date.format(new Date());

  return SC01;
}

public String getYMD_TW(){
  SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
  String SC01 = date.format(new Date());
  SC01 = (Integer.parseInt(SC01.substring(0, 4)) - 1911) + SC01.substring(4, 6) + SC01.substring(6, 8);

  return SC01;
}

//取得IP
public String getIP(HttpServletRequest request){
  String ip = request.getHeader("X-Forwarded-For");
  if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
    ip = request.getHeader("Proxy-Client-IP");
  }
  if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
    ip = request.getHeader("WL-Proxy-Client-IP");
  }
  if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
    ip = request.getHeader("HTTP_CLIENT_IP");
  }
  if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
    ip = request.getHeader("HTTP_X_FORWARDED_FOR");
  }
  if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
    ip = request.getRemoteAddr();
  }
  return ip;
}
%>

<%!
public Logger setLog(String level){
  try{
    ResourceBundle resource = ResourceBundle.getBundle("KCM");
    String FilePath = resource.getString("File.Path");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String trace = sdf.format(new Date().getTime());

    //Logger logger = Logger.getLogger(FilePath + "/Logs/" + trace + "_" + level);
    Logger logger = Logger.getLogger("LOGGER");
    FileHandler fileHandler = new FileHandler(FilePath + "/Logs/" + trace + "_" + level + ".log", true);
    fileHandler.setFormatter(new SimpleFormatter());
    fileHandler.setLevel(Level.ALL); //Log的層級
    fileHandler.setEncoding("UTF-8");
    logger.addHandler(fileHandler);
    return logger;
  }catch(Exception e){
    return null;
  }
}

public void saveLog(String level, String ip, String fileName, String parameters, String msg){
  Logger logger = setLog(level);

  if(logger != null){
    switch(level){
      case "severe":
        logger.severe(ip + " " + fileName + "\nParameters: " + parameters + "\nMessage: " + msg);
        break;
      case "warning":
        logger.warning(ip + " " + fileName + "\nParameters: " + parameters + "\nMessage: " + msg);
        break;
      case "info":
        logger.info(ip + " " + fileName + "\nParameters: " + parameters + "\nMessage: " + msg);
        break;
      case "config":
        logger.config(ip + " " + fileName + "\nParameters: " + parameters + "\nMessage: " + msg);
        break;
      case "fine":
        logger.fine(ip + " " + fileName + "\nParameters: " + parameters + "\nMessage: " + msg);
        break;
      case "finer":
        logger.finer(ip + " " + fileName + "\nParameters: " + parameters + "\nMessage: " + msg);
        break;
      case "finest":
        logger.finest(ip + " " + fileName + "\nParameters: " + parameters + "\nMessage: " + msg);
        break;
    }

    Handler[] handlers = logger.getHandlers();
    for(int A=0; A<handlers.length; A++){
      handlers[A].close();
    } 
  }
}

public static String getParameterToString(ServletRequest request){
  StringBuilder sb = new StringBuilder("{");
  for(Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()){
    sb.append(entry.getKey()).append(":");
    sb.append(Arrays.toString(entry.getValue())).append(",");
  }
  if(sb.length() > 1){
    sb.setLength(sb.length() - 1);
  }
  return sb.append("}").toString();
}

//remove UTF8_BOM
public static final String UTF8_BOM = "\uFEFF";
private static String removeUTF8BOM(String s){
  if(s.startsWith(UTF8_BOM)){
    s = s.substring(1);
  }
  return s;
}

/***** SQL Injection *****/
public String SQLIJ(String A){
  String SQLRS = "";
  if(A != null){
    SQLRS = A;
  }else{
    SQLRS = "";
  }

  if(!SQLRS.equals("")){
    SQLRS = SQLRS.replaceAll("%","％");
    SQLRS = SQLRS.replaceAll("%25","％");
    SQLRS = SQLRS.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
    //SQLRS = SQLRS.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
    SQLRS = SQLRS.replaceAll("'", "& #39;");
    SQLRS = SQLRS.replaceAll("eval\\((.*)\\)", "");
    SQLRS = SQLRS.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
    SQLRS = SQLRS.replaceAll("script", "");

    //XSS
    SQLRS = SQLRS.replaceAll("onmouseover", "on MouseOver");
    SQLRS = SQLRS.replaceAll("alert", "a lert");
  }
  return SQLRS;
}
/***** SQL Injection *****/

/***** CSRF *****/
public boolean checkCSRF(HttpServletRequest request){
  String random_form = request.getParameter("random_form");
  String random_session = (String) request.getSession().getAttribute("random_session");
  if(random_form != null && random_session != null && random_form.equalsIgnoreCase(random_session)){
    return true;
  }
  return false;
}
/***** CSRF *****/

/***** Session Hijacking *****/
//使用者可能因為 IP 更換、Proxy 等因素導致被強制登出，但為了安全性，便利性必須要與之取捨
/*
//起始頁寫入
//session.setAttribute("LAST_REMOTE_ADDR", getIP(request));
//session.setAttribute("LAST_USER_AGENT", request.getHeader("User-Agent"));
*/
public boolean checkSessionHijacking(HttpServletRequest request){
  if(!getIP(request).equals(request.getSession().getAttribute("LAST_REMOTE_ADDR")) || !request.getHeader("User-Agent").equals(request.getSession().getAttribute("LAST_USER_AGENT"))){
    //被偷了，清除session
    request.getSession().setAttribute("LAST_REMOTE_ADDR", "");
    request.getSession().setAttribute("LAST_USER_AGENT", "");

    return false;
  }
  return true;
}
/***** Session Hijacking *****/

/***** 回傳資料 *****/
public JSONObject reponseSuccess(String total, String offset, String limit, JSONArray result, String msg){
  JSONObject jsonObject = new JSONObject();
  jsonObject.put("success", true);
  if(total != null){
    jsonObject.put("total", Integer.parseInt(total));
  }

  if(offset != null){
    jsonObject.put("offset", Integer.parseInt(offset));
  }

  if(limit != null){
    jsonObject.put("limit", Integer.parseInt(limit));
  }

  if(result != null){
    jsonObject.put("result", result);
  }

  if(msg != null){
    jsonObject.put("message", msg);
  }

  return jsonObject;
}

public JSONObject reponseFail(String msg){
  JSONObject jsonObject = new JSONObject();
  jsonObject.put("success", false);

  JSONObject errorJsonObject = new JSONObject();
  errorJsonObject.put("message", msg);

  jsonObject.put("error", errorJsonObject);

  return jsonObject;
}
/***** 回傳資料 *****/
%>
<%!

//TGOS門牌
public JSONObject TGOSAddress(String addr){
  //addr = replaceCity(addr);
  long start = System.currentTimeMillis();
  while(System.currentTimeMillis() - start < 1000L){
    ResourceBundle resource = ResourceBundle.getBundle("KCM");
    //String TGOSURL = resource.getString("TGOS.Address.Url");
    String TGOSURL = "http://addr.tgos.tw/addrws/v30/QueryAddr.asmx/QueryAddr";
    String TGOSAddressAppID = resource.getString("TGOS.Address.AppID");
    String TGOSAddressAPIKey = resource.getString("TGOS.Address.APIKey");

    String encodedURL = "";
    String ST01 = "";
    try{


      encodedURL += "oAPPId=" + URLEncoder.encode(TGOSAddressAppID, "UTF-8"); //應用程式識別碼(APPId)
      encodedURL += "&oAPIKey=" + URLEncoder.encode(TGOSAddressAPIKey, "UTF-8"); // 應用程式介接驗證碼(APIKey)
      encodedURL += "&oAddress=" + URLEncoder.encode(addr, "UTF-8"); //所要查詢的門牌位置
      encodedURL += "&oSRS=" + URLEncoder.encode("EPSG:4326", "UTF-8"); //回傳的坐標系統
      encodedURL += "&oFuzzyType=" + URLEncoder.encode("0", "UTF-8"); //模糊比對的代碼
      encodedURL += "&oResultDataType=" + URLEncoder.encode("json", "UTF-8"); //回傳的資料格式
      encodedURL += "&oFuzzyBuffer=" + URLEncoder.encode("0", "UTF-8"); //模糊比對回傳門牌號的許可誤差範圍
      encodedURL += "&oIsOnlyFullMatch=" + URLEncoder.encode("true", "UTF-8"); //是否只進行完全比對
      encodedURL += "&oIsLockCounty=" + URLEncoder.encode("false", "UTF-8"); //是否鎖定縣市
      encodedURL += "&oIsLockTown=" + URLEncoder.encode("false", "UTF-8"); //是否鎖定鄉鎮市區
      encodedURL += "&oIsLockVillage=" + URLEncoder.encode("false", "UTF-8"); //是否鎖定村里
      encodedURL += "&oIsLockRoadSection=" + URLEncoder.encode("false", "UTF-8"); //是否鎖定路段
      encodedURL += "&oIsLockLane=" + URLEncoder.encode("false", "UTF-8"); //是否鎖定巷
      encodedURL += "&oIsLockAlley=" + URLEncoder.encode("false", "UTF-8"); //是否鎖定弄
      encodedURL += "&oIsLockArea=" + URLEncoder.encode("false", "UTF-8"); //是否鎖定地區
      encodedURL += "&oIsSameNumber_SubNumber=" + URLEncoder.encode("false", "UTF-8"); //號之、之號是否視為相同
      encodedURL += "&oCanIgnoreVillage=" + URLEncoder.encode("true", "UTF-8"); //找不時是否可忽略村里
      encodedURL += "&oCanIgnoreNeighborhood=" + URLEncoder.encode("true", "UTF-8"); //找不時是否可忽略鄰
      encodedURL += "&oReturnMaxCount=" + URLEncoder.encode("1", "UTF-8"); //如為多筆時，限制回傳最大筆數

      //encodedURL = URLEncoder.encode(encodedURL, "UTF-8");

      URL url = new URL(TGOSURL + "?" + encodedURL);
      URLConnection urlCon = url.openConnection();
      BufferedReader reader = new BufferedReader(new InputStreamReader(urlCon.getInputStream(), "UTF-8"));
      String line = null;
      while((line = reader.readLine()) != null){
        ST01 += line;
      }
      if(!ST01.equals("")){
        ST01 = ST01.substring(ST01.indexOf("{"), ST01.length());
      }

      reader.close();
      return new JSONObject(ST01);
    }catch(Exception e){
      return reponseFail(e.toString());
    }
  }
  return null;
}
%>