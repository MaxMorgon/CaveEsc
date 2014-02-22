package gameplay.world 
{
	import nape.geom.Vec2;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	/**
	 * ...
	 * @author Ido Adar
	 */
	public class WorldGenerator 
	{
		/**
		 * Creates a simple cave to test out gameplay.
		 * @param	x			The x position of the first vertex.
		 * @param	y			The y position of the first vertex.
		 * @param	length		The length of the cave in units.
		 * @return
		 */
		public static function getTestCave(length:int = 10, caveHeight:Number = 400, unitLength:Number = 1000, shapeThickness:Number = 50, waveOffset:Number = 50):Vector.<Shape> {
			//arbitrary numbers
			var shapeLength:Number = unitLength*.5;
			//create all units
			var result:Vector.<Shape> = new Vector.<Shape>();
			
			var curX:Number = 0
			for (var i:int = 0; i < length; i++) 
			{
				
				createUnit(curX, result);
				curX += unitLength;
			}
			return result;
			
			
			//create a single unit
			function createUnit(x:Number, appendTo:Vector.<Shape>):void {
				var vertsA:Vector.<Vec2> = new Vector.<Vec2>;
				var vertsB:Vector.<Vec2> = new Vector.<Vec2>;
				vertsA.push(new Vec2(0, 0),
							new Vec2(shapeLength, -waveOffset),
							new Vec2(shapeLength, -waveOffset + shapeThickness),
							new Vec2(0, shapeThickness));
				vertsB.push(new Vec2(0, 0),
							new Vec2(shapeLength, waveOffset),
							new Vec2(shapeLength, waveOffset + shapeThickness),
							new Vec2(0, shapeThickness));
				
				var polyA:Polygon = new Polygon(vertsA);
				var polyB:Polygon = new Polygon(vertsA);
				var polyC:Polygon = new Polygon(vertsB);
				var polyD:Polygon = new Polygon(vertsB);
				polyA.translate(new Vec2(x, 0));
				polyB.translate(new Vec2(x, caveHeight));
				polyC.translate(new Vec2(x + shapeLength, -waveOffset));
				polyD.translate(new Vec2(x + shapeLength, caveHeight - waveOffset));
				
				appendTo.push(polyA, polyB, polyC, polyD);
			}
		}
		
	}

}