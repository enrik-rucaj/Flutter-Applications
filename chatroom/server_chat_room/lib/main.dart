import 'dart:io';
import 'dart:convert' show utf8;

// global variables

ServerSocket server;
List<ChatClient> clients = [];

void main() async{
  server = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);
  server.listen((client) {
    handleConnection(client);
  });
}

void handleConnection(Socket client){
  for(ChatClient c in clients){
    if(c._socket.remoteAddress.address == client.remoteAddress.address){
      clients.remove(c);
      break;
    }
  }
  
  print(clients.length);
  print('Connection from '
    '${client.remoteAddress.address}');

  clients.add(ChatClient(client));

}

void removeClient(ChatClient client){
  clients.remove(client);
}

void distributeMessage(ChatClient client, String message) async{
  for (ChatClient c in clients) {
    if (c != client){
      c.writeUser(client._user);
      await Future.delayed(Duration(milliseconds: 10));
      c.writeMessage(message);
    }
  }
}

void distributeImage(ChatClient client, List<int> image) async{
  for (ChatClient c in clients) {
    if (c != client){
      c.writeImage(image);
    }
  }
}

// ChatClient class for server

class ChatClient {
  Socket _socket;
  String _user;
  bool _isUserName = true;
  bool _isImage = false;
  
  ChatClient(Socket s){
    _socket = s;
    _socket.listen(messageHandler,
        onError: errorHandler,
        onDone: finishedHandler);
  }

  void messageHandler(data){
    if(_isUserName){
      _user = utf8.decode(data);
      _isUserName = false;
    }
    else{
        try {
          String message = utf8.decode(data);
          print(message);
          print("TEST1@@@@@@@@@@@@@");
          distributeMessage(this, message);
        } catch (e) {
          print(data);
          print("TEST1@@@@@@@@@@@@@@@@");
          print("TEST2@@@@@@@@@@@@@@@@");
          distributeImage(this, data);
        }
    }
  }

  void errorHandler(error){
    print('$_user Error: $error');
    removeClient(this);
    _socket.close();
  }

  void finishedHandler() {
    print('$_user Disconnected');
    removeClient(this);
    _socket.close();
  }

  void writeUser(String user){
    _socket.write(user);
  }

  void writeMessage(String message){
    _socket.write(message);
  }

  void writeImage(List<int> image){
    _socket.add(image);
  }
}
