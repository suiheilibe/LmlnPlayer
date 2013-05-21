package ;

import lmlnplayer.ApplicationFacade;

/**
 * ...
 * @author suiheilibe
 */

class Main 
{
	
	static function main() 
	{
		var facade = ApplicationFacade.getInstance();
		facade.sendNotification(ApplicationFacade.STARTUP);
	}
	
}