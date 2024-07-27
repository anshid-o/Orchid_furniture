import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const col60 = Color.fromRGBO(58, 45, 120, 1);
const col30 = Colors.white;
const col5 = Color.fromARGB(255, 240, 240, 240);
const col15 = Color.fromARGB(255, 175, 174, 174);
const col10 = Color.fromARGB(255, 110, 172, 252);

const woodcol = Color.fromARGB(255, 161, 102, 47);
const lightWoodcol = Color.fromARGB(255, 255, 248, 220);

const gap20 = SizedBox(
  height: 20,
);

const gap10 = SizedBox(
  height: 10,
);

MyCustomlAertDialod(
        BuildContext ctx, String title, String content, Color col) =>
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 90,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: col,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18, color: col30),
                        ),
                        const Spacer(),
                        Text(
                          content,
                          style: TextStyle(fontSize: 12, color: col30),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20)),
                child: SvgPicture.asset(
                  'assets/truck.svg',
                  height: 36,
                  width: 30,
                  color: Color(0xFF801336),
                ),
              ),
            ),
            Positioned(
              top: -10,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/balloon.svg',
                    height: 40,
                    color: Color(0xFF801336),
                  ),
                  Positioned(
                    top: 7,
                    child: SvgPicture.asset(
                      'assets/close.svg',
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
      ),
    );
final List<String> categories = [
  'Sofa',
  'Table',
  'Chair',
  'Bed',
  'Cabinet',
  'Shelf',
  'Desk',
  'Bench',
  'Armchair',
  'Dining Set'
];

final List<String> woodTypes = [
  'Oak',
  'Pine',
  'Walnut',
  'Maple',
  'Cherry',
  'Teak',
  'Mahogany'
];
List<String> month_abbreviations = [
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
];
List<String> places = [
  'beypore',
  'chathamangalam',
  'chelannur',
  'chelavur',
  'cheruvannoor',
  'chevayur',
  'elathur',
  'feroke',
  'kacheri',
  'kadalundi',
  'kakkad',
  'kakkodi',
  'kakkur',
  'karuvanthiRuthi',
  'kasaba',
  'kodiyathur',
  'kottooli',
  'Koolimad'
      'kumaranallur',
  'kunnamangalam',
  'kuruvaTToor',
  'kuttikkaTTor',
  'madavur',
  'mavoor',
  'nagaram',
  'nanminda',
  'neeleswaram',
  'nellikode',
  'olavanna',
  'panniyankara',
  'pantheerankavu',
  'perumanna',
  'peruvayal',
  'poolakkode',
  'puthiyangadi',
  'ramanattukara',
  'thalakulathur',
  'thazekode',
  'valayanad',
  'vengeri',
  'arikkulam',
  'atholi',
  'avidanallur',
  'balussery',
  'chakkittappara',
  'changaroth',
  'chemancheri',
  'chempanoda',
  'chengottukavu',
  'cheruvannur',
  'eravattur',
  'iringal',
  'kayanna',
  'keezhariyur',
  'koorachundu',
  'koothali',
  'kottur',
  'kozhukkallur',
  'menhanyam',
  'meppayyur',
  'moodadi',
  'naduvannur',
  'nochad',
  'paleri',
  'panthalayani',
  'payyoli',
  'perambra',
  'thikkodi',
  'thurayur',
  'ulliyeri',
  'viyur',
  'ayancheri',
  'azhiyur',
  'chekyad',
  'chorode',
  'edachery',
  'eramala',
  'kavilumpara',
  'kayakkodi',
  'kottappally',
  'kunnummal',
  'kuttyadi',
  'maniyur',
  'maruthonkara',
  'nadakkuthazhe',
  'nadapuram',
  'narippatta',
  'onchiyam',
  'palayad',
  'purameri',
  'thinur',
  'thiruvallur',
  'thuneri',
  'vadakara',
  'valayam',
  'vanimel',
  'velam',
  'vilangad',
  'villyppally',
  'engapuzha'
];
