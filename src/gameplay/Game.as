package gameplay 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import gameplay.world.World;
	import gameplay.world.WorldGenerator;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import nape.util.Debug;
	import utils.AdvInput;
	/**
	 * ...
	 * @author Ido Adar
	 */
	public class Game extends Sprite
	{
		//nape stuff
		public var mNapeSpace:Space;
		public var mNapeGravity:Vec2 = new Vec2(0, 600);
		public var mNapeDebugDraw:Debug;
		
		//visual layers
		public var mLayer_napeDebug:DisplayObject;
		
		//the world object, used to manage the world bodies(dynamic and static)
		public var mWorld:World;
		
		//a reference to the stage
		public var mStage:Stage;
		
		public function Game() 
		{
			//instantiate variables
			mNapeSpace = new Space(mNapeGravity);
			mWorld = new World(mNapeSpace);
			
			//init the nape debug draw
			initNapeDebugDraw();
			
			//add visual layers
			addChild(mLayer_napeDebug);
			
			//create the testing world
			mWorld.createWorldPhysObjs(0, 100, WorldGenerator.getTestCave(4));
			
			//initializes the enterFrame and other events. this should probably be moved or changed to some sort of init function
			registerEvents();
			
		}
		
		private function onEnterFrame(e:Event):void 
		{
			mNapeSpace.step(1 / Main.stageRef.frameRate);
			
			drawNapeDebug();
		}
		
		public function registerEvents():void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function clearEvents():void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		//====================================================================================================================================
		// +  NAPE DEBUG STUFF
		//====================================================================================================================================
		private function initNapeDebugDraw():void {
			mNapeDebugDraw = new BitmapDebug(Main.defaultWidth, Main.defaultHeight, 0, true);
			mLayer_napeDebug = mNapeDebugDraw.display;
		}
		private function drawNapeDebug():void {
			mNapeDebugDraw.clear()
			mNapeDebugDraw.draw(mNapeSpace);
			mNapeDebugDraw.flush();
		}
	}

}