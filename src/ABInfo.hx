package ;

import js.html.audio.AudioBuffer;
import js.html.audio.AudioBufferSourceNode;

/**
 * ...
 * @author suiheilibe
 */
typedef ABInfo = {
	id: Int,
	url: String,
	buffer: AudioBuffer,
	source: AudioBufferSourceNode,
	pos: Float,
	loopStart: Float,
	loopEnd: Float,
	playing: Bool,
	paused: Bool,
	ready: Bool,
	failed: Bool
}
