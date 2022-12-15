import 'dart:io';

import 'package:device_shop/data/service/file_uploder.dart';
import 'package:device_shop/view_models/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String imageUrl = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) {
          return profileViewModel.user != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(Icons.logout,size: 30,color: Colors.red,)),
                    isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox(),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),

                        child: profileViewModel.user!.photoURL == null
                            ? Container(
                                width: 200,
                                height: 200,
                                decoration:
                                     BoxDecoration(shape: BoxShape.circle,color: Colors.grey.withOpacity(0.4)),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            profileViewModel.user!.photoURL!),
                                        fit: BoxFit.cover)),
                              ),
                      ),
                    ),
                   const SizedBox(height: 20,),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            minimumSize: const Size(200, 60),
                            primary: Colors.grey.withOpacity(0.4),
                            elevation: 0),
                        onPressed: () {
                          _showPicker(context);
                        },
                        child: const Text("Edit Image"),
                      ),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploder(pickedFile);
      if (!mounted) return;
      Provider.of<ProfileViewModel>(context, listen: false)
          .updatePhoto(imageUrl);
      setState(() {
        isLoading = false;
        _image = pickedFile;
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploder(pickedFile);
      if (!mounted) return;
      Provider.of<ProfileViewModel>(context, listen: false)
          .updatePhoto(imageUrl);
      setState(() {
        _image = pickedFile;
      });
    }
  }
}
