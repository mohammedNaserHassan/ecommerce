import 'dart:ui';
import 'package:ecommerce/Provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProgile extends StatefulWidget {
  static final routeName = 'updateprofile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UpdateProgile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          title: Text('Editing Profile'),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .updateProfile();
              },
              icon: Icon(Icons.done),
            )
          ],
        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.captureUpdateProfileImage();
                    },
                    child: provider.updatedFile == null
                        ? CircleAvatar(
                      child: Icon(Icons.add_a_photo_outlined,color: Colors.black,size: 50,),
                            radius: 80,
                      backgroundColor: Colors.grey,
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(provider.updatedFile),
                          ),
                  ),
                  ItemWidget(
                    label: 'Email',
                    valueController: provider.emailController,
                    state: false,
                  ),
                  ItemWidget(
                      label: 'first Name',
                      valueController: provider.fNameController),
                  ItemWidget(
                      label: 'last Name',
                      valueController: provider.lNameController),
                  ItemWidget(
                      label: 'country Name',
                      valueController: provider.countryController),
                  ItemWidget(
                      label: 'city Name',
                      valueController: provider.cityController),
                ],
              ),
            );
          },
        ));
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  bool state;
  TextEditingController valueController;

  ItemWidget({this.label, this.valueController, this.state = true});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              enabled: state,
              controller: valueController,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                border: InputBorder.none
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(15)),
    );
  }
}
