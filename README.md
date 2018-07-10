# integrating_saml_authentication

This sample application makes use of OKTA as the identity provider to provide authentication for a test application that redirects based on the user's role, whether its Admin or user.

How to get this application up and running:

> Clone or download the application using the links above
> After downloading unzip and navigate to the saml_login_with_opensaml\src\main\webapp 
> Open the oktaLogin.jsp and modify these three String values
		1)idpAppURL
		2)assertionConsumerServiceUrl
		3)issuerId
> These values can be obtained by creating a developer account in okta or anyother identity provider and by following the steps to create a SAML authenticaiton using the instruction.
Referring the documentation is the right solution to get to know the right procedure.



		