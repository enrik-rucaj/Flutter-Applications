import '../blocs/covid_bloc.dart';
import 'package:flutter/material.dart';
import '../models/item_model_all.dart';

class BodyWidget {
  BuildContext context;
  CovidBloc bloc;
  
  //costruttore
  BodyWidget(this.context, this.bloc);

  Widget body() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey[900], Colors.white, Colors.indigo, Colors.indigo[900]],
          stops: [0.05,0.2,0.55,1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('images/covid1.png'),
            width: 400,
            height: 300,
          ),
          StreamBuilder(
            stream: bloc.allInfo,
            builder: (context, AsyncSnapshot<ItemModelAll> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: Container(
                padding: const EdgeInsets.only(top: 120),
                width: 70, height: 180,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModelAll> snapshot) {
    return Column(
      children: <Widget>[
        Text('Affected Countries',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text("${snapshot.data.affectedCountries}",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),        
        SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('cases',
                  style: TextStyle(fontSize: 30, color: Colors.red[900]),
                ),
                Text('deaths',
                  style: TextStyle(fontSize: 30, color: Colors.red[900]),
                ),
                Text('recovered',
                  style: TextStyle(fontSize: 30, color: Colors.green[600]),
                ),
              ],
            ),
            SizedBox(width: 50,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${snapshot.data.cases}',
                  style: TextStyle(fontSize: 30, color: Colors.red[900]),
                ),
                Text('${snapshot.data.deaths}',
                  style: TextStyle(fontSize: 30, color: Colors.red[900]),
                ),
                Text('${snapshot.data.recovered}',
                  style: TextStyle(fontSize: 30, color: Colors.green[600]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}