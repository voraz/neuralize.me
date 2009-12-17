package me.neuralize.app.controller{
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand{
		override protected function initializeMacroCommand():void{
			InitializerCommand.initialize()
			addSubCommand(RailsCommand);
		}
	}
}