# integrating_saml_authentication

## What this application does?

This is a sample application that demonstrates SP-intitiated login flow. The one clicking the login button, the user is redirected to the identity provider's website 
where the user enters his/her login details and becomes authenticated. A simple forming of the SAML request and parsing of the SAML request is included in the code.
Simply create a dynamic-web project and import the code as a maven project in your favorite IDE.. preferrably eclipse EE Mars

This sample application makes use of OKTA as the identity provider to provide authentication for a test application that redirects based on the user's role, whether its Admin or user.

This application uses the openSAML library and few other dependencies to create and parse the SAML response and request.

To know the list of all the dependencies see the POM.xml

## How to get this application up and running:

- Clone or download the application using the links above

- After downloading unzip and navigate to the saml_login_with_opensaml\src\main\webapp 

- Open the oktaLogin.jsp and modify these three String values

		1) idpAppURL (which is the Single-Sign-On URL)
		
		2) assertionConsumerServiceUrl (acs for short)
		
		3) issuerId
		
- These values can be obtained by creating a developer account in okta or anyother identity provider and by following the steps to create a SAML authenticaiton using the instruction.
Referring the documentation is the right solution to get to know the right procedure.



		