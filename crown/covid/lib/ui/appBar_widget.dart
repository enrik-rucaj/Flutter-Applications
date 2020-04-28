import 'dart:ui';
import '../blocs/covid_bloc.dart';
import 'package:flutter/material.dart';
import '../models/item_model_country.dart';

class AppBarWidget {
  BuildContext context;
  CovidBloc bloc;
  
  //costruttore
  AppBarWidget(this.context, this.bloc);

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey[850],
      title: Text('Covid-19 Info'),
      actions: <Widget>[
        StreamBuilder(
          stream: bloc.allCountries,
          builder: (context, AsyncSnapshot<ItemModelCountry> snapshot) {
            if (snapshot.hasData) {
              List<String> countries = getListCountries(snapshot);
              
              return IconButton(
                icon: Icon(Icons.search), 
                onPressed: (){
                  showSearch(context: context, delegate: _DataSearch(countries, snapshot.data));
                },
              );
            } else if (snapshot.hasError) 
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.do_not_disturb_off, color: Colors.red[900],),
              );
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.do_not_disturb_off, color: Colors.black,),
            );
          }
        ),
      ],
    );
  }

  List<String> getListCountries(AsyncSnapshot<ItemModelCountry> snapshot) {
    List<String> countries = [];
    for (int i=0; i<snapshot.data.countries.length; i++)
      countries.add(snapshot.data.countries[i].country);
    return countries;
  }
}

class _DataSearch extends SearchDelegate<String> {
  List<String> countries;
  ItemModelCountry itemModel;

  //costruttore
  _DataSearch(this.countries, this.itemModel);

  Country getCountry(String s){
    for (int i=0; i<itemModel.countries.length; i++){
      if (s == itemModel.countries[i].country)
        return itemModel.countries[i];
    }
  }
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          showSuggestions(context);
          query = '';
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ), 
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Country info = getCountry(query);
    
    return Container(
      color: Colors.grey[850],
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.network(info.countryInfo.flag, width: 70, height: 50,),
            title: Text(info.country,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white, fontSize: 40
              ),
            ),
          ),
          SizedBox(height: 30,),
          Divider(color: Colors.white, indent: 10, endIndent: 10,),
          SizedBox(height: 30,),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 15),
            leading: Icon(Icons.bug_report, color: Colors.red[900],),
            title: Text("Cases: ${info.cases}",
              style: TextStyle(color: Colors.red[900], fontSize: 30),
            ),
            subtitle: Text("TodayCases: ${info.todayCases}",
              style: TextStyle(color: Colors.red[900], fontSize: 25),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 15),
            leading: Icon(Icons.whatshot, color: Colors.red[900],),
            title: Text("Deaths: ${info.deaths}",
              style: TextStyle(color: Colors.red[900], fontSize: 30),
            ),
            subtitle: Text("TodayDeaths: ${info.todayDeaths}",
              style: TextStyle(color: Colors.red[900], fontSize: 25),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 15),
            leading: Icon(Icons.airline_seat_flat, color: Colors.yellow[800],),
            title: Text("Active: ${info.active}",
              style: TextStyle(color: Colors.yellow[800], fontSize: 30),
            ),
            subtitle: Text("Critical: ${info.critical}",
              style: TextStyle(color: Colors.red[900], fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.verified_user, color: Colors.green[900],),
            title: Text("Recovered: ${info.recovered}",
              style: TextStyle(color: Colors.green[900], fontSize: 30),
            ),
          ),
          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("${info.country}(${info.countryInfo.iso2}) is a nation in the continent of ${info.continent}.",
              style: TextStyle(color: Colors.brown[500], fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: RichText(
              text:  TextSpan(
                text: "Until today the number of test that this nation has done corresponds to ",
                style: TextStyle(color: Colors.brown[500], fontSize: 22),
                children: [
                  TextSpan(
                    text: "${info.tests}",
                    style: TextStyle(color: Colors.blue[700], fontSize: 22),
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty? countries : countries.where((c)=>c.toLowerCase().startsWith(query.toLowerCase())).toList();

    return Container(
      color: Colors.grey[850],
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (content, index) => ListTile(
          leading: Icon(Icons.location_city, color: Colors.white70,),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold
              ),
              children: [TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.white70)
              )]
            )
          ),
          onTap: (){
            query = suggestionList[index];
            showResults(context);
          },
        ),
      ),
    );
  }

}