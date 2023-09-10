<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@ page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@ page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCell" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.OutputStream" %>
<%!
public Workbook getWorkbook(File file) throws IOException{
	String EXCEL_XLS = "xls";
	String EXCEL_XLSX = "xlsx";
	Workbook wb = null;
	FileInputStream in = new FileInputStream(file);  
	if(file.getName().endsWith(EXCEL_XLS)){  //Excel 2003  
		wb = new HSSFWorkbook(in);  
		System.out.println("Excel file type:xls");
	}else if(file.getName().endsWith(EXCEL_XLSX)){  // Excel 2007/2010  
		wb = new XSSFWorkbook(in); 
		System.out.println("Excel file type:xlsx");
	}  
	return wb;
}
public String[][] parse_excel(Workbook workbook) {
String[][] str = null;
int sheetCount = workbook.getNumberOfSheets(); // Total number of sheets
for(int s=0;s<1;s++ ){
	String sheetname = workbook.getSheetName(s);
	Sheet sheet = workbook.getSheetAt(s);//The first sheet
	int count = 0;
	int rowLength = sheet.getLastRowNum()+1;  //要多一行
	System.out.println("Total number of rows:" + rowLength);
	//Get the first line
	Row rowzero = sheet.getRow(0); 
	//Total number of columns 
	int colLength = rowzero.getLastCellNum(); 
	System.out.println("Total number of columns:" + colLength);
	str = new String[rowLength][colLength];
	for(int i=0;i<rowLength;i++){
		Row row = sheet.getRow(i);
		System.out.println("number of row:" + row);
		for(int j=0;j<colLength;j++){
			Cell cell = row.getCell(j);
			if(cell==null || "".equals(cell.toString())){
				str[i][j]="";
			}else{
				str[i][j]=cell.toString();
			}
		}
	}
}
return str;
}

public Boolean outputtoXLSX(String[][] str,String filename){
Boolean outstat = false;
OutputStream out = null;
try{ 
	String excelFileName = filename;//name of excel file
	String sheetName = "Sheet1";//name of sheet
	XSSFWorkbook wb = new XSSFWorkbook();
	XSSFSheet sheet = wb.createSheet(sheetName);
	for (int r=0;r<str.length;r++){
		XSSFRow row = sheet.createRow(r);
		//iterating c number of columns
		for (int c=0;c<str[0].length;c++ )
		{
			XSSFCell cell = row.createCell(c);
			cell.setCellValue(str[r][c]);
		}
	}
	FileOutputStream fileOut = new FileOutputStream(excelFileName);
	//write this workbook to an Outputstream.
	wb.write(fileOut);
	fileOut.flush();
	fileOut.close();
         
} catch (Exception e) {
	e.printStackTrace();  
} finally{
	try {  
		if(out != null){
			out.flush();
			out.close();
		}
	} catch (IOException e) {
		e.printStackTrace();
	}
}
outstat = true;
return outstat;
}

public Boolean outputtoXLS(String[][] str,String filename){
Boolean outstat = false;
OutputStream out = null;
try{ 
	String excelFileName = filename;//name of excel file
	String sheetName = "Sheet1";//name of sheet
	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet sheet = wb.createSheet(sheetName);
	for (int r=0;r<str.length;r++){
		HSSFRow row = sheet.createRow(r);
		//iterating c number of columns
		for (int c=0;c<str[0].length;c++ )
		{
			HSSFCell cell = row.createCell(c);
			cell.setCellValue(str[r][c]);
		}
	}
	FileOutputStream fileOut = new FileOutputStream(excelFileName);
	//write this workbook to an Outputstream.
	wb.write(fileOut);
	fileOut.flush();
	fileOut.close();
         
} catch (Exception e) {
	e.printStackTrace();  
} finally{
	try {  
		if(out != null){
			out.flush();
			out.close();
		}
	} catch (IOException e) {
		e.printStackTrace();
	}
}
outstat = true;
return outstat;
}
%>
<%
/*
File file = new File("D:\\Tomcat\\webapps\\TFA\\TFA999.xls");
//File file = new File("D:\\Tomcat\\webapps\\TFA\\WSA001.xlsx");
Workbook workbook = getWorkbook(file);
String[][] str = parse_excel(workbook);
for(int i=0;i<str.length;i++){
	String colstr = "";
	for(int j=0;j<str[0].length;j++){
		colstr += str[i][j]+",";
	}
	//out.print(colstr);
	//out.println("<br>");
}
String filename ="D:\\Tomcat\\webapps\\TFA\\test2010.xlsx";
Boolean outXLSX = outputtoXLSX(str,filename);
out.print(outXLSX);
filename ="D:\\Tomcat\\webapps\\TFA\\test2000.xls";
Boolean outXLS = outputtoXLS(str,filename);
out.print(outXLS);
*/
%>
