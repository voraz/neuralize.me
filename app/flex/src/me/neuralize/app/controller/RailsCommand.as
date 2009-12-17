package me.neuralize.app.controller{
	import flash.net.registerClassAlias;
	
	import me.neuralize.vo.DatasetVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class RailsCommand extends SimpleCommand{
		
		override public function execute(notification:INotification) : void{
			registerClassAlias("me.neuralize.vo.DatasetVO", DatasetVO);
		}
		
	}
}
