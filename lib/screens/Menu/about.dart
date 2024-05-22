import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _message = '''
      We4Us  is a sanskrit word means “FOOD”. We4Us  can use to help hunger by earning some reward.In We4Us  user can upload there extra meal so that other hungery needy people can get it and that user will win some reward too.
 ''';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('About We4Us '),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              const Text("Our Purpose",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              const Text("Empowering people to end global hunger",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text(
                _message,
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/hungppl.png',
                  width: size.width * 0.8,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Our Values",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              const Text("A few important things we live by",
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Container(
                width: size.width * 0.9,
                height: 220,
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.06),
                          const Icon(CupertinoIcons.heart_fill,
                              color: Colors.red, size: 60),
                          SizedBox(width: size.width * 0.01),
                          const Text("Open and honest",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(40, 30, 40, 10),
                        child: Text(
                          "We want you to know how your donation is used and the impact you’re having around the world.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: size.width * 0.9,
                height: 240,
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.06),
                          const Icon(CupertinoIcons.hand_thumbsup_fill,
                              color: Colors.blueAccent, size: 60),
                          SizedBox(width: size.width * 0.01),
                          const Text("We’re in it together",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(40, 30, 40, 10),
                        child: Text(
                          "We want fighting hunger to be inclusive so that anyone, anywhere, can share the meal.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Text("Our Team",
              //     style: TextStyle(
              //       fontSize: 34,
              //       fontWeight: FontWeight.bold,
              //     )),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //       "BTech TY EXTC Student in K J Somaiya College Of Engineering",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(fontSize: 17)),
              // ),
              // SizedBox(height: 20),
              // _TeamImages()
            ],
          )
        ],
      )),
    );
  }
}

class _TeamImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child:
                              Image.asset('images/maleAvtar.png', width: 200),
                        ),
                        const SizedBox(height: 10),
                        const Text("Krishnakumar Pal"),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child:
                              Image.asset('images/maleAvtar.png', width: 200),
                        ),
                        const SizedBox(height: 10),
                        const Text("Amit Patil"),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child:
                              Image.asset('images/femalAvtar.png', width: 200),
                        ),
                        const SizedBox(height: 10),
                        const Text("Riya Thakkar"),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child:
                              Image.asset('images/maleAvtar.png', width: 200),
                        ),
                        const SizedBox(height: 10),
                        const Text("Abhay"),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
