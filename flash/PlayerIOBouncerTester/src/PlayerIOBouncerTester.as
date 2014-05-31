package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PlayerIOBouncerTester extends Sprite
	{
		private var bouncer:PlayerIOBouncer = new PlayerIOBouncer();
		public function PlayerIOBouncerTester()
		{
			bouncer.client = this;
			bouncer.online = false;
			bouncer.connect(root.stage,"bounceroom");
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
		}
		
		private function onMove(e:MouseEvent):void {
			bouncer.call("serverMove",e.stageX,e.stageY);
		}
		
		public function serverMove(x:Number,y:Number):void {
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawCircle(x,y,10);
			graphics.endFill();
		}
	}
}