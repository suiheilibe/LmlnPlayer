package ;

import js.html.audio.AudioBuffer;

/**
 * ...
 * @author suiheilibe
 */
class AB
{
	private var loaded: Array<ABInfo>;
	private var loadedurl: Map<String,Array<Int>>;
	private var index: Int = 0;
	
	public function new()
	{
		loaded = [];
		loadedurl = new Map<String,Array<Int>>();
	}
	
	public function newId(): Int
	{
		return index++;
	}
	
	public function add(url: String)
	{
		var id = newId();
		loaded[id] = {
			id: id,
			url: url,
			buffer: null,
			source: null,
			pos: 0,
			loopStart: 0,
			loopEnd: 0,
			playing: false,
			paused: false,
			ready: false,
			failed: false
		};
		if (loadedurl.exists(url)) {
			loadedurl[url].push(id);
		} else {
			loadedurl[url] = [id];
		}
		return id;
	}
	
	public function get(id: Int): ABInfo
	{
		if (loaded[id] != null) {
			return loaded[id];
		}
		return null;
	}
	
	public function getId(url: String, ?index: Int): Int
	{
		if (index == null) {
			index = 0;
		}
		if (loadedurl.exists(url)) {
			return (loadedurl[url])[index];
		}
		return null;
	}
	
	public function remove(id: Int): Void
	{
		var info = loaded[id];
		var url = info.url;

		info.source = null;
		info.buffer = null;
		loaded[id] = null;
		loadedurl.remove(url);
		
		return;
	}
}