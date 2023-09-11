<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ page import="javax.imageio.*" %>
<%@ page import="javax.swing.*" %>
<%@ page import="java.awt.event.*" %>
<%@ page import="java.awt.Image" %>
<%@ page import="java.awt.Graphics" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="java.text.SimpleDateFormat" %> 

<%!
//CopyFile,A表原有路徑,B表複製路徑
public void copyFile(String oldPath, String newPath) {
try {
int bytesum = 0;
int byteread = 0;
File oldfile = new File(oldPath);
if (oldfile.exists()) { //檔存在時
InputStream inStream = new FileInputStream(oldPath);//讀入原檔
FileOutputStream fs = new FileOutputStream(newPath);
byte[] buffer = new byte[1444];
int length;
while ( (byteread = inStream.read(buffer)) != -1) {
bytesum += byteread; //位元組數 檔案大小
//System.out.println(bytesum);
fs.write(buffer, 0, byteread);
}
inStream.close();
}
}
catch(Exception e) {
System.out.println("複製單個檔操作出錯");
e.printStackTrace();
}
}

public void CopyFile(String A, String B) {
//String ST01 = "D:/"+A; 
//String ST02 = "D:/"+B; 
copyFile(A, B);
}
public String DelFile(String A) {
	String MSG = "刪除失敗";  //回傳訊息
	java.io.File f = new java.io.File(A);
	if (f.exists()){
		f.delete();
		MSG = "刪除成功";
	}
	return MSG;
}

//來源路徑,輸出路徑,MAX寬度,MAX高度,圖片參數
//圖片參數 P為圖片 D為非圖片類型
public String CutImage(String InputPath,String OutputPath,int MaxWidth,int MaxHeight,String FileType){
  String MSG = "";  //回傳訊息
    try{
	  if(FileType.equals("P")){      //進入切圖程序，出錯代表非圖片格式，進入catch直接儲存搬移程序
		java.io.File f = new java.io.File(InputPath);
		BufferedImage bimg = ImageIO.read(f);
		int width = bimg.getWidth();    //設置輸出圖寬
		int height = bimg.getHeight();  //設置輸出圖高
		int Nfold = 0; 					//縮小倍率
		//算出需要變動的比例正值為不變，負值為需放大 	
		//代表寬超過MaxWidth或高超過MaxHeight
	    //只針對一邊做處理，比較需縮小的倍率 (比較後以較小的倍率為處理倍率，EX：寬需縮小0.6倍才符合MaxWidth內，高需縮小0.8倍才符合MaxHeight內，取0.6為處理倍率)
		if((width-MaxWidth) > 0 || (height-MaxHeight) > 0){
			if(MaxWidth/bimg.getWidth() < MaxHeight/bimg.getHeight()){
				Nfold = Math.round(100*MaxWidth/bimg.getWidth());
			}else{
				Nfold = Math.round(100*MaxHeight/bimg.getHeight());
			}
			width =  (int)(bimg.getWidth() * Nfold)/100;
			height =  (int)(bimg.getHeight() * Nfold)/100;
		}
		Image image = bimg.getScaledInstance(width, height, Image.SCALE_SMOOTH);
		BufferedImage target = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
		Graphics g = target.getGraphics();  
		g.drawImage(image, 0, 0, null);
		g.dispose(); 
		java.io.File saveFile = new java.io.File(OutputPath);
		//如果目錄不存在.則會自動建立
		saveFile.getParentFile().mkdirs();
		ImageIO.write(target, "jpg", new java.io.File(OutputPath)); //轉為jpg格式儲存
		f.delete();
		MSG = "上傳成功";
	  }else if(FileType.equals("D")){
			String ST01 = InputPath;
			java.io.File f = new java.io.File(ST01);
			ST01 = ST01.replaceAll("\\\\","/");
			java.io.File saveFile = new java.io.File(OutputPath);
			//如果目錄不存在.則會自動建立
			saveFile.getParentFile().mkdirs();
			if (f.exists()){
				CopyFile(ST01,OutputPath);
				f.delete();
			}
			MSG = "非圖片檔案，上傳成功";
	    }else{
			MSG = "非圖片檔案，不予上傳";
		}
    }catch(Exception e){
	    if(FileType.equals("D")){
			String ST01 = InputPath;
			java.io.File f = new java.io.File(ST01);
			ST01 = ST01.replaceAll("\\\\","/");
			java.io.File saveFile = new java.io.File(OutputPath);
			//如果目錄不存在.則會自動建立
			saveFile.getParentFile().mkdirs();
			if (f.exists()){
				CopyFile(ST01,OutputPath);
				f.delete();
			}
			MSG = "非圖片檔案，上傳成功";
	    }else{
			MSG = "非圖片檔案，不予上傳";
		}
    }
  return MSG;
}

%>
