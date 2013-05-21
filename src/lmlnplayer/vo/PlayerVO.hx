package lmlnplayer.vo;

/**
 * ...
 * @author suiheilibe
 */
class PlayerVO
{
	public var trackNo(default, null): Int = null;
	public var prevTrackNo(default, null): Int = null;
	public var displayTitle(default, null): String = null;
	
	public function new()
	{
	}

	public function update(trackNo: Int, displayTitle: String)
	{
		this.prevTrackNo = this.trackNo;
		this.trackNo = trackNo;
		this.displayTitle = displayTitle;
	}
}