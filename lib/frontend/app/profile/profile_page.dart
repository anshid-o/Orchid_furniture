import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/frontend/app/profile/my_posts.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/frontend/app/profile/personal_details_page.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'NN';
  checkUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(Auth().currentUser!.uid)
        .get()
        .then(
      (value) {
        setState(() {
          var x = value.data();
          name = x!['name'];

          print(name);
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
    List<String> names = isProfileCreated ? name.toString().split(' ') : [];
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width * .325, right: size.width * .325, top: 30),
            child: Container(
              height: size.width * .3,
              width: size.width * .2,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  borderRadius: BorderRadius.circular(60)),
              child: Center(
                child: Auth().currentUser != null
                    ? isProfileCreated
                        ? Text(
                            names[0][0].toUpperCase() +
                                names[1][0].toUpperCase(),
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: col60),
                          )
                        : TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.login),
                            iconAlignment: IconAlignment.end,
                            label: const Text(
                              'SignIn',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                    : Text(
                        'NN',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: col60),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Center(
            child: Text(
              Auth().currentUser != null && isProfileCreated
                  ? Auth().currentUser!.displayName!
                  : 'No name',
              style: const TextStyle(fontSize: 16, color: Colors.black38),
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () {
                if (Auth().currentUser == null) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: 'You haven\'t login yet',
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalDetailsPage(),
                      ));
                }
              },
              title: const Text(
                'Personal  Details',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.person_outlined),
            ),
          ),
          Divider(
            height: 1,
            indent: size.width * .1,
            endIndent: size.width * .1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () {
                if (Auth().currentUser == null) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: 'You haven\'t login yet',
                  );
                }
              },
              title: const Text(
                'Favourites',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.favorite_border_outlined),
            ),
          ),
          Divider(
            height: 1,
            indent: size.width * .1,
            endIndent: size.width * .1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () {
                if (Auth().currentUser == null) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: 'You haven\'t login yet',
                  );
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyPosts(),
                  ));
                }
              },
              title: const Text(
                'My Posts',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.image),
            ),
          ),
          Divider(
            height: 1,
            indent: size.width * .1,
            endIndent: size.width * .1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () {
                if (Auth().currentUser == null) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: 'You haven\'t login yet',
                  );
                }
              },
              title: const Text(
                'Booking & Reviews',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.star_border),
            ),
          ),
          Divider(
            height: 1,
            indent: size.width * .1,
            endIndent: size.width * .1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () async {
                final ux = Uri(
                    scheme: 'https',
                    host: 'www.freeprivacypolicy.com',
                    path: 'live/ec577dac-e6b2-4354-9cd5-0d4b4e2091e0');
                if (await canLaunchUrl(ux)) {
                  await launchUrl(ux, mode: LaunchMode.externalApplication);
                }
              },
              title: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.privacy_tip_outlined),
            ),
          ),
          Divider(
            height: 1,
            indent: size.width * .1,
            endIndent: size.width * .1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () async {
                const to = 'fithinfith@gmail.com';

                const subject = 'Contact\tto\tHome\tShifting\tGroup';
                const message =
                    'Hello\\tHome\tShifting\tTeam,\n\nCheck\tout\tthis\temail\tthat\tsent\tto\tcontact\tto\tworkerr\tgroup.\n\n\n';
                final ux = Uri(
                    scheme: 'mailto',
                    path: to,
                    queryParameters: {'subject': subject, 'body': message});
                String url = ux.toString();
                if (await canLaunch(url)) {
                  await launch(
                    url,
                  );
                } else {
                  print('Could not launch $url');
                }
              },
              title: const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.contact_phone_outlined),
            ),
          ),
          Divider(
            height: 1,
            indent: size.width * .1,
            endIndent: size.width * .1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () {
                if (Auth().currentUser == null) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: 'You haven\'t login yet',
                  );
                }
              },
              title: const Text(
                'Rate & Feedback',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.feedback_outlined),
            ),
          ),
          Divider(
            height: 1,
            indent: size.width * .1,
            endIndent: size.width * .1,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .05),
            child: ListTile(
              onTap: () {
                if (Auth().currentUser == null) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: 'You haven\'t login yet',
                  );
                }
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PhoneLoginPage(),
                //     ));
              },
              title: const Text(
                'Help centre',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.help_center_outlined),
            ),
          ),
          Auth().currentUser != null
              ? Divider(
                  height: 1,
                  indent: size.width * .1,
                  endIndent: size.width * .1,
                )
              : const SizedBox(),
          Auth().currentUser != null
              ? Padding(
                  padding: EdgeInsets.only(left: size.width * .05),
                  child: ListTile(
                    onTap: () async {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        text: 'Do you want to logout',
                        confirmBtnText: 'Yes',
                        cancelBtnText: 'No',
                        onConfirmBtnTap: () async {
                          await Auth().signOut();

                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                        confirmBtnColor: Colors.green,
                      );
                    },
                    title: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                    leading: const Icon(Icons.logout_outlined),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
