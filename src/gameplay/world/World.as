package gameplay.world 
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Shape;
	import nape.space.Space;
	/**
	 * ...
	 * @author Ido Adar
	 */
	public class World
	{
		
		private var mNapeSpace:Space
		
		/**
		 * A world class used to contain the world objects
		 * @param	napeSpace
		 */
		public function World(napeSpace:Space) 
		{
			mNapeSpace = napeSpace;
		}
		
		/**
		 * This function creates the physical presences of shapes given to it as solid world meshes.
		 * Make sure ALL shapes are legal before providing them here.
		 * @param	objData		A vector of nape.shape.Shape.
		 */
		public function createWorldPhysObjs(x:Number, y:Number, objData:Vector.<Shape>):void {
			var body:Body = new Body(BodyType.STATIC);
			for (var iShape:int = 0; iShape < objData.length; iShape++) 
			{
				//create body using the current shape
				body.shapes.add(objData[iShape]);
			}
			body.position.x = x;
			body.position.y = y;
			
			body.space = mNapeSpace;
		}
		
	}

}