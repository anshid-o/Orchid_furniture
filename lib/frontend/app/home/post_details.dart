import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post, required this.pid});
  final Map<String, dynamic> post;
  final String pid;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Map<String, dynamic>? owner;
  String? date;
  getOwnerdata() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post['uid'])
        .get()
        .then(
      (value) {
        setState(() {
          owner = value.data();
        });
      },
    );
  }

  setTime() {
    Timestamp dateTime = widget.post['time'];
    DateTime x =
        DateTime.fromMicrosecondsSinceEpoch(dateTime.microsecondsSinceEpoch);
    setState(() {
      date = 'Posted on ${x.day} ${month_abbreviations[x.month]} ${x.year}';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getOwnerdata();
    setTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: col30,
      appBar: AppBar(
        backgroundColor: col30,
        titleSpacing: size.width * .2,
        title: Text(
          '${widget.post['name']}',
          style: const TextStyle(
              fontSize: 20, color: col60, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: col5, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ListView(
              children: [
                SizedBox(
                    height: size.height * .25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.post['images'][0],
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: size.height * .075,
                  decoration: BoxDecoration(
                      color: col30, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.post['price']}/-',
                        style: const TextStyle(
                            color: col60,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () async {
                            final urlPreviewer = widget.post['images'][0];
                            final response =
                                await http.get(Uri.parse(urlPreviewer));
                            final bytes = response.bodyBytes;

                            final tempDir = await getTemporaryDirectory();
                            final fileName =
                                '${widget.post['name']}.jpg'; // Constructing filename
                            final path = '${tempDir.path}/$fileName';

                            // Write image bytes to file
                            await File(path).writeAsBytes(bytes);

                            // Share the downloaded image
                            await Share.shareFiles(
                              [path],
                              text:
                                  'Name: ${widget.post['name']}\nType: ${widget.post['bassic'][0] == 1 ? 'Rent' : widget.post['bassic'][0] == 2 ? 'Sale' : 'PG'}\nSub Type: ${widget.post['bassic'][1] == 1 ? 'Apartment' : widget.post['bassic'][1] == 2 ? 'House' : 'Flat'}\n${widget.post['bassic'][2].toString()} Bed\n${widget.post['bassic'][3].toString()} Bath\n${widget.post['sqft'].toString()} sq.ft\nPlace: ${widget.post['place']}\n\n\nPrice: ${widget.post['price']}',
                            );
                          },
                          icon: const Icon(
                            Icons.share,
                            color: col10,
                          )),
                      IconButton(
                          onPressed: () async {
                            final phoneNumber = '+91${widget.post['phone']}';
                            final url = Uri(scheme: 'tel', host: phoneNumber);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                              );
                              //url_launcher
                            }
                          },
                          icon: const Icon(
                            Icons.call,
                            color: col10,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: size.height * .075,
                  decoration: BoxDecoration(
                      color: col30, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Type : ${widget.post['bassic'][0] == 1 ? 'Rent' : widget.post['bassic'][0] == 2 ? 'Sale' : 'PG'}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Sub Type : ${widget.post['bassic'][1] == 1 ? 'Apartment' : widget.post['bassic'][1] == 2 ? 'House' : 'Flat'}',
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontSize: 14, color: col15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'Age : ${widget.post['bassic'][4] == 1 ? '1 - 2' : widget.post['bassic'][4] == 2 ? '3 - 4' : widget.post['bassic'][4] == 3 ? '5 - 10' : '10 +'}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                    height: size.height * .085,
                    decoration: BoxDecoration(
                        color: col30, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.post['bassic'][2]} BHK Independent',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: size.width * .05,
                              ),
                              const Icon(
                                Icons.meeting_room_sharp,
                                color: col60,
                                size: 26,
                              ),
                              Text(
                                '${widget.post['bassic'][2].toString()} Bed',
                                style:
                                    const TextStyle(color: col15, fontSize: 14),
                              ),
                              SizedBox(
                                width: size.width * .05,
                              ),
                              const Icon(
                                Icons.bathtub,
                                color: col60,
                                size: 26,
                              ),
                              Text(
                                '${widget.post['bassic'][3].toString()} Bath',
                                style:
                                    const TextStyle(color: col15, fontSize: 14),
                              ),
                              SizedBox(
                                width: size.width * .05,
                              ),
                              const Icon(
                                Icons.square_foot_rounded,
                                color: col60,
                                size: 26,
                              ),
                              Text(
                                '${widget.post['sqft'].toString()} sq.ft',
                                style:
                                    const TextStyle(color: col15, fontSize: 14),
                              ),
                              SizedBox(
                                width: size.width * .05,
                              ),
                            ],
                          ),
                        ])),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: size.height * .075,
                  decoration: BoxDecoration(
                      color: col30, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${owner?['name']}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Text(
                              'Owner',
                              style: TextStyle(fontSize: 14, color: col15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton.icon(
                          onPressed: () async {
                            final phoneNumber = '+91${widget.post['phone']}';
                            final url = Uri(scheme: 'tel', host: phoneNumber);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                              );
                              //url_launcher
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(col10),
                          ),
                          icon: const Icon(
                            Icons.call,
                            color: col30,
                          ),
                          label: const Text(
                            'Call Now',
                            style: TextStyle(color: col30),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: size.height * .075,
                  decoration: BoxDecoration(
                      color: col30, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.post['place']}, ${widget.post['pincode']}',
                              style:
                                  const TextStyle(fontSize: 18, color: col15),
                            ),
                            Text(
                              date!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: size.height * .2,
                  decoration: BoxDecoration(
                      color: col30, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description :',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.post['other']}',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                gap10,
                Container(
                  decoration: BoxDecoration(
                      color: col30, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.post['images'][1] != ''
                            ? const Text(
                                'Other Images :',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            : const SizedBox(),
                        gap10,
                        widget.post['images'][1] != ''
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      widget.post['images'][1] != ''
                                          ? SizedBox(
                                              height: 100,
                                              width: size.width * .25,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  widget.post['images'][1],
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ))
                                          : const SizedBox(),
                                      widget.post['images'][2] != ''
                                          ? SizedBox(
                                              height: 100,
                                              width: size.width * .25,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  widget.post['images'][2],
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ))
                                          : const SizedBox(),
                                      widget.post['images'][3] != ''
                                          ? SizedBox(
                                              height: 100,
                                              width: size.width * .25,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  widget.post['images'][3],
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ))
                                          : const SizedBox()
                                    ],
                                  ),
                                  widget.post['images'][4] != ''
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            widget.post['images'][4] != ''
                                                ? SizedBox(
                                                    height: 100,
                                                    width: size.width * .25,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        widget.post['images']
                                                            [1],
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ))
                                                : const SizedBox(),
                                            widget.post['images'][5] != ''
                                                ? SizedBox(
                                                    height: 100,
                                                    width: size.width * .25,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        widget.post['images']
                                                            [2],
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ))
                                                : const SizedBox(),
                                            widget.post['images'][6] != ''
                                                ? SizedBox(
                                                    height: 100,
                                                    width: size.width * .25,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        widget.post['images']
                                                            [3],
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ))
                                                : const SizedBox()
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
