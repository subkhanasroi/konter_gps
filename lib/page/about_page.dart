import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:konter_gps/common/images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/icon.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late List _galeryGps;

  @override
  void initState() {
    super.initState();
    _galeryGps = [
      kImg1,
      kImg2,
      kImg3,
      kImg4,
      kImg5,
      kImg6,
      kImg7,
      kImg8,
      kImg9,
      kImg10,
      kImg11,
      kImg12,
      kImg13,
    ];
  }

  Future _launchUrl(Uri url) async {
    if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 2,
                    )
                  ],
                  image: const DecorationImage(
                      image: AssetImage(kIcLogoGps), fit: BoxFit.contain)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () => _launchUrl(
                      Uri.parse('https://goo.gl/maps/Fc3jnNiU8HLzrXug7')),
                  color: HexColor("#FEDB39"),
                  child: const Center(
                      child: Text(
                    "MAPS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () => _launchUrl(Uri.parse(
                      'https://wa.me/+6289521629677?text=Halo selamat pagi saya mau bertanya,')),
                  color: HexColor("#FEDB39"),
                  child: const Center(
                      child: Text(
                    "Whatsapp",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
            ],
          ),
          const SizedBox(height: 8),
          Icon(
            Icons.person_outline_outlined,
            color: HexColor("#FEDB39"),
            size: 40,
          ),
          const Center(
              child: Text(
            "Bambang Prayogo",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          const Text(
            "Galeri",
            style: TextStyle(fontSize: 24),
          ),
          Expanded(
            child: MasonryGridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 6,
              itemCount: _galeryGps.length,
              itemBuilder: (context, index) {
                return _galeryContent(_galeryGps[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _galeryContent(String img) {
    return Container(
      child: Image.asset(
        img,
        fit: BoxFit.fill,
      ),
    );
  }
}
