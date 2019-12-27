import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

int _itemCount = 0;
int _foodCount = 0;


class URLS {
  static const String BASE_URL = 'http://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';
}
class ApiService {
  static Future<List<dynamic>> getCafe() async {
    final response = await http.get('${URLS.BASE_URL}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>  with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        onWillPop: _onWillPop,

        child: Scaffold(
          appBar: AppBar(leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () {},
          ),
            centerTitle: false,
            backgroundColor: Colors.white,
            title: FittedBox(fit:BoxFit.fitWidth,
              child: Text('UNI Resto Cafe',style: TextStyle(color: Colors.black54),),),
            actions: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('My Orders',style: TextStyle(color: Colors.black54),),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 10,right: 13,left: 0),
                  child: Stack(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.only(bottom: 10),
                        icon: Icon(Icons.shopping_cart),
                        //icon: Icons.notifications,
                        color: Colors.black54,
                        iconSize: 30,
                        onPressed: (){},
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 0, left: 10),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffc32c37),
                              border: Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Center(
                              child: Text('$_itemCount'
                                  ''
                                ,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],

            bottom: new TabBar(
              isScrollable: true,
              tabs: <Tab>[
                new Tab(
                  child: Text("Salads and Soup",style: TextStyle(color: Colors.black),),
                ),
                new Tab(
                  child: Text("From The Barnyard",style: TextStyle(color: Colors.black),),
                ),
                new Tab(
                  child: Text("From the Hen House",style: TextStyle(color: Colors.black),),
                ),
                new Tab(
                  child: Text("Biryani",style: TextStyle(color: Colors.black),),
                ),
                new Tab(
                  child: Text("Fast Food",style: TextStyle(color: Colors.black),),
                )

              ],
              controller: _tabController,
              indicatorColor: Colors.red,
            ),

          ),
          body: dataFetch()
        )
    );
  }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  dataFetch(){
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
   return FutureBuilder(
     future: ApiService.getCafe(),
     builder: (context, snapshot) {
       final cafes = snapshot.data;
       debugPrint('$cafes');
       if (snapshot.connectionState == ConnectionState.done) {
         return ListView.builder(
           itemCount: cafes.length,
           itemBuilder: (context, index) {
             return Card(
               child: Column(
                 children: <Widget>[
                   Container(
                     child:
                     Column(
                       children: <Widget>[
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisSize: MainAxisSize.max,
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                                 Container(
                                   width: width/1.4,
                                   child: Text('${cafes[index]['table_menu_list'][cafes.length]['category_dishes'][index]['dish_name']}',style: TextStyle(fontWeight: FontWeight.bold),),

                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: <Widget>[
                                     Padding(
                                       padding: const EdgeInsets.only(top: 8,right: 5),
                                       child: Container(child: Text('${cafes[index]['table_menu_list'][index]['category_dishes'][index]['dish_currency']}',style: TextStyle(fontWeight: FontWeight.bold)),),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.only(top: 8),
                                       child: Container(child: Text('${cafes[index]['table_menu_list'][index]['category_dishes'][index]['dish_price']}',style: TextStyle(fontWeight: FontWeight.bold)),),
                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(top: 8,left: width/3),
                                       child: Container(child: Text('${cafes[index]['table_menu_list'][index]['category_dishes'][index]['dish_calories']}'+' Calories',style: TextStyle(fontWeight: FontWeight.w400,fontSize: width/32)),),
                                     ),
                                   ],
                                 ),

                                 Padding(
                                   padding: const EdgeInsets.only(top: 10,bottom: 10),
                                   child: Container(
                                       width: width/1.4,
                                       child: Text('${cafes[index]['table_menu_list'][index]['category_dishes'][index]['dish_description']}',style: TextStyle(color: Colors.black38), textAlign: TextAlign.left),
                                   ),
                                 )

                               ],
                             ),
                             Container(
                               child: Image.network(
                                 '${cafes[index]['table_menu_list'][index]['category_dishes'][index]['dish_image']}',
                                 scale: 11,
                               ),
                             )
                           ],
                         ),

                         Row(
                           children: <Widget>[
                             Container(
                                 width: width/10,
                                 height: width/10,
                                 decoration: new BoxDecoration(
                                     color: Colors.green,
                                     borderRadius: new BorderRadius.only(
                                       topLeft: const Radius.circular(40.0),

                                       bottomLeft: const Radius.circular(40.0),


                                     )),
                                 child: IconButton(icon: Icon(Icons.remove, color: Colors.white,),onPressed: ()=>setState((){_foodCount>0 ? _foodCount--: _foodCount = 0; _itemCount -= _foodCount;}))
                             ),
                             Container(
                               width: width/5,
                               height: width/10,
                               decoration: new BoxDecoration(
                                 color: Colors.green,
                               ),
                               child: Center(
                                 child: Text(_foodCount.toString(),style: TextStyle(color: Colors.white, fontSize: width/25),),

                               ),
                             ),
                             Container(
                               width: width/10,
                               height: width/10,
                               decoration: new BoxDecoration(
                                   color: Colors.green,
                                   borderRadius: new BorderRadius.only(

                                     topRight: const Radius.circular(40.0),

                                     bottomRight: const Radius.circular(40.0),

                                   )),
                               child:  IconButton(icon: Icon(Icons.add, color: Colors.white,),onPressed: ()=>setState((){_foodCount++; _itemCount += _foodCount;})),
                             ),
                           ],
                         ),
                         Padding(
                           padding: EdgeInsets.only(top: height/70),
                           child: Container(
                               alignment: Alignment(-1.0, -1.0),
                               child: Text('Customization Available',style: TextStyle(color: Colors.red),)
                           ),
                         ),

                       ],
                     ),
                     padding: const EdgeInsets.all(20),
                   )
                 ],
               ),
             );
//               Column(
//               children: <Widget>[
//                   Text('${cafes[index]['table_menu_list'][index]['category_dishes'][index]['dish_name']}'),
//                  // Text('Age: ${employees[index]['restaurant_id']}'),
//               ],
//             );
           },

         );
       }

       return Center(
         child: CircularProgressIndicator(),
       );
     },
   );
  }

}



