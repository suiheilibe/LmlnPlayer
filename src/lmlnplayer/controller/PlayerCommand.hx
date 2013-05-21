package lmlnplayer.controller;

import lmlnplayer.ApplicationFacade;
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
class PlayerCommand extends SimpleCommand
{
	private var playback: PlaybackProxy = null;
	private var playlist: PlaylistProxy = null;
	private var player: PlayerProxy = null;
	private var mediator: PlayerMediator = null;

	override public function execute(notification: INotification): Void
	{
		playback = cast facade.retrieveProxy(PlaybackProxy.NAME);
		playlist = cast facade.retrieveProxy(PlaylistProxy.NAME);
		player = cast facade.retrieveProxy(PlayerProxy.NAME);
		mediator = cast facade.retrieveMediator(PlayerMediator.NAME);

		switch (notification.getName()) {
			case ApplicationFacade.CTRL_PREV:
				navigate(-1);
			case ApplicationFacade.CTRL_PLAY:
				navigate(0);
			case ApplicationFacade.CTRL_NEXT:
				navigate(1);
		}
	}
	
	private function navigate(offset: Int): Void
	{
		var playlistvo = playlist.getData();
		if (playlistvo == null) {
			return;
		}
		var tracks = playlistvo.length;
		var playervo = player.getData();
		var trackno = playervo.trackNo;
		trackno += offset;
		if (trackno < 0) {
			trackno = 0;
		}
		if (trackno >= tracks) {
			trackno = tracks - 1;
		}
		var trackdata = playlistvo[trackno];
		playback.load(trackdata.uri, trackdata.start, trackdata.end);
		player.update(trackno, trackdata.title);
	}
}