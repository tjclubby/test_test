import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

int _itemCount = 0;

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>  with SingleTickerProviderStateMixin{
  final String url  = 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';
  List data;
  TabController _tabController;

  @override
  void initState(){
    super.initState();
    this.getData();
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<String> getData()async{
    var res = await http.get(Uri.encodeFull(url),headers:{"Accept":"application/json"});
    print(res.body);
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody['results'];
    });
    return "Sucess";
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
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
          body: ListView.builder(
                  itemCount: 2,
                  //data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index){
                    return CafeListView();
                  }),
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
}

class CafeListView extends StatefulWidget {
  @override
  _CafeListViewState createState() => _CafeListViewState();
}

class _CafeListViewState extends State<CafeListView> {
  int _foodCount = 0;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            child:
            //Text(data[index]['restaurant_name'],style: TextStyle(fontSize: 20),),
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
                          child: Text("Spinatch Salad"),

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(child: Text("SAR 7.25")),
                            Padding(
                              padding: EdgeInsets.only(top: 8,left: width/2.6),
                              child: Container(child: Text('15 calories')),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Container(
                            width: width/1.4,
                              child: Text("jhjhfkjhf jhjhjh ljyhgjglkjhg gjhgjhg kjh jksdhfkgjh dkf  dkjfhgkjh dfjghkdjfhg dfjhgkjdfhg",style: TextStyle(color: Colors.black38), textAlign: TextAlign.left)),
                        )

                      ],
                    ),
                    Container(
                      child: Image.network(
                        'http://restaurants.unicomerp.net//images/Restaurant/1010000001/Item/Items/100000001.jpg',
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
                      child:  IconButton(icon: Icon(Icons.add, color: Colors.white,),onPressed: ()=>setState((){_foodCount++; _itemCount = _foodCount;})),
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
  }
}




