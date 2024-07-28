// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:orchid_furniture/constants.dart';

// class NavModel {
//   final Widget page;
//   final GlobalKey<NavigatorState> navKey;

//   NavModel({required this.page, required this.navKey});
// }

// class NavBar extends StatelessWidget {
//   final int pageIndex;
//   final Function(int) onTap;

//   const NavBar({
//     super.key,
//     required this.pageIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return BottomAppBar(
//       notchMargin: 0,
//       color: Colors.white,
//       elevation: 0.0,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           height: 60,
//           color: col60,
//           child: Row(
//             children: [
//               navItem(
//                 Icons.home_outlined,
//                 pageIndex == 0,
//                 onTap: () => onTap(0),
//               ),
//               navItem(
//                 Icons.bed_sharp,
//                 pageIndex == 1,
//                 onTap: () => onTap(1),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Container(
//                   width: size.width * .14,
//                   decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(50))),
//                   child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
//                 ),
//               ),
//               navItem(
//                 Icons.cabin_rounded,
//                 pageIndex == 2,
//                 onTap: () => onTap(2),
//               ),
//               navItem(
//                 Icons.person_outline,
//                 pageIndex == 3,
//                 onTap: () => onTap(3),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         child: Icon(
//           icon,
//           color: selected ? Colors.white : Colors.white.withOpacity(0.4),
//         ),
//       ),
//     );
//   }
// }
