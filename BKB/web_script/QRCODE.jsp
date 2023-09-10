<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.awt.Color" %>
<%@ page import="java.awt.Graphics2D" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.EncodeHintType" %>
<%@ page import="com.google.zxing.WriterException" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@ page import="com.google.zxing.qrcode.decoder.ErrorCorrectionLevel" %>
<%@ page import="com.google.zxing.MultiFormatWriter"%>
<%!
private static void createQRImage(File qrFile, String qrCodeText, int size, String fileType) throws WriterException, IOException{
  // Create the ByteMatrix for the QR-Code that encodes the given String
  Hashtable hintMap = new Hashtable();
  hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
  QRCodeWriter qrCodeWriter = new QRCodeWriter();
  BitMatrix byteMatrix = qrCodeWriter.encode(qrCodeText, BarcodeFormat.QR_CODE, size, size, hintMap);
  // Make the BufferedImage that are to hold the QRCode
  int matrixWidth = byteMatrix.getWidth();
  BufferedImage image = new BufferedImage(matrixWidth, matrixWidth, BufferedImage.TYPE_INT_RGB);
  image.createGraphics();

  Graphics2D graphics = (Graphics2D) image.getGraphics();
  graphics.setColor(Color.WHITE);
  graphics.fillRect(0, 0, matrixWidth, matrixWidth);
  // Paint and save the image using the ByteMatrix
  graphics.setColor(Color.BLACK);

  for(int i=0; i<matrixWidth; i++){
    for(int j=0; j<matrixWidth; j++){
      if(byteMatrix.get(i, j)){
        graphics.fillRect(i, j, 1, 1);
      }
    }
  }
  ImageIO.write(image, fileType, qrFile);
}
/**
 * 將字串編成一維條碼的矩陣  
 * @param str
 * @param width
 * @param height
 * @return
 */ 
public static BitMatrix toBarCodeMatrix(String str, Integer width,Integer height) { 
	String CHARSET = "utf-8";
	if (width == null || width < 200) { 
		width = 200; 
	} 
	if (height == null || height < 50) { 
		height = 50; 
	} 
	try { 
		// 文字編碼 
		Hashtable<EncodeHintType, String> hints = new Hashtable<EncodeHintType, String>(); 
		hints.put(EncodeHintType.CHARACTER_SET, CHARSET); 
		BitMatrix bitMatrix = new MultiFormatWriter().encode(str, BarcodeFormat.CODE_128, width, height, hints); 
		return bitMatrix; 
	} catch (Exception e) { 
		e.printStackTrace(); 
	} 
	return null; 
}
public static BufferedImage toBufferedImage(BitMatrix matrix) { 
	int BLACK = 0xFF000000; 
    int WHITE = 0xFFFFFFFF; 
	int width = matrix.getWidth(); 
	int height = matrix.getHeight(); 
	BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB); 
	for (int x = 0; x < width; x++) { 
		for (int y = 0; y < height; y++) {
			image.setRGB(x, y, matrix.get(x, y) ? BLACK : WHITE); 
		} 
	} 
	return image; 
}
public static void writeToStream(BitMatrix matrix, String format, File stream) throws IOException { 
	BufferedImage image = toBufferedImage(matrix); 
	if (!ImageIO.write(image, format, stream)) { 
		throw new IOException("Could not write an image of format " + format); 
	} 
}
public static void writeToFile(BitMatrix matrix, String format, File file) throws IOException { 
	BufferedImage image = toBufferedImage(matrix); 
	if (!ImageIO.write(image, format, file)) { 
		throw new IOException("Could not write an image of format " 
				+ format + " to " + file); 
	} 
} 
private static void createBarCodeImage(File qrFile, String qrCodeText, Integer width, Integer height, String fileType) throws WriterException, IOException{
	BitMatrix matrix = toBarCodeMatrix(qrCodeText,width,height);
	writeToFile(matrix,fileType,qrFile);
}
%>
<%
/*
String TTB023001 = "A10812003";
String qrCodeText = "102103161115";
String filePath = "D:\\Tomcat\\webapps\\FSB\\web_upload\\FSA014\\"+TTB023001+".png";
int size = 500;
int width = 500;
int height = 100;
String fileType = "png";
File qrFile = new File(filePath);
qrFile.getParentFile().mkdirs();
//createQRImage(qrFile, qrCodeText, size, fileType);
createBarCodeImage(qrFile, qrCodeText, width, height, fileType);
*/
%>
