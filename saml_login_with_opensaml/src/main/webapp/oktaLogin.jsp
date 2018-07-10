<%@page import="org.opensaml.DefaultBootstrap"%> 
<%@page import="org.opensaml.saml2.core.AuthnRequest"%> 
<%@page import="org.opensaml.xml.io.Marshaller"%> 
<%@page import="org.opensaml.xml.util.Base64"%> 
<%@page import="org.opensaml.xml.util.XMLHelper"%> 

<%@page import="java.io.ByteArrayOutputStream"%> 
<%@page import="java.io.StringWriter"%> 
<%@page import="java.net.URLEncoder"%> 
<%@page import="java.util.zip.Deflater"%> 
<%@page import="java.util.zip.DeflaterOutputStream"%> 
<%@page import="org.opensaml.common.SAMLVersion"%> 
<%@page import="org.opensaml.saml2.core.AuthnContextClassRef"%> 
<%@page import="org.opensaml.saml2.core.AuthnContextComparisonTypeEnumeration"%> 
<%@page import="org.opensaml.saml2.core.AuthnRequest"%> 
<%@page import="org.opensaml.saml2.core.Issuer"%> 
<%@page import="org.opensaml.saml2.core.NameIDPolicy"%> 
<%@page import="org.opensaml.saml2.core.RequestedAuthnContext"%> 
<%@page import="org.opensaml.saml2.core.impl.AuthnContextClassRefBuilder"%> 
<%@page import="org.opensaml.saml2.core.impl.AuthnRequestBuilder"%> 
<%@page import="org.opensaml.saml2.core.impl.IssuerBuilder"%> 
<%@page import="org.opensaml.saml2.core.impl.NameIDPolicyBuilder"%> 
<%@page import="org.opensaml.saml2.core.impl.RequestedAuthnContextBuilder"%> 
<%@page import="java.util.UUID"%> 
<%@page import="org.joda.time.DateTime"%> 
<%@page import="org.opensaml.xml.ConfigurationException"%> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attempting Login</title>
</head>
<body>
<%try {
	DefaultBootstrap.bootstrap();
	System.out.println("2");
	
	}
	 catch(ConfigurationException ce){
		 ce.printStackTrace();
	//throw new RuntimeException("Unable to initialize SAML");
	} %>
<%
String SAML2_NAME_ID_POLICY = "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"; 
String SAML2_PROTOCOL = "urn:oasis:names:tc:SAML:2.0:protocol";
String SAML2_POST_BINDING = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST";
String SAML2_PASSWORD_PROTECTED_TRANSPORT = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport";
String SAML2_ASSERTION = "urn:oasis:names:tc:SAML:2.0:assertion";



String idpAppURL = "https://dev-692312.oktapreview.com/app/zohodev692312_demo_3/exkfo2jcyft3cP8ja0h7/sso/saml";
String relayState = "?articleId=1234";
String assertionConsumerServiceUrl = "https://login.company.com/ssorequest/idp/okta";
String issuerId = "http://www.okta.com/exka9jbh72o7D4REL0h7";

String redirectUrl = null;
	
    String url = null;

    try {
    	
        DateTime issueInstant = new DateTime();
        AuthnRequestBuilder authRequestBuilder = new AuthnRequestBuilder();
        AuthnRequest authRequest = authRequestBuilder.buildObject(SAML2_PROTOCOL, "AuthnRequest", "samlp");
        authRequest.setForceAuthn(Boolean.FALSE);
        authRequest.setIsPassive(Boolean.FALSE);
        authRequest.setIssueInstant(issueInstant);//time
        authRequest.setProtocolBinding(SAML2_POST_BINDING);
        authRequest.setAssertionConsumerServiceURL(assertionConsumerServiceUrl);
        
        IssuerBuilder issuerBuilder = new IssuerBuilder(); 
        Issuer issuer = issuerBuilder.buildObject(); 
        issuer.setValue(issuerId);
        authRequest.setIssuer(issuer); 
        
        NameIDPolicy nameIDPolicy = new NameIDPolicyBuilder().buildObject(); 
        nameIDPolicy.setFormat(SAML2_NAME_ID_POLICY); 
        nameIDPolicy.setAllowCreate(Boolean.TRUE); 
        authRequest.setNameIDPolicy(nameIDPolicy); 
        
        AuthnContextClassRefBuilder authnContextClassRefBuilder = new AuthnContextClassRefBuilder();
        AuthnContextClassRef authnContextClassRef = 
          authnContextClassRefBuilder.buildObject(SAML2_ASSERTION, "AuthnContextClassRef", "saml");
        authnContextClassRef.setAuthnContextClassRef(SAML2_PASSWORD_PROTECTED_TRANSPORT);
        
        //Create RequestedAuthnContext
        RequestedAuthnContextBuilder requestedAuthnContextBuilder = new RequestedAuthnContextBuilder();
        RequestedAuthnContext requestedAuthnContext = 
          requestedAuthnContextBuilder.buildObject();
        requestedAuthnContext.setComparison(AuthnContextComparisonTypeEnumeration.EXACT);
        requestedAuthnContext.getAuthnContextClassRefs().add(authnContextClassRef);
        
        authRequest.setRequestedAuthnContext(requestedAuthnContext);
        authRequest.setID(UUID.randomUUID().toString()); 
        authRequest.setVersion(SAMLVersion.VERSION_20);
        
        
        Marshaller marshaller = org.opensaml.Configuration.getMarshallerFactory().getMarshaller(authRequest);
        
        org.w3c.dom.Element authDOM = marshaller.marshall(authRequest);
        
        StringWriter rspWrt = new StringWriter();
        XMLHelper.writeNode(authDOM, rspWrt);
        String messageXML = rspWrt.toString();

        Deflater deflater = new Deflater(Deflater.DEFLATED, true);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        DeflaterOutputStream deflaterOutputStream = new DeflaterOutputStream(byteArrayOutputStream, deflater);
        deflaterOutputStream.write(messageXML.getBytes());
        deflaterOutputStream.close();
        String samlRequest = Base64.encodeBytes(byteArrayOutputStream.toByteArray(), Base64.DONT_BREAK_LINES);
      	samlRequest = URLEncoder.encode(samlRequest,"UTF-8");
      	
      // Prepare final Url
      url = idpAppURL + "?SAMLRequest=" + samlRequest + "&RelayState=" + URLEncoder.encode(relayState,"UTF-8");
      
    } catch (Exception ex) {
     ex.printStackTrace();
   
     // throw new RuntimeException("Unable to generate redirect Url");
    }

    
    redirectUrl = url;
    response.sendRedirect(redirectUrl);
    
    
%>

Test
</body>
</html>