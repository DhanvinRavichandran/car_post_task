import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Car post method",
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyPostCheck(),
    );
  }
}

class MyPostCheck extends StatefulWidget {
  const MyPostCheck({Key? key}) : super(key: key);

  @override
  State<MyPostCheck> createState() => _MyPostCheckState();
}

class _MyPostCheckState extends State<MyPostCheck> {
  List years = ['2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2023'];

  TextEditingController yearController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController variantController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List? makeList;
  List? modelList;
  List? variantList;
  List? locationtList;

  @override
  void initState() {
    super.initState();
    fetch();
    modelFetch();
    variantFetch();
    locationFetch();
  }

  Future<String> fetch() async {
    final data = {'year': '2020'};
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
        Uri.parse('https://kuwycredit.in/servlet/rest/ltv/forecast/ltvMakes'),
        headers: headers,
        body: jsonEncode(data));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      makeList = responseData["makeList"];
      print("Data : " + makeList.toString());
    } else {
      throw Exception('Failed.');
    }
    return "";
  }

  Future<String> modelFetch() async {
    final data = {'year': '2020', 'make': makeController.text};
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
        Uri.parse('https://kuwycredit.in/servlet/rest/ltv/forecast/ltvModels'),
        headers: headers,
        body: jsonEncode(data));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      modelList = responseData["modelList"];
      print("Data : " + modelList.toString());
    } else {
      throw Exception('Failed.');
    }
    return "";
  }

  Future<String> variantFetch() async {
    final data = {
      'year': '2020',
      'make': makeController.text,
      'model': modelController.text
    };
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
        Uri.parse(
            'https://kuwycredit.in/servlet/rest/ltv/forecast/ltvVariants'),
        headers: headers,
        body: jsonEncode(data));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      variantList = responseData["variantList"];
      print("Data : " + variantList.toString());
    } else {
      throw Exception('Failed.');
    }
    return "";
  }

  Future<String> locationFetch() async {
    final data = {
      'year': '2020',
      'make': makeController.text,
      'model': modelController.text,
      'variant': variantController.text
    };
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
        Uri.parse('https://kuwycredit.in/servlet/rest/ltv/forecast/ltvLoc'),
        headers: headers,
        body: jsonEncode(data));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      locationtList = responseData["locationList"];
      print("Data : " + locationtList.toString());
    } else {
      throw Exception('Failed.');
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text("True Value",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic
          ,fontWeight: FontWeight.w700),),backgroundColor: Colors.brown,
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: yearController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Select Year",
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25.0,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: years.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        years[index],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          print(years[index]);
                                          yearController.text =
                                              years[index].toString();
                                          makeController.clear();
                                          modelController.clear();
                                          variantController.clear();
                                          locationController.clear();
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),

                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.car_crash_outlined,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: makeController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Select Make",
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder(
                              future: fetch(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.data != null) {
                                  return ListView.builder(
                                    itemCount: makeList!.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title:
                                            Text(makeList![i].toString()),
                                            onTap: () {
                                              setState(() {
                                                print(makeList![i]);
                                                makeController.text =
                                                    makeList![i].toString();
                                                modelController.clear();
                                                variantController.clear();
                                                locationController.clear();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),

                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                      child: Center(
                                        child: Text('Failed'),
                                      ));
                                }
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.car_rental_sharp,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: modelController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Select Model",
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder(
                              future: modelFetch(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.data != null) {
                                  return ListView.builder(
                                    itemCount: modelList!.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title:
                                            Text(modelList![i].toString()),
                                            onTap: () {
                                              setState(() {
                                                print(modelList![i]);
                                                modelController.text =
                                                    modelList![i].toString();
                                                variantController.clear();
                                                locationController.clear();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),

                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    child: Center(
                                      child: Text('Failed'),
                                    ),
                                  );
                                }
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.car_repair_outlined,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: variantController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Select Variant",
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder(
                              future: variantFetch(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.data != null) {
                                  return ListView.builder(
                                    itemCount: variantList!.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                                variantList![i].toString()),
                                            onTap: () {
                                              setState(() {
                                                print(variantList![i]);
                                                variantController.text =
                                                    variantList![i].toString();

                                                locationController.clear();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),

                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    child: Center(
                                      child: Text('Failed'),
                                    ),
                                  );
                                }
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.gps_fixed_rounded,
                    size: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 280,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: locationController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Select Location",
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder(
                              future: locationFetch(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.data != null) {
                                  return ListView.builder(
                                    itemCount: locationtList!.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                                locationtList![i].toString()),
                                            onTap: () {
                                              setState(() {
                                                print(locationtList![i]);
                                                locationController.text =
                                                    locationtList![i]
                                                        .toString();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: Colors.black,
                                            indent: 10.0,
                                            endIndent: 10.0,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    child: Center(
                                      child: Text('Failed'),
                                    ),
                                  );
                                }
                              });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: ElevatedButton(onPressed: (){
                  yearController.clear();
                  makeController.clear();
                  modelController.clear();
                  variantController.clear();
                  locationController.clear();
                },child: Text("OK"),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
