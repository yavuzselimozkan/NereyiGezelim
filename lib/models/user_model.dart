class Place
{
  int? id;
  String? name;
  String? description;
  String? url;
  String? county;
  String? placeType;

  Place({this.id,this.name,this.description,this.url,this.county,this.placeType});

  Place.fromJson(Map<String, dynamic> json)
  {
    id=json["id"];
    name=json["name"];
    description=json["description"];
    url=json["url"];
    county=json["county"];
    placeType=json["placeType"];
  }
}

//showCard
/*GestureDetector(
         onTap: () => routeDetailPage(name,description),
         child: Container(
           margin: const EdgeInsets.all(8),
           width: 185,height: 150,
           decoration: BoxDecoration(
               boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3),
               spreadRadius: 2,blurRadius: 3)],color: Colors.white,
               borderRadius: BorderRadius.circular(8)),
           child: Column(
             children: [
               ClipRRect(
                   borderRadius: BorderRadius.circular(8),
                   child: Image.network(url!,height: 120,width: 120,fit: BoxFit.fill,)),
               ListTile(
                title: Text(name!,textAlign: TextAlign.center,),
               ),
             ],
           ),
         ),
       );*/
