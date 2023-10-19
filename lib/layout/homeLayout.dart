import 'package:flutter/material.dart';
import 'package:news/shard/network/remot/api_manager.dart';
import 'package:news/shard/style/colors.dart';

class HomeLayout extends StatelessWidget {
  static const String routName = "Home";

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.red,
        child: const Column(
          children: [],
        ),
      ),
      appBar: AppBar(
        title: const Text("News App", style: TextStyle(fontSize: 22)),
        centerTitle: true,
        backgroundColor: green,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(18))),
      ),
      body: FutureBuilder(builder:(context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting)
          {
            return const CircularProgressIndicator();
          }
        if(snapshot.hasError)
          {
            return const Text("Error");
          }
        var sources=snapshot.data?.sources??[];
        return ListView.builder(itemBuilder: (context, index) {
          return Text(sources[index].name??"");
        },itemCount: sources.length,);
      }, future: ApiManager.getSources()),
    );
  }
}
