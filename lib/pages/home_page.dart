import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nereyi_gezelim_pp/pages/detail_page.dart';
import 'package:nereyi_gezelim_pp/place_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlaceService placeService = PlaceService();
  List<String> places= ["Yeşil Alan","Müze","Alışveriş Merkezi","Restoran"];
  String selectedIndex="Yeşil Alan";


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    
    return SafeArea(
      child: Scaffold(
        body:Center(
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.55,top: screenHeight * 0.04),
                    child: const Text("NEREYİ GEZELİM",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,fontSize: 20),),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(" Bu uygulama gezmek istediğiniz zaman nereye gitsek de "
                        "otursak gezsek derdini ortadan kaldırmak ve karar verme aşamanızı "
                        "kolaylaştırmak için geliştirilmiştir. "
                        "Ana sayfada görmüş olduğunuz önerilenler kısmından "
                        "Alışveriş Merkezi, Yeşil Alan, Müze ve Restoran "
                        "kategorilerinde filtreleme yaparak mekanları görebilirsiniz. "
                        "Rotasyon sayfasından da daha detaylıca arama yapabilirsiniz. İyi eğlenceler.",
                      style: TextStyle(color: Colors.black54,fontSize: 15)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:screenHeight * 0.01,bottom: screenHeight * 0.02),
                child: showTopMenu(),
              ),

              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.65),
                child: const Text(
                    "Önerilenler",
                    style: TextStyle(fontSize:23,fontWeight: FontWeight.bold,letterSpacing: 0.5)
                ),
              ),
              showStackList(selectedIndex)
            ],
          )
        ),
      )
    );
  }

  Widget showStackList(var selectedPlace)
  {
    return SizedBox(
      height: 255,
      child: FutureBuilder(
          future: placeService.fetchAllPlaces(),
          builder: (context, snapshot) {
            if(snapshot.hasData)
              {
                snapshot.data!.shuffle(Random());
                return ListView.builder(
                  itemCount:snapshot.data!.length - 45,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var place = snapshot.data![index];

                    if(place.placeType==selectedPlace)
                    {
                      return Stack(children: [
                        GestureDetector(
                          onTap: () =>
                              rotateDetailPage(place.name, place.description, place.url),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            clipBehavior: Clip.hardEdge,
                            width: 190,
                            height: 255,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3)
                            ], borderRadius: BorderRadius.circular(15)),
                            child: Image.network(place.url!, fit: BoxFit.fill)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 215),
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black38),
                            child: Text(place.name!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15,overflow: TextOverflow.ellipsis)),
                          )
                        ),
                      ]);
                    }
                    return const SizedBox.shrink();
                  }
                );
              }
            else if(snapshot.hasError)
              {
                return const Text("Snapshot Error!");
              }
            return const CircularProgressIndicator();
          },
        ),
    );
  }

  Widget showTopMenu()
  {
    return SizedBox(
      height:55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:() {
              setState(() { selectedIndex = places[index]; });
            },
            child: Container(
              width:130,
              alignment: Alignment.center,
              margin:const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: selectedIndex==places[index] ? Colors.grey[100] : null,
                borderRadius: BorderRadius.circular(30),
                border: selectedIndex==places[index] ? Border.all(color: Colors.grey[300]!): null,
              ),
              child:Text(places[index],
                style: TextStyle(
                  fontSize: 15,
                  color: selectedIndex == places[index] ?
                  CupertinoColors.activeBlue :
                  Colors.black54 ),
              )
            ),
          );
        },
      ),
    );
  }

  void rotateDetailPage(String? title,String? description,String? url)
  {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => DetailPage(title: title, description: description, url: url)
    ));
  }
}
