package lmlnplayer.model;

import haxe.Http;
import lmlnplayer.ApplicationFacade;
import org.puremvc.haxe.patterns.proxy.Proxy;

/**
 * ...
 * @author suiheilibe
 */
typedef Entry = {
	start: Float,
	end: Float,
	title: String,
	uri: String
}

class PlaylistProxy extends Proxy
{
	public static inline var NAME = "PlaylistProxy";

	public function new(directory: String, filename: String) 
	{
		super(NAME);

		setData(null);
		fetchPackData(directory, filename);
	}
	
	override public function getData(): Array<Entry>
	{
		return cast data;
	}

	private function fetchPackData(directory: String, filename: String): Bool {
		var http = new Http(directory + "/" + filename);
		http.onData = function (data: String) {
			data = ~/\r\n/.replace(data, "\n");
			var lines = data.split("\n");
			var len = lines.length - 2;
			lines = lines.splice(2, len);
			
			var trackList = [];
			for (i in 0...len) {
				var line = lines[i];
				var idx1 = line.indexOf(",");
				var idx2 = line.indexOf(";");
				var start = line.substring(0, idx1);
				var end = line.substring(idx1+1, idx2);
				var title = line.substring(idx2+1);
				trackList[i] = {
					start: Std.parseFloat(start),
					end: Std.parseFloat(end),
					title: title,
					uri: directory + "/" + ("00" + i).substr( -2) + ".ogg"
				};
			}
			setData(trackList);
			sendNotification(ApplicationFacade.LOAD_COMPLETE_PLAYLIST);
		}
		http.request();
		return true;
	}
}