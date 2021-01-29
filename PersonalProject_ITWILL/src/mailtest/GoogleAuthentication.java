package mailtest;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("kateshim5683@gmail.com", "tlqhsvciwhppryfy");
		
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}

