package lmlnplayer.model;

import js.html.audio.AudioBuffer;
import lmlnplayer.ApplicationFacade;
import lmlnplayer.view.PlayerMediator;
import org.puremvc.haxe.patterns.proxy.Proxy;

/**
 * ...
 * @author suiheilibe
 */
class PlaybackProxy extends Proxy
{
	public static inline var NAME = "PlaybackProxy";

	private var waapi: WAAPI;
	private var ab: AB;
	private var curABInfo: ABInfo = null;
	private var curTrackId: Int = null;

	public function new(global: Dynamic) 
	{
		super(NAME);
		waapi = WAAPI.getInstance(global);
		ab = new AB();
	}

	public function load(uri: String, loopStart: Float, loopEnd: Float, ?startPlaying: Bool=true): Bool
	{
		var id = ab.getId(uri);
		if (id == null) {
			var newid = ab.add(uri);
			if (startPlaying) {
				setCurTrackId(newid);
			}
			waapi.load(uri, function (uri, buf) {
				var info = ab.get(newid);
				info.loopStart = loopStart;
				info.loopEnd = loopEnd;
				info.buffer = buf;
				info.ready = true;

				// 将来的にはロード状態をViewに反映させるために使われる
				sendNotification(ApplicationFacade.LOAD_COMPLETE_AUDIO, newid);

				if (startPlaying) {
					play(newid);
				}
				
				return true;
			});
		} else {
			if (startPlaying) {
				setCurTrackId(id);
				play(id);
			}
		}
		return true;
	}

	// このメソッドをViewが呼び出すことはない
	public function play(id: Int): Bool
	{
		// ロード中に再生曲が変わっていたら再生しない
		if (id != curTrackId) {
			ab.remove(id);
			return false;
		}
		var info = ab.get(id);
		var prev = setCurABInfo(info);
		waapi.stop(prev);
		waapi.play(info);
		if (prev != null && prev != info) {
			ab.remove(prev.id);
		}

		// PlayerMediatorが処理する
		sendNotification(ApplicationFacade.PLAYBACK_START);

		return true;
	}
	
	public function stop(id: Int): Bool
	{
		var info = ab.get(id);
		waapi.stop(info);
		setCurABInfo(null);
		ab.remove(id);
		
		return true;
	}
	
	private function setCurTrackId(id: Int): Int
	{
		var prev = curTrackId;
		curTrackId = id;
		
		return prev;
	}
	
	private function setCurABInfo(info: ABInfo): ABInfo
	{
		var prev = curABInfo;
		curABInfo = info;
		
		return prev;
	}
}