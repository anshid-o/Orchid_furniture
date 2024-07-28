import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchid_furniture/constants.dart';
import 'dart:io' as i;

class AddFurniturePage extends StatefulWidget {
  @override
  _AddFurniturePageState createState() => _AddFurniturePageState();
}

class _AddFurniturePageState extends State<AddFurniturePage> {
  XFile? file0;
  String imageUrl0 = '';
  String pathImage = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _sellprice = TextEditingController();
  TextEditingController _lengthController = TextEditingController();
  TextEditingController _widthController = TextEditingController();
  TextEditingController _stock = TextEditingController();

  String _category = 'Sofa';
  String _woodType = 'Oak';
  bool _isSizeRequired = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          width: 2.0, // Adjust border width here
          color: Colors.grey, // Border color (optional)
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          width: 3.0, // Adjust border width here
          color: Colors.black, // Border color (optional)
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          width: 3.0, // Adjust border width here
          color: woodcol, // Border color when focused (optional)
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightWoodcol,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: lightWoodcol,
        title: Text(
          'Add Furniture',
          style: TextStyle(
            fontSize: 36,
            color: woodcol,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: size.width * .075,
            right: size.width * .075,
            top: size.height * .04),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              pathImage != ''
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: size.height * .175,
                            width: size.width * .4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                i.File(pathImage),
                                fit: BoxFit.fitWidth,
                              ),
                            )),
                        IconButton(
                            onPressed: () async {
                              await showOptionsDialog(context, 0);
                              await uploadImage(context, 0);
                            },
                            icon: Icon(
                              Icons.change_circle_outlined,
                              size: 50,
                              color: col60,
                            ))
                      ],
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .2),
                      child: GestureDetector(
                        onTap: () async {
                          await showOptionsDialog(context, 0);
                          await uploadImage(context, 0);
                        },
                        child: Container(
                          height: size.height * .15,
                          decoration: BoxDecoration(
                              color: lightWoodcol,
                              border: Border.all(color: woodcol, width: 3),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 80,
                          )),
                        ),
                      ),
                    ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Furniture Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter furniture name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: _inputDecoration('Description'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: _inputDecoration('Purchase Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _sellprice,
                decoration: _inputDecoration('Selling Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: _inputDecoration('Category'),
                value: _category,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: _inputDecoration('Wood Type'),
                value: _woodType,
                items: woodTypes.map((String wood) {
                  return DropdownMenuItem<String>(
                    value: wood,
                    child: Text(wood),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _woodType = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a wood type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stock,
                decoration: _inputDecoration('Count'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter count';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('Add custom size?'),
                value: _isSizeRequired,
                onChanged: (value) {
                  setState(() {
                    _isSizeRequired = value!;
                  });
                },
              ),
              if (_isSizeRequired) ...[
                TextFormField(
                  controller: _lengthController,
                  decoration: _inputDecoration('Length (cm)'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (_isSizeRequired && (value == null || value.isEmpty)) {
                      return 'Please enter length';
                    }
                    if (_isSizeRequired && double.tryParse(value!) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _widthController,
                  decoration: _inputDecoration('Width (cm)'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (_isSizeRequired && (value == null || value.isEmpty)) {
                      return 'Please enter width';
                    }
                    if (_isSizeRequired && double.tryParse(value!) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .25, vertical: size.height * .02),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String name = _nameController.text;
                      String description = _descriptionController.text;
                      double price =
                          double.tryParse(_priceController.text) ?? 0.0;
                      String length = _lengthController.text;
                      String width = _widthController.text;
                      await FirebaseFirestore.instance
                          .collection("products")
                          .add({
                        'url': imageUrl0,
                        'name': _nameController.text,
                        'desc': _descriptionController.text,
                        'price': int.parse(_priceController.text),
                        'category': _category,
                        'stock': int.parse(_stock.text),
                        'wood': _woodType,
                        'sellPrice': int.parse(_sellprice.text),
                        'length': _isSizeRequired ? int.parse(length) : 0,
                        'width': _isSizeRequired ? int.parse(width) : 0,
                        'time': DateTime.now()
                      });
                      // Process data (e.g., send to server)
                      print(
                          'Furniture Added:$imageUrl0 $name, $description, $price, $_category, $_woodType, ${_isSizeRequired ? '$length x $width' : 'No custom size'}');
                      Fluttertoast.showToast(msg: 'Furniture Added');
                    }
                    if (imageUrl0 == '') {
                      Fluttertoast.showToast(msg: 'Choose an image');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: woodcol,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: const Text('Save',
                      style: TextStyle(fontSize: 18, color: col30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage(BuildContext context, int index) async {
    XFile? selectedFile;
    selectedFile = file0;

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

        setState(() {
          imageUrl0 = url;
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.6, // 80% of screen width
            height: MediaQuery.of(context).size.height *
                0.3, // 40% of screen height
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    'Choose an option',
                    style: TextStyle(fontSize: isPhone ? 26 : 40),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          child: IconButton(
                            onPressed: () async {
                              file0 = await imagePicker.pickImage(
                                  source: ImageSource.camera);
                              if (file0 != null) {
                                setState(() {
                                  pathImage = file0!.path;
                                });
                              }
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              size: isPhone ? 26 : 36,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Camera',
                          style: TextStyle(fontSize: isPhone ? 20 : 26),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          child: IconButton(
                            onPressed: () async {
                              file0 = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (file0 != null) {
                                setState(() {
                                  pathImage = file0!.path;
                                });
                              }
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.image,
                              size: isPhone ? 26 : 36,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Gallery',
                          style: TextStyle(fontSize: isPhone ? 20 : 26),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
