import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/app/home/show_products.dart';
import 'package:orchid_furniture/app/home/total_economy.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    // getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: lightWoodcol,
        title: Text(
          'H o m e',
          style: TextStyle(
            fontSize: isPhone ? 24 : 42,
            color: woodcol,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: lightWoodcol,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.count(
              crossAxisCount: isPhone ? 2 : 3,
              children: List.generate(
                categories.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListPage(
                                      categ: categories[index],
                                    )));
                      },
                      child: ClayContainer(
                        height: size.height * .2,
                        width: size.width * .3,
                        borderRadius: 30,
                        color: lightWoodcol,
                        child: Center(
                          child: ClayText(
                            categories[index],
                            emboss: true,
                            size: isPhone ? 24 : 40,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}


// : Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: SizedBox(
            //       height: size.height * .7,
            //       child: ListView.separated(
            //           itemBuilder: (context, index) => HomeCard(
            //                 size: size,
            //                 pids: pids,
            //                 index: index,
            //                 postList: postList,
            //               ),
            //           separatorBuilder: (context, index) => const SizedBox(
            //                 height: 5,
            //               ),
            //           itemCount: postList.length),
            //     ),
            //   )