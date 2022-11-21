import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:konter_gps/common/images.dart';
import 'package:konter_gps/page/homepage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();
    listContentConfig.add(
      ContentConfig(
        title: "Selamat Datang",
        styleTitle: TextStyle(
            color: HexColor("#CBA8FA"),
            fontSize: 24,
            fontWeight: FontWeight.bold),
        styleDescription: TextStyle(color: HexColor("#CBA8FA")),
        pathImage: kImgIntro1,
        description:
            "Jangan bersedih, jika kamu mencari handphone yang sesuai budget, sesuai kriteria yang kamu inginkan belum ketemu",
      ),
    );
    listContentConfig.add(
      ContentConfig(
          pathImage: kImgIntro2,
          styleDescription: TextStyle(color: HexColor("#CBA8FA")),
          description:
              "Ingat selalu ada Konter GPS, Kami menawarkan beberapa solusi masalah kamu"),
    );
    listContentConfig.add(
      ContentConfig(
          pathImage: kImgIntro3,
          styleDescription: TextStyle(color: HexColor("#CBA8FA")),
          description:
              "Kami menyediakan berbagai macam smartphone yang dijamin membuat kamu mudah dalam mencari smartphone impianb "),
    );
  }

  void _onDonePress() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: _onDonePress,
      isShowSkipBtn: false,
      prevButtonStyle: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(HexColor("#CBA8FA"))),
      nextButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
        HexColor("#D6459E"),
      )),
      doneButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
        HexColor("#D6459E"),
      )),
      indicatorConfig: IndicatorConfig(
        sizeIndicator: 5,
        indicatorWidget: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: HexColor("#CBA8FA")),
        ),
        activeIndicatorWidget: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: HexColor("#D6459E")),
        ),
      ),
    );
  }
}
