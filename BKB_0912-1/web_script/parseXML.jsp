<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.Element" %>
<%!
private Map[] parseXML(String filePath){
  String msg = "";

  List rowList = new ArrayList();
  try{
    File fXmlFile = new File(filePath);
    DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
    Document doc = dBuilder.parse(fXmlFile);

    //optional, but recommended
    //read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
    
    doc.getDocumentElement().normalize();

    /*
    out.println("Root element :" + doc.getDocumentElement().getNodeName());
    */

    NodeList RECS_NodeList = doc.getElementsByTagName("RECS");

    Element REC_Element = (Element) RECS_NodeList.item(0);

    NodeList REC_NodeList = REC_Element.getElementsByTagName("REC");

    for(int A=0; A<REC_NodeList.getLength(); A++){
      //xml = "";

      Node REC_Node = REC_NodeList.item(A);
      /*
      msg += "===== DATA " + A + " =====<br>";
      msg += iterateNodes(new HashMap(), REC_Node);
      msg += "<br><br>";
      */

      rowList.add(iterateNodes(new HashMap(), REC_Node));
    }

  }catch(Exception e){
    e.printStackTrace();
    //msg = e.toString();
  }

  return (Map[])(Map[])rowList.toArray(new Map[0]);
}

private Map iterateNodes(Map rowMap, Node node){
  NodeList nodeList = node.getChildNodes();

  for(int A=0; A<nodeList.getLength(); A++){
    Node currentode = nodeList.item(A);

    if(currentode.getNodeType() == Node.ELEMENT_NODE){
      Element element = (Element) currentode;

      iterateNodes(rowMap, element);
    }else if(currentode.getNodeType() == Node.TEXT_NODE){
      if(currentode.getParentNode().getChildNodes().getLength() == 1){
        //xml += currentode.getParentNode().getNodeName() + ": " + currentode.getTextContent();
        //xml += ", ";

        rowMap.put(currentode.getParentNode().getNodeName(), currentode.getTextContent() != null ? currentode.getTextContent() : "");
      }
    }
  }

  return rowMap;
}
%>