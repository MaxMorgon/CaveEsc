package utils 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ido Adar
	 */
	public class AdvInput
	{
		
		public static var sMouseDown:Boolean = false;
		
		private static var psKeyMap:Object;
		
		private static var psStage:Stage;
		
		/**
		 * Initializes this class and adds it's events.
		 * @param	stage	A reference to the main stage object.
		 */
		public static function init(stage:Stage):void {
			psKeyMap = new Object();
			
			psStage = stage;
			psStage.addEventListener(KeyboardEvent.KEY_DOWN	, onKey);
			psStage.addEventListener(KeyboardEvent.KEY_UP		, onKey);
			psStage.addEventListener(MouseEvent.MOUSE_DOWN	, onMouse);
			psStage.addEventListener(MouseEvent.MOUSE_UP		, onMouse);
		}
		
		/**
		 * Clears all events and data used by this class.
		 */
		public static function destroy():void {
			psStage.removeEventListener(KeyboardEvent.KEY_DOWN		, onKey);
			psStage.removeEventListener(KeyboardEvent.KEY_UP		, onKey);
			psStage.removeEventListener(MouseEvent.MOUSE_DOWN		, onMouse);
			psStage.removeEventListener(MouseEvent.MOUSE_UP			, onMouse);
		}
		
		/**
		 * This function check whether a key is down or not. Amazing.
		 * @param	keyCode		The key code to check for
		 * @return True if the key is down, false if not. Complicated.
		 */
		public static function isKeyDown(keyCode:uint):Boolean {
			return psKeyMap["k" + keyCode] > 0;
		}
		
		/**
		 * This function check whether a key is pressed or not.
		 * This means you get one tick of true, and the rest is false,
		 * until the player leaves the key and presses it again.
		 * @param	keyCode		The key code to check for
		 * @return True if the key is pressed, false if not.
		 */
		public static function isKeyPressed(keyCode:uint):Boolean {
			var curKey:String = "k" + keyCode;
			if (psKeyMap[curKey] == 1) {
				psKeyMap[curKey] = 2;
				return true;
			}
			return false;
		}
		
		private static function onKey(e:KeyboardEvent):void 
		{
			//make key name
			var curKey:String = "k" + e.keyCode;
			//if undefined, create!
			if (psKeyMap[curKey] == undefined) psKeyMap[curKey] = 0;
			//handle events
			if (e.type == KeyboardEvent.KEY_DOWN) {
				if (psKeyMap[curKey] == 0) psKeyMap[curKey] = 1;
			}else if(e.type == KeyboardEvent.KEY_UP){
				psKeyMap[curKey] = 0;
			}
		}
		
		private static function onMouse(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.MOUSE_DOWN || e.type == MouseEvent.MOUSE_UP) {
				sMouseDown = e.type == MouseEvent.MOUSE_DOWN;
			}else if (e.type == MouseEvent.MOUSE_WHEEL){
				//todo: mousewheel code
			}
			
		}
		
		public function AdvInput(forceNoInstance:NO_INSTANCE_CLASS):void {
			//Can't instantiate this class byotch.
		}
		
	}
	
	
}
final class NO_INSTANCE_CLASS {}