//ListView.builder(
//itemCount: 2,
////data == null ? 0 : data.length,
//itemBuilder: (BuildContext context, int index){
//return Card(
//child: Column(
//children: <Widget>[
//Container(
//child:
////Text(data[index]['restaurant_name'],style: TextStyle(fontSize: 20),),
//Column(
//children: <Widget>[
//Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//mainAxisSize: MainAxisSize.max,
//mainAxisAlignment: MainAxisAlignment.start,
//children: <Widget>[
//Container(
//width: width/1.4,
//child: Text("ikuygyhg"),
//
//),
//Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//Container(child: Text("SAR 7.25")),
//Padding(
//padding: EdgeInsets.only(top: 8,left: width/2.6),
//child: Container(child: Text('15 calories')),
//),
//],
//),
//
//Padding(
//padding: const EdgeInsets.only(top: 10,bottom: 10),
//child: Container(
//width: width/1.4,
//child: Text("jhjhfkjhf jhjhjh ljyhgjglkjhg gjhgjhg kjh jksdhfkgjh dkf  dkjfhgkjh dfjghkdjfhg dfjhgkjdfhg",style: TextStyle(color: Colors.black38), textAlign: TextAlign.left)),
//)
//
//],
//),
//Container(
//child: Image.network(
//'http://restaurants.unicomerp.net//images/Restaurant/1010000001/Item/Items/100000001.jpg',
//scale: 11,
//),
//)
//],
//),
//
//Row(
//children: <Widget>[
//Container(
//width: width/10,
//height: width/10,
//decoration: new BoxDecoration(
//color: Colors.green,
//borderRadius: new BorderRadius.only(
//topLeft: const Radius.circular(40.0),
//
//bottomLeft: const Radius.circular(40.0),
//
//
//)),
//child: IconButton(icon: Icon(Icons.remove, color: Colors.white,),onPressed: ()=>setState((){_foodCount>0 ? _foodCount--: _foodCount = 0; _itemCount -= _foodCount;}))
//),
//Container(
//width: width/5,
//height: width/10,
//decoration: new BoxDecoration(
//color: Colors.green,
//),
//child: Center(
//child: Text(_foodCount.toString(),style: TextStyle(color: Colors.white, fontSize: width/25),),
//
//),
//),
//Container(
//width: width/10,
//height: width/10,
//decoration: new BoxDecoration(
//color: Colors.green,
//borderRadius: new BorderRadius.only(
//
//topRight: const Radius.circular(40.0),
//
//bottomRight: const Radius.circular(40.0),
//
//)),
//child:  IconButton(icon: Icon(Icons.add, color: Colors.white,),onPressed: ()=>setState((){_foodCount++; _itemCount = _foodCount;})),
//),
//],
//),
//Padding(
//padding: EdgeInsets.only(top: height/70),
//child: Container(
//alignment: Alignment(-1.0, -1.0),
//child: Text('Customization Available',style: TextStyle(color: Colors.red),)
//),
//),
//
//],
//),
//padding: const EdgeInsets.all(20),
//)
//],
//),
//);
//});




