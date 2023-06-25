import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recepie/models/recipe.dart';
import 'package:recepie/model.dart';



void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var searchRecipe="Vegetable";
  List hits = [];
  @override
  void initState(){
    super.initState();
    getApiData(searchRecipe);
  }

  // dynamic url = 'https://api.edamam.com/search?q=$searchRecipe&app_id=166f88cc&app_key=14530b3d9f8903c7b5b91274db72c713&from=0&to=100&calories=591-722&health=alcohol-free';
  Future<void> getApiData(String searchRecipe) async{
    final response = await http.get(Uri.parse(
        'https://api.edamam.com/search?q=$searchRecipe&app_id=166f88cc&app_key=14530b3d9f8903c7b5b91274db72c713&from=0&to=100&calories=591-722&health=alcohol-free'));

    if (response.statusCode==200) {
      final jsonData = json.decode(response.body);
      for(final hit in jsonData['hits']) {
        final recipe4 = hit['recipe'];

        setState(() {
          hits = (jsonData['hits'] as List).map((data) =>
              Model.fromjson(data)).toList();

        });
      }
    } else{
      throw Exception('Failed to load');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Color.fromARGB(240, 161, 161, 68),elevation: 0,title: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.restaurant_menu),
        SizedBox(width: 10),
        Text('Food Recipe')
      ],),),
      body:
        Container(decoration: BoxDecoration(color: Colors.black), margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
              searchRecipe = value;},

            decoration: InputDecoration(hintText: "Search Recipe for today's menu",suffix: IconButton(icon: Icon(Icons.search,color: Colors.white,),
            onPressed: (){
              getApiData( searchRecipe);            },),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),),
                    fillColor: Color.fromARGB(240, 26, 58, 7).withOpacity(0.84),filled: true)),

          SizedBox(height: 15,),


              Expanded(child:GridView.builder(physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                  ),itemCount: hits.length, itemBuilder: (context,index){
                    final rec = hits[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>
                            WebPage(reci:rec)));
                  },child:

                      Container(decoration: BoxDecoration(color: Colors.black,image:DecorationImage(
                          fit: BoxFit.cover,image: NetworkImage((rec.image)) ),),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(height: 40,color: Colors.black.withOpacity(0.5),
                                      child: Center(child: Text(rec.label)),
                                    ),
                                  )
                                ],),






                          ),
                      ) );
                }),
              ),

    ])));
  }
}


