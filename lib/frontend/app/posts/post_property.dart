import 'dart:io' as i;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchid_furniture/frontend/app/posts/add_address.dart';
import 'package:quickalert/quickalert.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/constants.dart';

class PostProperty extends StatefulWidget {
  PostProperty({super.key, required this.p1});
  List<int> p1;

  @override
  State<PostProperty> createState() => _PostPropertyState();
}

class _PostPropertyState extends State<PostProperty> {
  XFile? file0;
  XFile? file1;
  XFile? file2;
  XFile? file3;
  XFile? file4;
  XFile? file5;
  XFile? file6;

  String imageUrl0 = '';
  String imageUrl1 = '';
  String imageUrl2 = '';
  String imageUrl3 = '';
  String imageUrl4 = '';
  String imageUrl5 = '';
  String imageUrl6 = '';

  List<String> pathImages = List<String>.filled(7, '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            gap20,
            const Text(
              'Cover Image :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            gap10,
            pathImages[0] != ''
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                    child: SizedBox(
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            i.File(pathImages[0]),
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                    child: GestureDetector(
                      onTap: () async {
                        await showOptionsDialog(context, 0);
                        await uploadImage(context, 0);
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: col5,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          'Choose the cover image',
                          style: TextStyle(fontSize: 16),
                        )),
                      ),
                    ),
                  ),
            gap20,
            const Text(
              'Other Images :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            gap10,
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    pathImages[1] != ''
                        ? SizedBox(
                            height: 100,
                            width: size.width * .25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                i.File(pathImages[1]),
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        : GestureDetector(
                            onTap: () async {
                              await showOptionsDialog(context, 1);
                              await uploadImage(context, 1);
                            },
                            child: Container(
                              height: 100,
                              width: size.width * .25,
                              decoration: BoxDecoration(
                                  color: col5,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                '1',
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                          ),
                    pathImages[2] != ''
                        ? SizedBox(
                            height: 100,
                            width: size.width * .25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                i.File(pathImages[2]),
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        : GestureDetector(
                            onTap: () async {
                              await showOptionsDialog(context, 2);
                              await uploadImage(context, 2);
                            },
                            child: Container(
                              height: 100,
                              width: size.width * .25,
                              decoration: BoxDecoration(
                                  color: col5,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                '2',
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                          ),
                    pathImages[3] != ''
                        ? SizedBox(
                            height: 100,
                            width: size.width * .25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                i.File(pathImages[3]),
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        : GestureDetector(
                            onTap: () async {
                              await showOptionsDialog(context, 3);
                              await uploadImage(context, 3);
                            },
                            child: Container(
                              height: 100,
                              width: size.width * .25,
                              decoration: BoxDecoration(
                                  color: col5,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                '3',
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                          ),
                  ],
                ),
                gap10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    pathImages[4] != ''
                        ? SizedBox(
                            height: 100,
                            width: size.width * .25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                i.File(pathImages[4]),
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        : GestureDetector(
                            onTap: () async {
                              await showOptionsDialog(context, 4);
                              await uploadImage(context, 4);
                            },
                            child: Container(
                              height: 100,
                              width: size.width * .25,
                              decoration: BoxDecoration(
                                  color: col5,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                '4',
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                          ),
                    pathImages[5] != ''
                        ? SizedBox(
                            height: 100,
                            width: size.width * .25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                i.File(pathImages[5]),
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        : GestureDetector(
                            onTap: () async {
                              await showOptionsDialog(context, 5);
                              await uploadImage(context, 5);
                            },
                            child: Container(
                              height: 100,
                              width: size.width * .25,
                              decoration: BoxDecoration(
                                  color: col5,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                '5',
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                          ),
                    pathImages[6] != ''
                        ? SizedBox(
                            height: 100,
                            width: size.width * .25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                i.File(pathImages[6]),
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        : GestureDetector(
                            onTap: () async {
                              await showOptionsDialog(context, 6);
                              await uploadImage(context, 6);
                            },
                            child: Container(
                              height: 100,
                              width: size.width * .25,
                              decoration: BoxDecoration(
                                  color: col5,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                '6',
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                          ),
                  ],
                )
              ],
            ),
            gap20,
            gap20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .2),
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(col30)),
                  onPressed: () {
                    if (imageUrl0 == '') {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        text: 'You have to choose cover pic to continue',
                      );
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAddress(
                                p1: widget.p1,
                                p2: [
                                  imageUrl0,
                                  imageUrl1,
                                  imageUrl2,
                                  imageUrl3,
                                  imageUrl4,
                                  imageUrl5,
                                  imageUrl6
                                ]),
                          ));
                    }
                  },
                  child: const Text('Save & Continue')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadImage(BuildContext context, int index) async {
    XFile? selectedFile;
    switch (index) {
      case 0:
        selectedFile = file0;
        break;
      case 1:
        selectedFile = file1;
        break;
      case 2:
        selectedFile = file2;
        break;
      case 3:
        selectedFile = file3;
        break;
      case 4:
        selectedFile = file4;
        break;
      case 5:
        selectedFile = file5;
        break;
      case 6:
        selectedFile = file6;
        break;
    }

    if (selectedFile != null) {
      print('ok');
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('Usersimages');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);
      i.File f = i.File(selectedFile.path);

      print('going');
      try {
        await referenceImageToUpload.putFile(f);
        String url = await referenceImageToUpload.getDownloadURL();
        print(url);
        setState(() {
          switch (index) {
            case 0:
              setState(() {
                imageUrl0 = url;
              });
              break;
            case 1:
              setState(() {
                imageUrl1 = url;
              });
              break;
            case 2:
              setState(() {
                imageUrl2 = url;
              });
              break;
            case 3:
              setState(() {
                imageUrl2 = url;
              });
              break;
            case 4:
              setState(() {
                imageUrl4 = url;
              });
              break;
            case 5:
              setState(() {
                imageUrl5 = url;
              });
              break;
            case 6:
              setState(() {
                imageUrl6 = url;
              });
              break;
          }
        });
        if (url == '') {
          ProgressIndicator;
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> showOptionsDialog(BuildContext context, int index) {
    ImagePicker imagePicker = ImagePicker();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Wrap(
                children: [
                  Column(
                    children: [
                      const Center(
                          child: Text(
                        'Choose an option',
                        style: TextStyle(fontSize: 20),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: () async {
                                    switch (index) {
                                      case 0:
                                        file0 = await imagePicker.pickImage(
                                            source: ImageSource.camera);
                                        if (file0 != null) {
                                          setState(() {
                                            pathImages[0] = file0!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 1:
                                        file1 = await imagePicker.pickImage(
                                            source: ImageSource.camera);
                                        if (file1 != null) {
                                          setState(() {
                                            pathImages[1] = file1!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 2:
                                        file2 = await imagePicker.pickImage(
                                            source: ImageSource.camera);
                                        if (file2 != null) {
                                          setState(() {
                                            pathImages[2] = file2!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 3:
                                        file3 = await imagePicker.pickImage(
                                            source: ImageSource.camera);
                                        if (file3 != null) {
                                          setState(() {
                                            pathImages[3] = file3!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 4:
                                        file4 = await imagePicker.pickImage(
                                            source: ImageSource.camera);
                                        if (file4 != null) {
                                          setState(() {
                                            pathImages[4] = file4!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 5:
                                        file5 = await imagePicker.pickImage(
                                            source: ImageSource.camera);
                                        if (file5 != null) {
                                          setState(() {
                                            pathImages[5] = file5!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 6:
                                        file6 = await imagePicker.pickImage(
                                            source: ImageSource.camera);
                                        if (file6 != null) {
                                          setState(() {
                                            pathImages[6] = file6!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                    }
                                  },
                                  icon: const Icon(Icons.camera_alt),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Camera')
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: () async {
                                    switch (index) {
                                      case 0:
                                        file0 = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (file0 != null) {
                                          setState(() {
                                            pathImages[0] = file0!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 1:
                                        file1 = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (file1 != null) {
                                          setState(() {
                                            pathImages[1] = file1!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 2:
                                        file2 = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (file2 != null) {
                                          setState(() {
                                            pathImages[2] = file2!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 3:
                                        file3 = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (file3 != null) {
                                          setState(() {
                                            pathImages[3] = file3!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 4:
                                        file4 = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (file4 != null) {
                                          setState(() {
                                            pathImages[4] = file4!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 5:
                                        file5 = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (file5 != null) {
                                          setState(() {
                                            pathImages[5] = file5!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                      case 6:
                                        file6 = await imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                        if (file6 != null) {
                                          setState(() {
                                            pathImages[6] = file6!.path;
                                          });
                                        }
                                        Navigator.pop(context);
                                        break;
                                    }
                                  },
                                  icon: const Icon(Icons.image),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Gallery')
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ));
        });
  }
}

// IconButton(
            //   onPressed: () async {
            //     await showOptionsDialog(context);
            //     // print(file!.path);
            //     if (file != null) {
            //       String uniqueFileName =
            //           DateTime.now().millisecondsSinceEpoch.toString();
            //       Reference referenceRoot = FirebaseStorage.instance.ref();
            //       Reference referenceDirImages =
            //           referenceRoot.child('Usersimages');
            //       Reference referenceImageToUpload =
            //           referenceDirImages.child(uniqueFileName);
            //       i.File f = i.File(file!.path);
            //       try {
            //         await referenceImageToUpload.putFile(f);
            //         imageUrl = await referenceImageToUpload.getDownloadURL();
            //         setState(() {
            //           imageUrl = imageUrl;
            //         });
            //         if (imageUrl == '') {
            //           ProgressIndicator;
            //         }
            //         if (imageUrl.isEmpty) {
            //           QuickAlert.show(
            //             context: context,
            //             type: QuickAlertType.error,
            //             text: 'Please upload an image',
            //           );
            //         }
            //         // firebase
            //         //     .collection("Users")
            //         //     .doc(user.uid)
            //         //     .update({'imageUrl': imageUrl});
            //       } catch (e) {
            //         print('Error ' + e.toString());
            //       }
            //     }
            //   },
            //   icon: imageUrl == ''
            //       ? const Icon(
            //           Icons.broken_image_outlined,
            //           size: 40,
            //           color: col10,
            //         )
            //       : IconButton(
            //           onPressed: () {
            //             setState(() {
            //               imageUrl = '';
            //             });
            //           },
            //           icon: const Icon(Icons.delete)),
            // ),