using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace Bouncer
{
	public class Player : BasePlayer {
	}

    [RoomType("Bouncer")]
	public class GameCode : Game<Player> {

        // This method is called when a player sends a message into the server code
        public override void GotMessage(Player player, Message message)
        {
            base.GotMessage(player, message);
            Broadcast(message);
		}
	}
}
