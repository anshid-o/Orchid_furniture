import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';

import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/frontend/widgets/tab_item.dart';
import 'package:quickalert/quickalert.dart';

class ShiftPage extends StatefulWidget {
  ShiftPage({super.key});

  @override
  State<ShiftPage> createState() => _ShiftPageState();
}

class _ShiftPageState extends State<ShiftPage> {
  String dropValue = 'Kozhikode';

  TextEditingController dateContrl = TextEditingController();

  TextEditingController from = TextEditingController();

  TextEditingController to = TextEditingController();

  bool isFlexible = false;

  checkUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(Auth().currentUser!.uid)
        .get()
        .then(
      (value) {
        setState(() {
          isProfileCreated = value.exists;
        });
      },
    );
  }

  bool isProfileCreated = false;
  @override
  void initState() {
    // TODO: implement initState

    checkUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(isProfileCreated);
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Where are you going to relocate?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue[50],
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: col60,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    TabItem(
                      title: 'Within City',
                    ),
                    TabItem(
                      title: 'Between Cities',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    'Select City',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: Container(
                    width: size.width * .9,
                    height: size.height * .06,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: dropValue,
                      icon: Padding(
                        padding: EdgeInsets.only(left: size.width * .5),
                        child: const Icon(Icons.arrow_drop_down_rounded),
                      ),
                      items: [
                        DropdownMenuItem(
                            value: 'Kozhikode',
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * .05),
                              child: const Text('Kozhikode'),
                            )),
                        DropdownMenuItem(
                            value: 'Malappuram',
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * .05),
                              child: const Text('Malappuram'),
                            ))
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropValue = value!;
                        });
                      },
                      underline: const SizedBox(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 5),
                  child: Text(
                    'Select Your Locality',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .01, right: size.width * .01),
                  child: SizedBox(
                    height: size.height * .1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Autocomplete<String>(
                        fieldViewBuilder:
                            (context, from, focusNode, onFieldSubmitted) {
                          return TextFormField(
                            controller: from,
                            onChanged: (value) {
                              from.text = value;
                            },
                            onFieldSubmitted: (value) {
                              onFieldSubmitted;
                            },
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              hintText: 'Shifting from',
                              hintStyle: const TextStyle(height: 0),
                              prefixIcon: const Icon(Icons.location_city),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        optionsMaxHeight: 200,
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable.empty();
                          }
                          return places.where((String item) {
                            return item
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (option) {
                          setState(() {
                            from.text = option;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .01, right: size.width * .01),
                  child: SizedBox(
                    height: size.height * .1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Autocomplete<String>(
                        fieldViewBuilder:
                            (context, to, focusNode, onFieldSubmitted) {
                          return TextFormField(
                            controller: to,
                            onChanged: (value) {
                              to.text = value;
                            },
                            onFieldSubmitted: (value) {
                              onFieldSubmitted;
                            },
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              hintText: 'Shifting to',
                              hintStyle: const TextStyle(height: 0),
                              prefixIcon: const Icon(Icons.location_city),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        optionsMaxHeight: 200,
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable.empty();
                          }
                          return places.where((String item) {
                            return item
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (option) {
                          setState(() {
                            to.text = option;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 5,
                  ),
                  child: Text(
                    'Select shifting date',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .01, right: size.width * .01),
                  child: SizedBox(
                    height: size.height * .1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: dateContrl,
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.calendar_today_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Select Date',
                            hintStyle: const TextStyle(height: 0)),
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          if (dateTime != null) {
                            dateContrl.text =
                                '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isFlexible,
                      activeColor: col60,
                      onChanged: (value) {
                        setState(() {
                          isFlexible = !isFlexible;
                        });
                      },
                    ),
                    const Text('I\'m flexible on my shifting date')
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .2),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(col60),
                        iconSize: WidgetStatePropertyAll(18)),
                    onPressed: () async {
                      if (!isProfileCreated) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          text: 'You have to complete the profile first',
                        );
                      } else if (from.text == '' ||
                          to.text == '' ||
                          dateContrl.text == '') {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text:
                              'Sorry, something went wrong.\nChoose fields appropriately',
                        );
                      } else {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => RazorPayPage(
                        //         from: from.text,
                        //         to: to.text,
                        //         city: dropValue,
                        //         date: dateContrl.text,
                        //       ),
                        //     ));
                      }
                    },
                    child: const Text(
                      'Check prices',
                      style: TextStyle(color: col30),
                    ),
                  ),
                )
              ],
            ),
            const Center(child: Text('Archived Page')),
          ],
        ),
      ),
    );

    // ListView(
    //   children: [
    //     const Padding(
    //       padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
    //       child: Text(
    //         'Where are you going to relocate?',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //   ],
    // );
  }
}



// Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20, top: 5),
//               child: TextButton(
//                   onPressed: () {},
//                   style: const ButtonStyle(
//                     padding: WidgetStatePropertyAll(EdgeInsets.zero),
//                     minimumSize: WidgetStatePropertyAll(Size.zero),
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   ),
//                   child: const Text('Check prices')),
//             )
//           ],
//         )