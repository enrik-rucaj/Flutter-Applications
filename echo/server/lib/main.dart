// use netcat 127.0.0.1 3000 (clienT)

import 'dart:io';

int nClient = 0;

void main() {
  ServerSocket.bind(InternetAddress.anyIPv4, 3000).then(
    (server) {
      server.listen((client) {
        handleConnection(client);
      });
    }
  );
}

void handleConnection(Socket client){
  int n = ++nClient;    
   print('server: ${client.address}:${client.port}');
  print('client ' + nClient.toString() + ' connected from ' + 
    '${client.remoteAddress.address}:${client.remotePort}');
  // manage data and retrun data
  client.listen((data) {
    String str = String.fromCharCodes(data).trim().toUpperCase();
      print('[$n]: ' + str);
      client.write(str + '\n');   
      // client.close(); NOOOOOOO   
    },
    onDone: () {client.close();}
  );
}
