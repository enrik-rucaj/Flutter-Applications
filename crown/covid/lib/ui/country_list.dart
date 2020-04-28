import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../blocs/covid_bloc.dart';
import 'appBar_widget.dart';
import 'body_widget.dart';
import 'drawer_widget.dart';

class CountriesList extends StatefulWidget {
  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  @override
  void initState() {
    super.initState();
    bloc.fetchGeneralInfo();
    bloc.fetchAllCountries();
  }
  
  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBarWidget widget1 = AppBarWidget(context, bloc);
    BodyWidget widget2 = BodyWidget(context, bloc);
    DrawerWidget widget3 = DrawerWidget(context, bloc);

    return Scaffold(
      appBar: widget1.appBar(),
      drawer: widget3.drawer(),
      body: widget2.body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.backup),
        backgroundColor: Colors.red[800],
        onPressed: _launchURL,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[800],
        shape: CircularNotchedRectangle(),
        child: SizedBox(height: 40),
        //child: Icon(Icons.near_me, color: Colors.white,),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.google.com/search?q=coronavirus&oq=coronavirus&aqs=chrome..69i57j35i39j0j69i60l2.2117j0j4&client=ms-android-xiaomi-rev1&sourceid=chrome-mobile&ie=UTF-8';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}