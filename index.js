var identified = false;
		function sleep(ms) {
			const date = Date.now();
			let currentDate = null;
			do {
				currentDate = Date.now();
				 } while (currentDate - date < ms);
			return currentDate - date;
		};
		let ws = new WebSocket("wss://gateway.discord.gg/?v=8&encoding=json");
		ws.onmessage = function(e) {
			console.log(e);
		};
