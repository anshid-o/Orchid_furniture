import 'package:flutter/material.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/frontend/app/home/post_details.dart';

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.index,
      required this.size,
      required this.pids,
      required this.postList});
  final int index;
  final List<Map<String, dynamic>> postList;
  final Size size;
  final List<String> pids;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetails(
                  post: postList[index],
                  pid: pids[index],
                ),
              ));
        },
        child: Container(
          height: size.height * .16,
          width: size.width * .75,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(231, 230, 230, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    postList[index]['images'][0],
                    fit: BoxFit.cover,
                    width: size.width * .4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postList[index]['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.meeting_room_sharp,
                          color: col60,
                          size: 16,
                        ),
                        Text(
                          postList[index]['bassic'][2].toString(),
                          style: const TextStyle(color: col60, fontSize: 14),
                        ),
                        SizedBox(
                          width: size.width * .05,
                        ),
                        const Icon(
                          Icons.bathtub,
                          color: col60,
                          size: 16,
                        ),
                        Text(
                          postList[index]['bassic'][3].toString(),
                          style: const TextStyle(color: col60, fontSize: 14),
                        ),
                        SizedBox(
                          width: size.width * .05,
                        ),
                        const Icon(
                          Icons.square_foot_rounded,
                          color: col60,
                          size: 16,
                        ),
                        Text(
                          postList[index]['sqft'].toString(),
                          style: const TextStyle(color: col60, fontSize: 14),
                        ),
                      ],
                    ),
                    Text(
                      postList[index]['place'],
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                    Text(
                      postList[index]['price'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: col60),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
