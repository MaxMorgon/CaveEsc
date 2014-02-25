package utils 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ido Adar
	 */
	public class AdvInput
	{
		
		//EVENTS
		public static const eKeyPress	:String = 'keyPress';
		public static const eKeyDown	:String = 'KeyDown';
		public static const eKeyUp		:String = 'KeyUp';
		public static const eMouseDown	:String = 'mouseDown';
		public static const eMouseUp	:String = 'mouseUp';
		
		
		//OTHER VARS
		public static var sMouseDown:Boolean = false;
		
		private static var psKeyMap:Object;
		
		private static var psStage:Stage;
		
		private static var psEvtDispatcher:EventDispatcher;
		
		/**
		 * Initializes this class and adds it's events.
		 * @param	stage	A reference to the main stage object.
		 */
		private static var psIsInitialized:Boolean = false;
		public static function init(stage:Stage):void {
			//verify that this class is only initialized once!
			if (psIsInitialized) return; psIsInitialized = true;
			
			//init key map
			psKeyMap = new Object();
			
			//init stage
			psStage = stage;
			
			//init event dispatcher
			psEvtDispatcher = new EventDispatcher();
			
			//init events
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
		 * This function checks whether a key is down or not. Amazing.
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
				if (psKeyMap[curKey] == 0) {
					psKeyMap[curKey] = 1;
					//dispatch event from internal static event system
					dispatchAdvKeyEvent(eKeyPress, e);
				}
				//dispatch event from internal static event system
				dispatchAdvKeyEvent(eKeyDown, e);
			}else if(e.type == KeyboardEvent.KEY_UP){
				psKeyMap[curKey] = 0;
				//dispatch event from internal static event system
				dispatchAdvKeyEvent(eKeyUp, e);
			}
		}
		
		/**
		 * This motherfucker is just like any other event adder!
		 * Remove your events when you're not using them or learn to useWeakReference!
		 */
		static public function addAdvEvent(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			psEvtDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * This motherfucker is just like any other event remover!
		 * If you're using this function to clean up after yourself, you're awesome!
		 */
		static public function removeAdvEvent(type:String, listener:Function, useCapture:Boolean = false):void {
			psEvtDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		static private function dispatchAdvKeyEvent(type:String, sourceEvent:KeyboardEvent):void 
		{
			var newEvt:KeyboardEvent = new KeyboardEvent(type, sourceEvent.bubbles, sourceEvent.cancelable,
														 sourceEvent.charCode, sourceEvent.keyCode, sourceEvent.keyLocation,
														 sourceEvent.ctrlKey, sourceEvent.altKey, sourceEvent.shiftKey);
			psEvtDispatcher.dispatchEvent(newEvt);
		}
		
		private static function onMouse(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.MOUSE_DOWN || e.type == MouseEvent.MOUSE_UP) {
				sMouseDown = e.type == MouseEvent.MOUSE_DOWN;
			}else if (e.type == MouseEvent.MOUSE_WHEEL){
				//todo: mousewheel code
			}
			
			//dispatch event from internal static event system
			psEvtDispatcher.dispatchEvent(e);
		}
		
		public function AdvInput(forceNoInstance:NO_INSTANCE_CLASS):void {
			//Can't instantiate this class byotch.
		}
		
	}
	
	
}
final class NO_INSTANCE_CLASS {}