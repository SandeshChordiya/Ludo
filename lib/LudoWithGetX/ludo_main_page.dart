import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ludo2/LudoWithGetX/ludo_main_using_getx.dart';
import 'package:ludo2/LudoWithGetx2Bots/ludo_with_getx_2_bots_main_screen.dart';
import 'package:ludo2/LudoWithGetx3Bots/ludo_with_3_bots_main_screen.dart';
import 'package:ludo2/PlayGame.dart';

class LudoHomePage extends StatefulWidget {
  const LudoHomePage({super.key});

  @override
  State<LudoHomePage> createState() => _LudoHomePageState();
}

class _LudoHomePageState extends State<LudoHomePage> {
  int _currentIndex = 0;

  List<String> names = [
    "Aarav",
    "Abhinav",
    "Aditi",
    "Akash",
    "Aman",
    "Amar",
    "Amit",
    "Anika",
    "Anil",
    "Anish",
    "Anjali",
    "Ankita",
  ];

  // List<NetworkImage> _tabs = [];

  // @override
  // void initState() {
  //   super.initState();
  // }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(95, 42, 15, 110),
          body: Container(
            child: ListView(
              children: [
                Container(
                  color: Color.fromARGB(255, 13, 1, 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      Text(
                        "USERNAME",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.payment),
                          label: const Text("2.5k")),
                      TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.diamond),
                          label: const Text("2.5k")),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => PlayGame());
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          color: Color.fromARGB(255, 12, 3, 72),
                          child: ListTile(
                            leading: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/trofi.png?alt=media&token=0ae7b54c-9d98-417b-aab3-7d63cbe86bc3"),
                            title: Text(
                              "RANKING",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        color: Color.fromARGB(255, 12, 3, 72),
                        child: ListTile(
                          trailing: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/vip.png?alt=media&token=a1a4154b-044b-4356-88a4-f1d453e03c00"),
                          title: Text(
                            "VIP",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/spin.png?alt=media&token=8ff2b462-d2bb-44a2-b666-947b83526aa7"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/tutorials.png?alt=media&token=a97b6871-928a-45d4-975e-59227ed2e921"),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: 150,
                            width: 150,
                            child: Image.asset(
                                "images/ludo logo/Super Ludo Gold.png"),
                          )),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/vipBonus.png?alt=media&token=de30533d-6627-497e-9639-d80262023b8b"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/firstPayPack.png?alt=media&token=a722c329-db42-455e-ba7d-5680781217e5"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/2%20%26%204%20players.png?alt=media&token=2582efb7-d016-44cf-90d5-c5671fcf63ff'),
                  ),
                  onTap: () {
                    Get.to(() => LudoMain4());
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/VIP%20table.png?alt=media&token=087b2aa6-ea3b-4c19-8cd4-2a8bde6efdac"),
                          ),
                          onTap: () {
                            Get.to(() => LudoWith2BotsMainScreen());
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/private.png?alt=media&token=0c156b7d-a751-4cc2-9005-84fb1ab29f40"),
                          ),
                          onTap: () {
                            Get.to(() => LudoWith3BotsMainScreen());
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/teamup.png?alt=media&token=a516a4e0-ec0b-4580-951f-4d5093493334"),
                          ),
                          onTap: () {
                            // Get.to(() => MainScreen1());
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Color.fromARGB(255, 13, 1, 45)),
            child: Container(
              child: BottomNavigationBar(
                backgroundColor: Color.fromARGB(255, 13, 1, 45),
                currentIndex: _currentIndex,
                onTap: onTabTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        width: 50,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/trofi.png?alt=media&token=0ae7b54c-9d98-417b-aab3-7d63cbe86bc3')),
                    label: 'Skin',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        width: 50,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/vipBonus.png?alt=media&token=de30533d-6627-497e-9639-d80262023b8b')),
                    label: 'Event',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        width: 50,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/spin.png?alt=media&token=8ff2b462-d2bb-44a2-b666-947b83526aa7')),
                    label: 'Lobbby',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        width: 50,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ludo-5620d.appspot.com/o/vipBonus.png?alt=media&token=de30533d-6627-497e-9639-d80262023b8b')),
                    label: 'Social',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        width: 50,
                        child: Image.asset(
                            'images/ludo logo/Super Ludo Gold.png')),
                    label: 'Store',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
