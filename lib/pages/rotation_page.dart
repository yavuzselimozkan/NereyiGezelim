import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nereyi_gezelim_pp/pages/detail_page.dart';

import '../place_service.dart';

class RotationPage extends StatefulWidget {
  const RotationPage({super.key});
  @override
  State<RotationPage> createState() => _RotationPageState();
}

class _RotationPageState extends State<RotationPage> {
  PlaceService placeService = PlaceService();
  String? selected;
  
  List<String> counties=["FARK ETMEZ","Beşiktaş","Sarıyer","Kadıköy","Üsküdar",
    "Başakşehir","Şişli","Bakırköy","Bayrampaşa","Esenyurt","Zeytinburnu","Küçükçekmece",
    "Gaziosmanpaşa","Beyoğlu","Fatih","Eyüp","Avcılar","Beylikdüzü","Büyükçekmece","Ataşehir","Beykoz","Maltepe",
    "Tuzla","Kartal","Çekmeköy","Ümraniye","Şile","Pendik","Sultanbeyli","Sancaktepe"];

  String? selectedType;
  List<String> types = ["FARK ETMEZ","Alışveriş Merkezi","Yeşil Alan","Restoran","Müze"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected=null;
    selectedType=null;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body:Container(
          height: screenHeight,
          child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:screenHeight * 0.08, left: screenWidth * 0.03),
                    child: const Align(
                        alignment: Alignment.topLeft ,
                        child: Text("İLÇE")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenWidth * 0.02,
                      left: screenWidth * 0.02,
                      bottom: screenHeight * 0.05,),
                    child: showCountyDropMenu(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.03),
                    child: const Align(
                        alignment: Alignment.topLeft ,
                        child: Text("MEKAN TÜRÜ")
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenWidth * 0.02,
                      left: screenWidth * 0.02,
                      bottom: screenHeight * 0.08,),
                    child: showTypeDropMenu(),
                  ),
                  showListTile(selected,selectedType),
                ],
              )
          ),
        )
      ),
    );
  }


  Widget showListTile(var selectedValue,var selectType)
  {
    return SizedBox(
      height: 255,
      child: FutureBuilder(
          future: placeService.fetchAllPlaces(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data!.shuffle(Random());
              return ListView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var data= snapshot.data![index];

                  if(data.county==selectedValue)
                  {
                    return showCard(data.name,data.description,data.placeType,selectType,data.url);
                  }
                  else if(selectedValue=="FARK ETMEZ")
                  {
                    return showCard(data.name,data.description,data.placeType,selectType,data.url);
                  }
                  else if(selectedValue==null)
                  {
                    return null;
                  }
                  return const SizedBox.shrink();
                },
              );
            }
            else if (snapshot.hasError) {
              return Text("ERROR: ${snapshot.error}");
            }
            return const CircularProgressIndicator();
          }
      ),
    );
  }


  Widget showCountyDropMenu()
  {
    return Container(
      height: 48,
      decoration: BoxDecoration(color:Colors.grey[200],borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          borderRadius: BorderRadius.circular(15),
          value: selected,
          isExpanded: true,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          hint: const Text("Lütfen bir ilçe seçiniz"),
          style: const TextStyle(color: Colors.deepPurple),
          items: counties.map((String? e){
            return DropdownMenuItem(
              value: e,
              child: Text('$e'),
            );
          }
          ).toList(),
          onChanged: (newValue) {
            setState(() {
              selected=newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget showTypeDropMenu()
  {
    return Container(
      height: 48,
      decoration: BoxDecoration(color:Colors.grey[200],borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          isExpanded: true,
          borderRadius: BorderRadius.circular(15),
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          hint: const Text("Lütfen bir mekan türü seçiniz"),
          style: const TextStyle(color: Colors.deepPurple),
          value: selectedType,
          items: types.map((String? e)
          {
            return DropdownMenuItem(
              value: e,
              child: Text('$e'),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedType=newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget? showCard(String? name, String? description,String? type,String? sType,String? url)
  {
    if(type==sType)
    {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => rotateDetailPage(name,description,url),
            child: Container(
              margin: const EdgeInsets.all(8),
              clipBehavior: Clip.hardEdge,
              width: 190,
              height: 255,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3
                  )
                ],
                borderRadius: BorderRadius.circular(15)
              ),
              child: Image.network(url!, fit: BoxFit.fill,),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 215),
            child: Container(
              width: 120,
              padding: const EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black38
              ),
              child: Text(name!,style: const TextStyle(color: Colors.white,fontSize: 15,overflow: TextOverflow.ellipsis),),
            ),
          )
        ],
      );
    }
    else if(sType=="FARK ETMEZ")
    {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => rotateDetailPage(name,description,url),
            child: Container(
              margin: const EdgeInsets.all(8),
              clipBehavior: Clip.hardEdge,
              width: 190,
              height: 255,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3
                  )
                ],
                borderRadius: BorderRadius.circular(15)
              ),
              child: Image.network(url!, fit: BoxFit.fill,),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 215),
            child: Container(
              width: 120,
              padding: const EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black38
              ),
              child: Text(name!,style: const TextStyle(color: Colors.white,fontSize: 15,overflow: TextOverflow.ellipsis),),
            ),
          )
        ],
      );
    }
    else if(sType==null)
    {
      return null;
    }
    return const SizedBox.shrink();
  }

  void rotateDetailPage(String? title, String? pageDescription, String? url)
  {
    Navigator.push(context,MaterialPageRoute(
      builder: (context) => DetailPage(title: title!,description: pageDescription,url: url,),
    ));
  }
}