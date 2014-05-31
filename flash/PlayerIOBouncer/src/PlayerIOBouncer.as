package
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import playerio.Client;
	import playerio.Connection;
	import playerio.Message;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;

	public class PlayerIOBouncer extends EventDispatcher
	{
		private static const GAME_ID:String = "bouncer-jlmgaro8u02q5tpuxcgj0a";
		private static const ip_address:String = "172.16.73.133:8184";
		private var room:String;
		public var client:Object = null;
		public var online:Boolean = false;
		
		private var connection:Connection;
		
		public function PlayerIOBouncer()
		{
		}
		
		public function connect(stage:Stage,room:String,username:String=null):void {
			this.room = room;
			var user:String = username?username:"guest_"+Math.random();
			
			PlayerIO.connect(
				stage,								//Referance to stage
				GAME_ID,							//Game id (Get your own at playerio.com. 1: Create user, 2:Goto admin pannel, 3:Create game, 4: Copy game id inside the "")
				"public",							//Connection id, default is public
				user,								//Username
				"",									//User auth. Can be left blank if authentication is disabled on connection
				null,								//Current PartnerPay partner.
				handleConnect,						//Function executed on successful connect
				handleError							//Function executed if we recive an error
			);
		}
		
		private function handleError(error:PlayerIOError):void{
			trace(error);
		}
		
		private function handleConnect(client:Client):void {
			trace("Sucessfully connected to Yahoo Games Network");
			//Set developmentsever (Comment out to connect to your server online)
			if(!online)
				client.multiplayer.developmentServer = ip_address;
			client.multiplayer.createJoinRoom(room,"Bouncer",true,{},{},onJoin,handleError);
		}
		
		private function onJoin(connection:Connection):void {
			trace("Sucessfully joined room:",room);
			connection.addMessageHandler("send",function(m:Message):void {
				var action:String = m.getString(0);
				var bytes:ByteArray = m.getByteArray(1);
				var params:Array = bytes.readObject() as Array;
				if(client.hasOwnProperty(action) && (client[action] is Function)) {
					(client[action] as Function).apply(client,params);
				}
			});
			this.connection = connection;	
			dispatchEvent(new Event(Event.CONNECT));
		}
		
		public function call(action:String,...params):void {
			if(connection) {
				var bytes:ByteArray = new ByteArray();
				bytes.writeObject(params);
				connection.send("send",action,bytes);
			}
		}
	}
}