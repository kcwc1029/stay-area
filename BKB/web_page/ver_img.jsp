<!--<pre class="c" name="code">-->
<%@page contentType="image/jpeg" pageEncoding="UTF-8"%>
<%@page import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*"%>
<%@ include file="../web_script/WSA010400.jsp"%>
<%!
Color getRandColor(int fc,int bc){//給定範圍獲得隨機顏色
        Random random = new Random();
        if(fc>255) fc=255;
        if(bc>255) bc=255;
        int r=fc+random.nextInt(bc-fc);
        int g=fc+random.nextInt(bc-fc);
        int b=fc+random.nextInt(bc-fc);
        return new Color(r,g,b);
        }
%>
<%
//設定頁面不緩存
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

String[] AR01 = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};

// 在記憶體中創建圖像
int width=60, height=20;
BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

// 獲取圖形上下文
Graphics g = image.getGraphics();

//生成隨機類
Random random = new Random();

// 設定背景色
g.setColor(getRandColor(200,250));
g.fillRect(0, 0, width, height);

//設定字體
g.setFont(new Font("Times New Roman",Font.PLAIN,18));

// 隨機產生155條干擾線，使圖像中的認證碼不易被其他程式探測到
g.setColor(getRandColor(160,200));
for (int i=0;i<155;i++)
{
 int x = random.nextInt(width);
 int y = random.nextInt(height);
 int xl = random.nextInt(12);
 int yl = random.nextInt(12);
 g.drawLine(x,y,x+xl,y+yl);
}

// 取隨機產生的認證碼(4位元數位)
String sRand="";
String rand="";
for (int i=0;i<4;i++){
  if (i%2 == 0){
  rand=String.valueOf(random.nextInt(10));
  } else {
  rand=String.valueOf(AR01[random.nextInt(52)]);
  }
    sRand+=rand;
    // 將認證碼顯示到圖像中
    g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));// 調用函數出來的顏色相同，可能是因為種子太接近，所以只能直接生成
    g.drawString(rand,13*i+6,16);
}

// 將認證碼存入SESSION
String CHK01 = SQLIJ(request.getParameter("CHK01"));
if (!CHK01.equals("") && CHK01.substring(0,1).equals("A")){
session.setAttribute("rand",sRand);
}

// 圖像生效
g.dispose();

// 輸出圖像到頁面
ImageIO.write(image, "JPEG", response.getOutputStream());
out.clear();
out = pageContext.pushBody(); 
%>
