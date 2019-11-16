import 'dart:io';
import 'dart:math';

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
  print('client ' + nClient.toString() + ' connected from ' + 
        '${client.remoteAddress.address}:${client.remotePort}');
  client.listen((data) {
    String str = String.fromCharCodes(data).trim().toLowerCase();
    String opr;
    if (str.startsWith('=')) {
      if (str.length == 4){
        opr = str.substring(2,3);
        switch (opr) {
          case "+":
            print('[$n]: ' + str);
            int x=int.parse(str.substring(1,2));
            int y=int.parse(str.substring(3));
            client.write('${x+y} \n');
            break;
          case "-":
            print('[$n]: ' + str);
            int x=int.parse(str.substring(1,2));
            int y=int.parse(str.substring(3));
            client.write('${x-y} \n');
            break;
          case "*":
            print('[$n]: ' + str);
            int x=int.parse(str.substring(1,2));
            int y=int.parse(str.substring(3));
            client.write('${x*y} \n');
            break;
          case "/":
            print('[$n]: ' + str);
            int x=int.parse(str.substring(1,2));
            int y=int.parse(str.substring(3));
            client.write('${x/y} \n');
            break;
          default:
        }
      }
    }
    else{
      switch (str) {
        case "come mi chiamo?": 
          print('[$n]: ' + str);
          client.write('ti chiami Enrik.\n');
          break;
        case "cucina!":
          print('[$n]: ' + str);
          client.write('mi spiace, non ci riesco.\n');
          break;
        case "cosa sei?":
          print('[$n]: ' + str);
          client.write('io sono un server Echo.\n');
          break;
        default:
          print('[$n]: ' + str);
          client.write(str + '\n');
          break;
      }
    }
    },
    onDone: () {client.close();}
  );
}
