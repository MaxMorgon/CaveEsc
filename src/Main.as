package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import gameplay.Game;
	import utils.AdvInput;

	/**
	 * ...
	 * @author Ido Adar
	 */
	[SWF(width="900", height="600", frameRate="60", backgroundColor='0')]
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		
		public static const defaultWidth:int = 900;
		public static const defaultHeight:int = 600;
		
		public static var game:Game;
		
		public static var stageRef:Stage;

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//make a static reference to the stage, easily accessible from anywhere
			stageRef = stage;
			
			//initialize the advance input class
			AdvInput.init(stage);
			
			game = new Game();
			
			//testing purposes only
			addChild(game);
		}
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

}