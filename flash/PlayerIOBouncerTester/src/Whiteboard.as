package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Whiteboard extends Sprite
	{
		private var bouncer:PlayerIOBouncer = new PlayerIOBouncer();
		private var point:Point = null;
		private var color:uint;
		public function Whiteboard()
		{
			bouncer.client = this;
			bouncer.online = true;
			bouncer.connect(root.stage,"bounceroom");
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			color = uint(Math.random()*uint.MAX_VALUE);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			point = new Point(e.stageX,e.stageY);
		}
		
		private function onMove(e:MouseEvent):void {
			if(e.buttonDown) {
				bouncer.call("serverDrawLine",point.x,point.y,e.stageX,e.stageY,color);
				point.x = e.stageX;
				point.y = e.stageY;
			}
		}
		
		public function serverDrawLine(fromX:Number,fromY:Number,toX:Number,toY:Number,color:uint):void {
			graphics.lineStyle(1,color);
			graphics.moveTo(fromX,fromY);
			graphics.lineTo(toX,toY);
		}
	}
}