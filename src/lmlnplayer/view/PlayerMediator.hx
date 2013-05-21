package lmlnplayer.view;

#if js
import js.Browser;
import js.html.Event;
import lmlnplayer.ApplicationFacade;
import lmlnplayer.model.PlayerProxy;
import lmlnplayer.model.PlaylistProxy;
import org.puremvc.haxe.interfaces.INotification;
#end
import org.puremvc.haxe.patterns.mediator.Mediator;

/**
 * ...
 * @author suiheilibe
 */
class PlayerMediator extends Mediator
{
	public static var NAME = "PlayerMediator";
	
	var playerId = 'lmln-player';
	var dispId = 'lmln-disp';
	var ctrlId = 'lmln-ctrl';
	var prevId = "lmln-ctrl-prev";
	var playId = "lmln-ctrl-play";
	var nextId = "lmln-ctrl-next";
	var contentPrefix = 'lmln-content';
	var hiddenClass = 'lmln-hidden';

	public function new(view) 
	{
		super(view);
		#if js
		var doc = Browser.document;

		var div = doc.createElement('div');
		div.id = playerId;

		var disp = doc.createElement('div');
		disp.id = dispId;
		div.appendChild(disp);

		var ctrl = doc.createElement('div');
		ctrl.id = ctrlId;
		div.appendChild(ctrl);
		
		var prev = doc.createElement('span');
		prev.appendChild(doc.createTextNode('<<'));
		prev.id = prevId;
		prev.addEventListener('click', function (e) {
			sendNotification(ApplicationFacade.CTRL_PREV);
			//stop();
			//playTrack(curTrackNo-1);
		});
		ctrl.appendChild(prev);
		
		var play = doc.createElement('span');
		play.appendChild(doc.createTextNode('play'));
		play.id = playId;
		play.addEventListener('click', function (e) {
			sendNotification(ApplicationFacade.CTRL_PLAY);
			//stop();
			//playTrack(curTrackNo)
		});
		ctrl.appendChild(play);
		
		var next = doc.createElement('span');
		next.appendChild(doc.createTextNode('>>'));
		next.id = nextId;
		next.addEventListener('click', function (e) {
			sendNotification(ApplicationFacade.CTRL_NEXT);
			//stop();
			//playTrack(curTrackNo+1);
		});
		ctrl.appendChild(next);

		doc.body.appendChild(div);
		#end
	}

	override public function listNotificationInterests(): Array<String>
	{
		return [
		ApplicationFacade.PLAYER_UPDATE,
		ApplicationFacade.LOAD_COMPLETE_PLAYLIST
		];
	}
	
	override public function handleNotification( notification: INotification ): Void
	{
		switch (notification.getName()) {
			case ApplicationFacade.PLAYER_UPDATE:
				playerUpdate();
			case ApplicationFacade.LOAD_COMPLETE_PLAYLIST:
				loadCompletePlaylist();
		}
	}
	
	private function playerUpdate(): Void
	{
		var player: PlayerProxy = cast facade.retrieveProxy(PlayerProxy.NAME);
		var playervo = player.getData();
		if (playervo.prevTrackNo != null) {
			Browser.document.getElementById(contentPrefix + playervo.prevTrackNo)
			.setAttribute("class", hiddenClass);
		}
		Browser.document.getElementById(contentPrefix + playervo.trackNo)
		.setAttribute("class", "");
	}
	
	private function loadCompletePlaylist(): Void
	{
		var playlist: PlaylistProxy = cast facade.retrieveProxy(PlaylistProxy.NAME);
		var playlistvo = playlist.getData();
		
		#if js
		var doc = Browser.document;
		var disp = doc.getElementById(dispId);
		for (i in 0...playlistvo.length) {
			var content = doc.createSpanElement();
			content.id = contentPrefix + i;
			content.setAttribute("class", hiddenClass);
			content.appendChild(
			  doc.createTextNode(i + " " + playlistvo[i].title));
			disp.appendChild(content);
		}
		#end
	}
}