import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/constants.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<Map<String, dynamic>> bookingList = [];
  getBookings() async {
    await FirebaseFirestore.instance
        .collection('shifts')
        .where('uid', isEqualTo: Auth().currentUser!.uid)
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            setState(() {
              bookingList.add(element.data());
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bookingList.isEmpty
          ? col30
          : const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            'My Bookings',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: col60),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: col60,
                )),
          )
        ],
      ),
      body: bookingList.isEmpty
          ? Center(child: Lottie.asset('assets/empty.json', height: 300))
          : Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return BookingCard(
                    index: index,
                    size: size,
                    bookingList: bookingList,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: bookingList.length,
              ),
            ),
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard(
      {super.key,
      required this.size,
      required this.index,
      required this.bookingList});

  final Size size;
  final int index;
  final List<Map<String, dynamic>> bookingList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .025),
      child: Stack(
        children: [
          Container(
            height: size.height * .25,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 37, 150, 190),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.fire_truck,
                            color: Color.fromARGB(255, 166, 255, 0),
                            size: 36,
                          ),
                          SizedBox(
                            width: size.width * .22,
                            child: Text(
                              bookingList[index]['from'],
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: col30),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Color.fromARGB(255, 166, 255, 0),
                            size: 36,
                          ),
                          SizedBox(
                            width: size.width * .22,
                            child: Text(
                              bookingList[index]['to'],
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: col30),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        '10:00 AM - 11:00 AM',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: col30),
                      ),
                      const Text(
                        'Booked',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: col30),
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width * .25,
                  decoration: const BoxDecoration(
                      color: col30,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        month_abbreviations[int.parse(bookingList[index]['date']
                            .toString()
                            .substring(
                                bookingList[index]['date']
                                        .toString()
                                        .indexOf('/') +
                                    1,
                                bookingList[index]['date']
                                    .toString()
                                    .lastIndexOf('/')))],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: col60),
                      ),
                      Text(
                        bookingList[index]['date'].toString().substring(0,
                            bookingList[index]['date'].toString().indexOf('/')),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        bookingList[index]['date'].toString().substring(
                            bookingList[index]['date']
                                    .toString()
                                    .lastIndexOf('/') +
                                1),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: col60),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: -size.height * .05,
            left: size.width * .635,
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 240, 240, 240),
              radius: 25,
            ),
          ),
          Positioned(
            top: size.height * .23,
            left: size.width * .635,
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 240, 240, 240),
              radius: 25,
            ),
          )
        ],
      ),
    );
  }
}
