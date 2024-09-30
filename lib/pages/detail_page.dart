import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nereyi_gezelim_pp/map_utility.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key,required this.title,required this.description, required this.url});
  final String? title;
  final String? description;
  final String? url;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MapUtility mapUtility = MapUtility();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("${widget.title} Page")),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(15)),
                width:screenWidth * 0.85,
                height: screenHeight * 0.45,
                clipBehavior: Clip.hardEdge,
                child: Image.network("${widget.url}",fit:BoxFit.fill),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: screenWidth * 0.85,
                height: screenHeight * 0.25,
                decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(12)),
                child: Text(widget.description!,textAlign: TextAlign.left)
              ),

              Padding(
                padding: EdgeInsets.only(top:screenHeight * 0.02),
                child: ElevatedButton(
                  onPressed: () => mapUtility.openMap("${widget.title}"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.9, screenHeight * 0.08),
                    padding: const EdgeInsets.all(8),
                    backgroundColor: CupertinoColors.activeBlue,
                    shadowColor: Colors.blueAccent.withOpacity(0.8),
                    elevation: 8
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Haritada Göster",style: TextStyle(color: Colors.white, fontSize:20, letterSpacing: 0.5)),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 30)
                    ],
                  ),
                ),
              )
          ],
          ),
        )
      ),
    );
  }
}
