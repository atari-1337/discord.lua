"use strict";
const port = process.env.PORT || 8080; // This value can be switch to any number between 1024 and 49151, inclusive. 

// Modules
const express = require("express");
const WebSocket = require("ws");

// Quick Functions
function getop(data) {
  data = JSON.parse(data);
  if (data.op !== undefined) {
    return data.op;
  } else {
    return -1;
  };
};
function sleep(t) {
  return new Promise((resolve) => setTimeout(resolve, t));
};
function returnboolstate(ws) {
  return ws.readyState === ws.OPEN;
};
function sleepuntiltrue(f, arg, t) {
  if (f(arg) === false) {
    sleep(t).then(() => {
      sleepuntiltrue(f, arg, t);
    });
    return sleepuntiltrue(f, arg, t);
  } else {
    return new Promise((res, rej) => {
      res(true);
    });
  };
};

// Server
const heartbeat = `{
  "op": 1,
  "d": null
}`;
var websockets = {};
var log = {};
const server = express()
// .get("/start/:token")
.get("/start/:token", (req, res) => {
  if (req.params.token === req.headers.authorization) {
    if (req.headers.uri !== undefined) {

      log[req.params.token] = []
      websockets[req.params.token] = {
        "token": req.params.token, /* The Token */
        "ws": false, /* The WebSocket Object */
        "heartbeat":false, /* Heartbeat Time */
        "op11response":false, /* True when a heartbeat is sent to the server, but a response
        has not been returned yet. Used to detetc Zombied Connections. */
        "identified":false, /* True if the Opcode 2 Identify is sent and a Ready Event is returned. */
        "session":"0", /* SessionId */
        "seq": 0, /* SequenceNo. */
        "unavailable": false, /* Disconnects WebSocket and related functions if true */
        "hb": null /* The heartbeat function */
    };
      websockets[req.params.token]["ws"] = new WebSocket(req.headers.uri+"?v=8&encoding=json");

      // onmessage(e)
      var onmessage = (e) => {
        if (websockets[req.params.token] === undefined) {
          return;
        };
        console.log(e.data);
        if (JSON.parse(e.data)["s"] !== null || JSON.parse(e.data)["s"] !== undefined) {
          websockets[req.params.token]["seq"] = JSON.parse(e.data)["s"]
        };
        if (JSON.parse(e.data)["session_id"] !== null || JSON.parse(e.data)["session_id"] !== undefined) {
          websockets[req.params.token]["session"] = JSON.parse(e.data)["session_id"]
        };

        // Heartbeat
        if (getop(e.data) === 10) {
          websockets[req.params.token]["heartbeat"] = JSON.parse(e.data)["d"]["heartbeat_interval"];
          var hbfunc = () => {
            if (websockets[req.params.token]["unavailable"] === true) {
              clearInterval(websockets[req.params.token]["hb"]);
              websockets[req.params.token]["ws"].close(1000, "Normal Closure");
              return;
            };
            websockets[req.params.token]["ws"].send(heartbeat);
            websockets[req.params.token]["op11response"] = true;
            sleep(2000).then(() => {
            if (websockets[req.params.token]["op11response"] === true) {
              // Zombied Connection
              console.log("Zomibed Connection, attempting to reconnect...")
              websockets[req.params.token]["ws"].close(4999, "Zombied Connection");
              websockets[req.params.token]["ws"] = new WebSocket(req.headers.uri+"?v=8&encoding=json");
              websockets[req.params.token]["ws"].addEventListener("message",onmessage);
              websockets[req.params.token]["ws"].onopen = () => {
                websockets[req.params.token]["ws"].send(`{
                  "op": 6,
                  "d": {
                    "token": "${req.params.token}",
                    "session_id": "${ websockets[req.params.token]["session"]}",
                    "seq": ${ websockets[req.params.token]["seq"]}
                  }
                }`);
              };
            }});
            var wssendopcode2 = () => {
              websockets[req.params.token]["ws"].send(`{
                "op": 2,
                "d": {
                  "token": "${websockets[req.params.token]["token"]}",
                  "intents": ${req.headers.intents},
                  "properties": {
                    "$os": "linux",
                    "$browser": "my_library",
                    "$device": "my_library"
                  }
                }
              }`);
              websockets[req.params.token]["identified"] = true;
          };
          sleepuntiltrue(returnboolstate, websockets[req.params.token]["ws"], 500).then(() => {
            if (websockets[req.params.token]["identified"] === false) {
              wssendopcode2();
            };
          });
          };
          hbfunc();
          websockets[req.params.token]["hb"] = setInterval(hbfunc, websockets[req.params.token]["heartbeat"]);
          log[req.params.token].push(e.data);

        // Opcode 11 Heartbeat ACK
        } else if (getop(e.data) === 11) {
          log[req.params.token].push(e.data);
          websockets[req.params.token]["op11response"] = false;
        } else if (getop(e.data) === 0) {
          log[req.params.token].push(e.data);
        } else if (getop(e.data) === 9) {
          log[req.params.token].push(e.data);
        };
      };
      websockets[req.params.token]["ws"].addEventListener("message",onmessage);
      res.status(200).send("200 OK");
    } else {
      res.status(400).send("400 Bad Request");
    };
  } else {
    res.status(401).send("401 Unauthorized");
  };
})
.get("/get/:token", (req, res) => {
  if (req.params.token === req.headers.authorization) {
    if ((log[req.params.token] !== undefined) && (log[req.params.token] != [])) {
      console.log(log[req.params.token]);
      res.status(200).send(JSON.stringify(log[req.params.token]));
      log[req.params.token] = []
    } else if (log[req.params.token] === []) {
      console.log("204 No Content");
      res.status(204).send("204 No Content");
    } else {
      res.status(404).send("404 Not Found");
    };
  } else {
    res.status(401).send("401 Unauthorized");
  };
})
.delete("/close/:token", (req, res) => {
  if (req.params.token === req.headers.authorization) {
    if (websockets[req.params.token] !== undefined) {
      websockets[req.params.token]["unavailable"] = true;
      clearInterval(websockets[req.params.token]["hb"]);
      setTimeout(() => {
        delete websockets[req.params.token];
      }, 10000)
      res.status(200).send("200 OK")
    } else {
      res.status(404).send("404 Not Found")
    };
  } else {
    res.status(401).send("401 Unauthorized");
  };
})
.get("*", (req, res) => {
  res.status(404).send("404 Not Found");
})
.listen(port, () => console.log(`Listening on ${port}`));
