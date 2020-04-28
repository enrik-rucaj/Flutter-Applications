import '../blocs/covid_bloc.dart';
import 'package:flutter/material.dart';
import '../models/item_model_continent.dart';

class DrawerWidget {
  BuildContext context;
  CovidBloc bloc;
  
  //costruttore
  DrawerWidget(this.context, this.bloc);

  Widget drawer() {
    return Drawer(
      child: Container(
        color: Colors.grey[300],
        child: FutureBuilder(
          future: bloc.fetchAllContinents(),
          builder: (context, AsyncSnapshot<ItmeModelContinent> snapshot) {
            if (snapshot.hasData){ 
              return getList(snapshot);
            } else {
              return Center(child: Text("WAITING..."));
            }
          }
        )
      ),
    );
  }

  Widget getList(AsyncSnapshot<ItmeModelContinent> snapshot) {
    return Column(
      children: <Widget>[
        SafeArea(
          child: Text("Info About Continents",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red[900]),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.continents.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(snapshot.data.continents[index].continent,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
                ),
                children: <Widget>[
                  Column(
                    children: _buildExpandableContent(snapshot, index),
                  ),
                ],
              );
            }
          ),
        ),
      ],
    );
  }
  
  List<Widget> _buildExpandableContent(AsyncSnapshot<ItmeModelContinent> snapshot, index) {
    return [
      ListTile(
        leading: Icon(Icons.bug_report),
        title: Text("Cases: ${snapshot.data.continents[index].cases}",
          style: TextStyle(color: Colors.red[900], fontSize: 18),
        ),
      ),
      ListTile(
        leading: Icon(Icons.whatshot),
        title: Text("Deaths: ${snapshot.data.continents[index].deaths}",
          style: TextStyle(color: Colors.red[900], fontSize: 18),
        ),
      ),
      ListTile(
        leading: Icon(Icons.airline_seat_flat),
        title: Text("Active: ${snapshot.data.continents[index].active}",
          style: TextStyle(color: Colors.yellow[900], fontSize: 18),
        ),
      ),
      ListTile(
        leading: Icon(Icons.verified_user),
        title: Text("Recovered: ${snapshot.data.continents[index].recovered}",
          style: TextStyle(color: Colors.green[900], fontSize: 18),
        ),
      )
    ];
  }

}