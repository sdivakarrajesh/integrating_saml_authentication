<%@page import="java.io.BufferedInputStream"%> 
<%@page import="java.io.ByteArrayInputStream"%> 
<%@page import="java.io.FileInputStream"%> 
<%@page import="java.io.IOException"%> 
<%@page import="java.security.cert.CertificateException"%> 
<%@page import="java.security.cert.CertificateFactory"%> 
<%@page import="java.security.cert.X509Certificate"%> 
<%@page import="javax.servlet.http.HttpServletRequest"%> 
<%@page import="javax.servlet.http.HttpServletResponse"%> 
<%@page import="javax.xml.parsers.DocumentBuilder"%> 
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%> 
<%@page import="javax.xml.parsers.ParserConfigurationException"%> 
<%@page import="org.apache.commons.codec.binary.Base64"%> 
<%@page import="org.opensaml.Configuration"%> 
<%@page import="org.opensaml.DefaultBootstrap"%> 
<%@page import="org.opensaml.saml2.core.Response"%> 
<%@page import="org.opensaml.saml2.core.Subject"%> 
<%@page import="org.opensaml.security.SAMLSignatureProfileValidator"%> 
<%@page import="org.opensaml.xml.XMLObject"%> 
<%@page import="org.opensaml.xml.io.Unmarshaller"%> 
<%@page import="org.opensaml.xml.io.UnmarshallerFactory"%> 
<%@page import="org.opensaml.xml.io.UnmarshallingException"%> 
<%@page import="org.opensaml.xml.security.credential.Credential"%> 
<%@page import="org.opensaml.xml.security.x509.BasicX509Credential"%> 
<%@page import="org.opensaml.xml.signature.SignatureValidator"%> 
<%@page import="org.w3c.dom.Document"%> 
<%@page import="org.w3c.dom.Element"%> 
<%@page import="org.xml.sax.SAXException"%> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
	 <meta http-equiv="X-UA-Compatible" content="IE=edge">
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <title>Done</title>
	 <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<title>Login Success</title>
</head>
<body>

<%
String responseString = (String) request.getParameter("SAMLResponse");

/* Decoding Base64 response string to get the XML string */
String responseXml = new String(Base64.decodeBase64(responseString), "UTF-8");
out.println(responseXml);
/* Generating SAML Response object from XML string */
try{
	DefaultBootstrap.bootstrap();
}
catch(Exception exc){
	exc.printStackTrace();
}

DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
documentBuilderFactory.setNamespaceAware(true);
DocumentBuilder docBuilder = documentBuilderFactory.newDocumentBuilder();
ByteArrayInputStream is = new ByteArrayInputStream(responseXml.getBytes());
Document document = docBuilder.parse(is);
Element element = document.getDocumentElement();
Response response1 = null;
try{ 
	UnmarshallerFactory unmarshallerFactory = Configuration.getUnmarshallerFactory();
	Unmarshaller unmarshaller = unmarshallerFactory.getUnmarshaller(element);
	XMLObject xmlObj = unmarshaller.unmarshall(element);
	response1 = (Response) xmlObj;
	Subject subject = response1.getAssertions().get(0).getSubject();
	String username = subject.getNameID().getValue();
}
catch(Exception e){
	e.printStackTrace();
}	
int index = responseXml.lastIndexOf("</saml2:AttributeValue>");
String role = responseXml.substring(index-5,index);
out.println(role);

  if(role.equals("admin"))response.sendRedirect("Admin.jsp");
  else response.sendRedirect("User.jsp");
  session.setAttribute("idp", "okta");
%>



</body>
</html>