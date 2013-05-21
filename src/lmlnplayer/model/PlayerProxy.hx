package lmlnplayer.model;

import lmlnplayer.ApplicationFacade;
import lmlnplayer.vo.PlayerVO;
import org.puremvc.haxe.patterns.proxy.Proxy;

/**
 * ...
 * @author suiheilibe
 */
class PlayerProxy extends Proxy
{
	public static var NAME = "PlayerProxy";

	public function new() 
	{
		super(NAME);
		setData(new PlayerVO());
	}
	
	override public function getData(): PlayerVO
	{
		return cast data;
	}
	
	public function update(trackNo: Int, displayTitle: String)
	{
		var vo: PlayerVO = getData();
		vo.update(trackNo, displayTitle);
		sendNotification(ApplicationFacade.PLAYER_UPDATE);
	}
}