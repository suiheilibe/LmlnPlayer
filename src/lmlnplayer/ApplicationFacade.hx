package lmlnplayer;

import lmlnplayer.controller.PlayerCommand;
import lmlnplayer.controller.StartupCommand;
import org.puremvc.haxe.patterns.facade.Facade;
import WAAPI;

/**
 * ...
 * @author suiheilibe
 */
class ApplicationFacade extends Facade
{
	public static inline var STARTUP = "startup";
	public static inline var LOAD_COMPLETE_AUDIO = "load_complete_audio";
	public static inline var LOAD_COMPLETE_PLAYLIST = "load_complete_playlist";
	public static inline var PLAYBACK_START = "playback_start";
	public static inline var PLAYBACK_STOP = "playback_start";
	public static inline var CTRL_PREV = "ctrl_prev";
	public static inline var CTRL_PLAY = "ctrl_play";
	public static inline var CTRL_NEXT = "ctrl_pnext";
	public static inline var PLAYER_UPDATE = "player_update";

	private static var instance: ApplicationFacade = null;

	public static function getInstance(): ApplicationFacade
	{
		if (instance == null) {
			instance = new ApplicationFacade();
		}
		return instance;
	}
	
	override private function initializeController(): Void
	{
		super.initializeController();

		registerCommand(STARTUP, StartupCommand);
		registerCommand(CTRL_PREV, PlayerCommand);
		registerCommand(CTRL_PLAY, PlayerCommand);
		registerCommand(CTRL_NEXT, PlayerCommand);
	}
}