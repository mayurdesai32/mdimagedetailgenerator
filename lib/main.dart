import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late ImagePicker _picker;
  File? _image;
  dynamic imageLabeler;
  // List<Map<String, dynamic>>? result = [];
  List<String>? result = [];
  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);
    imageLabeler = ImageLabeler(options: options);
  }

  @override
  void dispose() {
    super.dispose();
  }

  chooseImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      doImageLabel();
    }
  }

  cameraImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      doImageLabel();
    }
  }

  doImageLabel() async {
    InputImage inputImage = InputImage.fromFile(_image!);

    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    result!.clear();
    for (ImageLabel label in labels) {
      setState(() {
        result!.add(
            "${label.label} :-  confidence ${(label.confidence * 100).toStringAsFixed(0)} %"
            //   {
            //   "text": label.label,
            //   "index": label.index,
            //   "confidence": label.confidence
            // }
            );
      });

      // final double confidence = label.confidence;
    }
    print("*************************");
    print(result);
    print(result?.length);
    print("*************************");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Container(
              color: const Color.fromARGB(255, 180, 129, 111),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                "MDImage Caption",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
            centerTitle: true),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              // gradient:LinearGradient(colors: Colors.white),
              image: DecorationImage(
                  image: AssetImage("asset/image1.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.linearToSrgbGamma()),
            ),
            child: SafeArea(
              child: constraints.maxHeight < constraints.maxWidth
                  ? const Center(
                      child: Text(
                      "You can't veiw in Landscape mode",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ))
                  : Column(
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
                                color: const Color.fromARGB(255, 161, 125, 125),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFF000000),
                                  width: 15.0,
                                  style: BorderStyle.solid,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                ),
                              ),
                            ),
                            _image == null
                                ? const Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 140,
                                      color: Colors.black,
                                    ),
                                  )
                                : Center(
                                    child: Image.file(
                                      _image!,
                                      fit: BoxFit.fill,
                                      width: 268,
                                      height: 318,
                                    ),
                                  ),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
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
                          onPressed: () {
                            chooseImage();
                          },
                          onLongPress: () {
                            cameraImage();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Upload the image",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: _image == null
                              ? const Center(
                                  child: Text(
                                    "Please Upload The Image",
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              : result!.isEmpty
                                  ? const Center(
                                      child: Text("No Caption found",
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center),
                                    )
                                  : ListView.builder(
                                      itemCount: result!.length,
                                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      //     crossAxisCount: 1, childAspectRatio: 2),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0),
                                          child: Text(
                                            // ${label.index.toString()}

                                            "  ${index.toString()}  ${result![index]}",
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        )
                      ],
                    ),
            ),
          );
        }),
      ),
    );
  }
}
