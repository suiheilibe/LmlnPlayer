package ;

import js.html.audio.AudioBuffer;
import js.html.audio.AudioContext;
import js.html.XMLHttpRequest;

/**
 * ...
 * @author suiheilibe
 */
class WAAPI
{
	private static var instance = null;

	private var ctx: AudioContext;
	
	function new(global: Dynamic) 
	{
		if (Reflect.hasField(global, "webkitAudioContext")) {
			ctx = cast untyped __js__("new webkitAudioContext()");
		} else {
			ctx = new AudioContext();
		}
	}

	public static function getInstance(?global: Dynamic) {
		if (instance == null) {
			instance = new WAAPI(global);
		}
		return instance;
	}
	
	public function play(info: ABInfo)
	{
		if (!info.ready) {
			//throw 'Not ready buffer';
			return;
		}
		if (info.playing) {
			return;
		}
		var source = ctx.createBufferSource();
		var audiobuf = info.buffer;
		var srate = audiobuf.sampleRate;
		source.buffer = audiobuf;
		if (info.loopStart > 0 && info.loopEnd > 0) {
			source.loop = true;
			source.loopStart = info.loopStart / srate;
			source.loopEnd = info.loopEnd / srate;
		}
		source.connect(ctx.destination, null, null);
		source.start(0);
		info.source = source;
		info.playing = true;
	}
	
	public function stop(info: ABInfo): Bool
	{
		if (info == null || !info.playing) {
			return false;
		}
		info.source.stop(0);
		info.source.disconnect(null);
		info.source = null;
		info.playing = false;
		
		return true;
	}
	
	public function load(url: String, cb: String -> AudioBuffer -> Bool): Bool
	{
		var xhr = new XMLHttpRequest();
		xhr.responseType = "arraybuffer";
		xhr.open("GET", url, true);
		xhr.onload = function (e) {
			ctx.decodeAudioData(
				cast xhr.response,
				function (buf) {
					return cb(url, buf);
				}
			);
		};
		xhr.send();

		return true;
	}
}