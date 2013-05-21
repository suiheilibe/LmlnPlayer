package lmlnplayer.controller;

import js.Browser;
import lmlnplayer.model.PlaybackProxy;
import lmlnplayer.model.PlayerProxy;
import lmlnplayer.model.PlaylistProxy;
import lmlnplayer.view.PlayerMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
 * ...
 * @author suiheilibe
 */
class StartupCommand extends SimpleCommand
{

	override public function execute(notification: INotification): Void
	{
		facade.registerProxy(new PlayerProxy());
		facade.registerProxy(new PlaybackProxy(Browser.window));
		facade.registerProxy(new PlaylistProxy("media", "pack.dat"));
		facade.registerMediator(new PlayerMediator(null));
	}
}