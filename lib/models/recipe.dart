import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:recepie/model.dart';

class WebPage extends StatelessWidget {
  // final url;
  // WebPage({this.url});

  final Model reci;
  // List myi;
  WebPage({required this.reci});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.black,
      leading: const Icon(Icons.arrow_back_ios,color: Colors.white,),
      title: Text("Ingredient & Method",style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),),

      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(reci.image,fit: BoxFit.cover),
          Text(reci.label,style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red),),

          const SizedBox(height: 8),


          Expanded(
            child: ListView.builder(
              itemCount: reci.ingredientLines.length,
              itemBuilder: (context, index) {
                final ingredientLine = reci.ingredientLines[index];
                return Text(
                  ingredientLine,
                  style: TextStyle(fontSize: 16,color: Colors.white),
                );
              },
            ),
          ),



      ])));
  }
}
