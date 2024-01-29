import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Container(
              color: Color.fromARGB(255, 180, 129, 111),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                "Image Caption Generator",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
            centerTitle: true),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/image1.jpg"), fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  // margin: EdgeInsets.all(30),
                  width: 300,
                  height: 350,
                  alignment: Alignment.topCenter,
                  child: Stack(children: <Widget>[
                    Container(
                      width: 300,
                      height: 350,
                      // color: Color.fromARGB(237, 229, 222, 222),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 161, 125, 125),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFF000000),
                          width: 15.0,
                          style: BorderStyle.solid,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 140,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white;
                        }
                        // Return default color
                        return Colors.black;
                      },
                      // end
                    ),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Upload the image",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 1, childAspectRatio: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              index.toString(),
                              style: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                // backgroundColor: Colors.white
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Hat",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                // backgroundColor: Colors.white
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "confidence 90%",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
