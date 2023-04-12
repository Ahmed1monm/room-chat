const express = require('express');
const {createServer} = require('http');
const {Server} = require('socket.io');

const {addUser,
    removeUser,
    getUser,
    getUsersInRoom} = require('./utils/users');
const {generateMessage} = require("./utils/messages")

const app = express();

const httpServer = createServer(app);
const io = new Server(httpServer,{});

io.on("connection",(client)=>{
    console.log('new connection ....');
    
    client.on("join",({username, room},callback)=>{
        const {error, user} = addUser({id: client.id, username, room})
        
        if (error){
            return callback(error);
        }
        
        client.join(user.room);
        
        client.broadcast
        .to(user.room)
        .emit("message",generateMessage("Admin",`${user.username} joined to room`));
        client.emit("message",generateMessage("Admin","Welcome!"))
        
        io.to(user.room)
        .emit("roomData",{
            room: user.room,
            users: getUsersInRoom(user.room)
        })
        
        callback()
    });

    client.on("SendMessage",(message, callback)=>{
        const user = getUser(client.id);
        if(user){
            io.broadcast
            .to(user.room)
            .emit("message",generateMessage(user.username,message));

            callback("Delivered!")
        }
    });

    client.on("disconnect",()=>{
        const user = removeUser(client.id);
        if(user){
            
            io.to(user.room)
            .emit("eventMessage",generateMessage("Admin",`${user.username} left the chat`));
            
            io.to(user.room)
            .emit("roomData",{
                room: user.room,
                users: getUsersInRoom(user.room)
            });

        }
    });
   
});

httpServer.listen(3000,()=>{
    console.log('Server starts at port 3000')
});

io.engine.on("connection_error", (err) => {
    console.log(err.req);      // the request object
    console.log(err.code);     // the error code, for example 1
    console.log(err.message);  // the error message, for example "Session ID unknown"
    console.log(err.context);  // some additional error context
  });

