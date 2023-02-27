import 'dart:io';

import 'package:call_book/model.dart';
import 'package:call_book/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<Modeldata> contactList = [];
String? path;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {},
          ),
          actions: [],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MY CONTACT", style: TextStyle(letterSpacing: 2)),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Type name or number",
                                style:
                                    TextStyle(letterSpacing: 2, fontSize: 10)),
                            Icon(Icons.search, size: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return contactBox(
                      contactList[index].name!,
                      contactList[index].number!,
                      contactList[index].path!,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: contactList.length,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () async{
                                    ImagePicker imagepicker = ImagePicker();
                                    XFile? xfile = await imagepicker.pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      path = xfile!.path;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(File("$path")),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: txtName,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: txtNumber,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Number",
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      Modeldata m1 = Modeldata(
                                          name: txtName.text,
                                          number: txtNumber.text,
                                        path: path,
                                      );
                                      contactList.add(m1);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactBox(String name, String number,String img) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      //margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey),
            top: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            backgroundImage: FileImage(File("$img")),
          ),
          SizedBox(
            width: 10,
          ),
          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$name",
                    style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                Text(" $number",
                    style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 1,
                    )),
              ],
            ),
          ),

          Spacer(),

          InkWell(
              onTap: () async {
                await launchUrl(Uri.parse("tel:$number"));
              },
              child: Icon(Icons.call)),
          SizedBox(
            width: 20,
          ),

          InkWell(
              onTap: () async {
                await launchUrl(Uri.parse("sms:$number"));
              },
              child: Icon(Icons.message)),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
