<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%!
public String URA004_Log(String A,String B,String C,String D,String E,String F){
	try{
		Database DB01 = new Database("BK");//連資料庫
		Connection CONN01 = DB01.getConn();
		Statement statement = CONN01.createStatement();
		String SQL = "INSERT INTO URA004 (URA004001,URA004002,URA004003,URA004004,URA004005,URA004006) VALUES (N'"+A+"',N'"+B+"',N'"+C+"',N'"+D+"','"+E+"','"+F+"')";
		statement.executeUpdate(SQL);
		
		return "使用者紀錄寫入成功";
	}catch(SQLException e){
		return e.toString();
    }catch(Exception e){
		return e.toString();
	}
}
public String calDATE(String A,String B,int C){	//計算日期用
	String SDATE = String.valueOf(Integer.parseInt(A)+19110000);  //起始日期轉為西元年
	try{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  //設定日期格式
		Calendar c1 = Calendar.getInstance();  //建立日期物件
		c1.setTime(sdf.parse(SDATE));  //放入起始日期
		if(B.equals("M"))c1.add(Calendar.MONTH, C);//日期加月
		if(B.equals("D"))c1.add(Calendar.DATE, C);//日期加天
		SDATE = String.valueOf(Integer.parseInt(sdf.format(c1.getTime()))-19110000);
	}catch(ParseException e) {
		e.printStackTrace();
	}
	return SDATE;
}
public String calDATECCA(String A,String B,int C){	//計算日期用
	String SDATE = "";
	try{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");  //設定日期格式
		
		Calendar c1 = Calendar.getInstance();  //建立日期物件
		c1.setTime(sdf.parse(A));  //放入起始日期
		if(B.equals("Y"))c1.add(Calendar.YEAR, C);//日期加年
		if(B.equals("M"))c1.add(Calendar.MONTH, C);//日期加月
		if(B.equals("D"))c1.add(Calendar.DATE, C);//日期加天
		SDATE = sdf.format(c1.getTime());
		//SDATE = String.valueOf(Integer.parseInt(sdf.format(c1.getTime()))-19110000);
	}catch(ParseException e) {
		e.printStackTrace();
	}
	return SDATE;
}

public List getDays(String beginTime,String endTime){
	beginTime = String.valueOf(Integer.parseInt(beginTime)+19110000);  //起日期轉為西元年
	endTime = String.valueOf(Integer.parseInt(endTime)+19110000);  //迄日期轉為西元年
	DateFormat FORMATTER = new SimpleDateFormat("yyyyMMdd"); 
	List<String> list=null; 
	try{ 
		Calendar startDay = Calendar.getInstance(); 
		Calendar endDay = Calendar.getInstance(); 
		startDay.setTime(FORMATTER.parse(beginTime)); 
		endDay.setTime(FORMATTER.parse(endTime)); 
		// 給出的日期開始日比終了日大則不執行列印 
		list=new ArrayList<String>(); 
		Date s1=new Date(); 
		//s1.setDay(beginTime); 
		list.add(beginTime); 
		if(!beginTime.equals(endTime)){ 
			if(startDay.compareTo(endDay)<=0){ 
				//現在列印中的日期 
				Calendar currentPrintDay = startDay; 
				while (true){ 
					Date s=new Date(); 
					// 日期加一 
					currentPrintDay.add(Calendar.DATE, 1); 
					// 日期加一後判斷是否達到終了日,達到則終止列印 
					if (currentPrintDay.compareTo(endDay) == 0) { break; } 
					list.add(FORMATTER.format(currentPrintDay.getTime()));
				} 
				Date s2=new Date(); 
				//s2.setDay(endTime); 
				list.add(endTime); 
			} 
		} 
	}catch (Exception e){
		e.printStackTrace();
		System.out.println(e.toString());
	} 
		return list; 
}
public String MoneyC(String A){
	NumberFormat Moneyf = new DecimalFormat("###,###,###,###");
	if(A.equals("")){
		return "0";
	}else{
		return Moneyf.format(Double.parseDouble(A));
	}
}
public String AreaC(String A){
	NumberFormat Areaf = new DecimalFormat("###,###,###.00");
	if(A.equals("")){
		return "0";
	}else{
		return Areaf.format(Double.parseDouble(A));
	}
}
public long DiffYears(String A ,String B){  //計算差幾年
	long diffrence = 0;
	try{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  //設定日期格式
		Date firstDate = sdf.parse(A);
        Date secondDate = sdf.parse(B);
        long diff = secondDate.getTime() - firstDate.getTime();
        TimeUnit time = TimeUnit.DAYS; 
        diffrence = time.convert(diff, TimeUnit.MILLISECONDS);
	}catch(ParseException e) {
		e.printStackTrace();
	}
	return diffrence;
}
%>
<%
//取得日期
SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmss");
String SC01 = date.format(new Date());
String TDATE = String.valueOf(Integer.parseInt((DateTime.getToday()).replaceAll("/", ""))-19110000); //民國年

String URA004006=request.getRequestURI();
if (URA004006.lastIndexOf("/") != -1 && URA004006.lastIndexOf(".") != -1){
	URA004006=URA004006.substring(URA004006.lastIndexOf("/")+1,URA004006.lastIndexOf("."));
}
//ResourceBundle RB1 = ResourceBundle.getBundle("KCG");
//String FromServer = RB1.getString("FromServer");
//out.print("來源："+FromServer+"</br>");
%>