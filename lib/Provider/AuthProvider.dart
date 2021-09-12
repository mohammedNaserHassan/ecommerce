import 'dart:io';

import 'package:ecommerce/Authintication/Helper/auth_helper.dart';
import 'package:ecommerce/Authintication/Helper/fireStorageHelper.dart';
import 'package:ecommerce/Authintication/Helper/fireStore_Helper.dart';
import 'package:ecommerce/Authintication/Helper/sqHelper.dart';
import 'package:ecommerce/Authintication/UI/login.dart';
import 'package:ecommerce/Models/CountryModel.dart';
import 'package:ecommerce/Models/RegisterRequest.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Services/customDialog.dart';
import 'package:ecommerce/Ui/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountriesFromFirestore();
  }

  /////Sign up//////////////////////////////
  register() async {
    try {
      UserCredential userCredential = await Auth_helper.auth_helper
          .signup(emailController.text, passwordController.text);

      String imageUrl = await fireStorageHelper.helper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
        imgurl: imageUrl,
        id: userCredential.user.uid,
        city: selectedCity ?? '',
        country: selectedCountry.name ?? '',
        Email: emailController.text,
        fName: fNameController.text,
        lName: lNameController.text,
      );
      await fireStore_Helper.helper.addUserToFireBase(registerRequest);
      print('Enter account');
      await Auth_helper.auth_helper.vereifyEmail();
      await Auth_helper.auth_helper.signOut();
      AppRouter.appRouter.gotoPagewithReplacment(Login.routeName);
    } on Exception catch (e) {
      print(e);
    }

    clearController();
    notifyListeners();
  }

////////////////////////////////////////////////
  /////GetCurrent User//////////////////////////////

  RegisterRequest user;

  getUserFromFirestore() async {
    user = await fireStore_Helper.helper.getUserFromFirestore();
    // print(user.toMap());
    notifyListeners();
  }

  ///////////////

  //////Login////////////////////////////////////
  login() async {
    UserCredential userCredential = await Auth_helper.auth_helper
        .signin(emailController.text, passwordController.text);
    String userId = Auth_helper.auth_helper.getUserId();
    await fireStore_Helper.helper.getUserFromFirestore();
    bool isVerified = Auth_helper.auth_helper.checkEmailVerification();
    print(isVerified);
    if (isVerified) {
      AppRouter.appRouter.gotoPagewithReplacment(HomePage.routename);
    } else {
      CustomDialog.customDialog.showCustom(
          'You have to verify your email,press ok to send another email',
          sendVerification);
    }

    clearController();
    notifyListeners();
  }

//////////////////////////////////////////////////////

  //////Verification//////////////////////
  sendVerification() {
    Auth_helper.auth_helper.vereifyEmail();
    Auth_helper.auth_helper.signOut();
  }

//////////////////////////////////////////////////////

  //////////////////Reset Password////////////////////////
  resetPassword() async {
    Auth_helper.auth_helper.resetPassword(emailController.text);
    clearController();
    AppRouter.appRouter.gotoPagewithReplacment(Login.routeName);
  }

/////////////

  //////Controller//////
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  clearController() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
    countryController.clear();
    cityController.clear();
  }
////////////////////////////////////////////////////////////////////////
//////Check User Found///////
  String myId;

  checkLogin() {
    bool isLoggin = Auth_helper.auth_helper.checkUser();
    if (isLoggin) {
      this.myId = Auth_helper.auth_helper.getUserId();
      AppRouter.appRouter.gotoPagewithReplacment(HomePage.routename);
    } else {
      AppRouter.appRouter.gotoPagewithReplacment(Login.routeName);
    }
  }

  ///////////////////////
  fillControllers() {
    emailController.text = user.Email;
    fNameController.text = user.fName;
    lNameController.text = user.lName;
    countryController.text = user.country;
    cityController.text = user.city;
  }
  File updatedFile;

  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    notifyListeners();
  }
  updateProfile() async {
    String imageUrl;
    if (updatedFile != null) {
      imageUrl = await fireStorageHelper.helper.uploadImage(updatedFile);
    }
    RegisterRequest userModel = RegisterRequest(
        Email: emailController.text,
        city: cityController.text,
        country: countryController.text,
        fName: fNameController.text,
        lName: lNameController.text,
        id: user.id,
        imgurl: imageUrl??user.imgurl);

    await fireStore_Helper.helper.updateProfile(userModel);
    getUserFromFirestore();
    AppRouter.appRouter.back();
  }
//upload Image

  File file;

  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }

  ///////////

  //////Country and City  Firebase////////////
  List<CountryModel> countries = [];
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectedCity;

  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.selectedCity = city;
    notifyListeners();
  }

  getCountriesFromFirestore() async {
    try {
      // myId =Auth_helper.auth_helper.getUserId();
      this.countries = await fireStore_Helper.helper.getAllCountreis();
      if (countries != null) {
        selectCountry(countries.first);
      }
      notifyListeners();
    } on Exception catch (e) {
      // TODO
    }
  }

//////////////////Sign out////////////////////////////////////
  logOut() async {
    await Auth_helper.auth_helper.signOut();
    AppRouter.appRouter.gotoPagewithReplacment(Login.routeName);
  }
}
/////////////////////
