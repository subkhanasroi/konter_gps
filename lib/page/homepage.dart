import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:konter_gps/common/icon.dart';
import 'package:konter_gps/common/images.dart';
import 'package:konter_gps/model/smartphone_model.dart';

import 'package:konter_gps/model/type_model.dart';
import 'package:konter_gps/page/device_detail_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<TypeModel> _typeModel;
  late List<SmartphoneModel> _smartphoneModel;

  @override
  void initState() {
    super.initState();
    _smartphoneModel = [
      SmartphoneModel(
          kImgXiaomi, "Xiaomi 12", "8/256", 12000000, "Hape Xiaomi"),
      SmartphoneModel(
          kImgSamsung, "Samsung A 12", "4/256", 2100000, "Hape Samsung"),
      SmartphoneModel(
          kImgIphone, "Iphone 14", "6/256", 14000000, "Hape Iphone"),
      SmartphoneModel(
          kImgXiaomi, "Xiaomi 12", "8/256", 12000000, "Hape Xiaomi"),
      SmartphoneModel(
          kImgSamsung, "Samsung A 12", "4/256", 2100000, "Hape Samsung"),
      SmartphoneModel(
          kImgIphone, "Iphone 14", "6/256", 14000000, "Hape Iphone"),
    ];

    _typeModel = [
      TypeModel(kIcSamsung, "Samsung"),
      TypeModel(kIcAsus, "Asus"),
      TypeModel(kIcIphone, "Apple"),
      TypeModel(kIcRealme, "Realme"),
      TypeModel(kIcXiaomi, "Xiaomi"),
      TypeModel(kIcAdvan, "Advan"),
      TypeModel(kIcOppo, "Oppo"),
      TypeModel(kIcOther, "Other"),
    ];
  }

  void _onDetail(SmartphoneModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DeviceDetailPage(
                  model: model,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    const double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double heightScreen =
        mediaQueryData.size.height - paddingTop - appBarHeight - 200;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 16, left: 16, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hi New Customer !",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "Explore Your Feature Mobile Here",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400]),
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey[300]),
                      contentPadding: const EdgeInsets.only(
                          left: 8, top: 4, bottom: 4, right: 8),
                      hintText: "Search Mobile",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[300]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16),
                      )),
                ),
              ),
              const Expanded(child: Icon(Icons.filter_alt))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Stack(
            children: [
              SizedBox(
                height: 170,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: HexColor("#FEDB39")),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Explore Latest",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Text(
                        "Mobile With Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 30,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            "Explore",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 38,
                bottom: 0,
                child: Image.asset(
                  kImgWoman,
                  scale: 11,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // SizedBox(
          //   height: 100,
          //   child: GridView.builder(
          //       shrinkWrap: true,
          //       primary: true,
          //       scrollDirection: Axis.horizontal,
          //       itemCount: _typeModel.length,
          //       padding: const EdgeInsets.only(right: 16),
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         mainAxisSpacing: 8,
          //         crossAxisCount: 1,
          //       ),
          //       itemBuilder: (BuildContext context, index) {
          //         TypeModel model = _typeModel[index];
          //         return Container(
          //             height: 50,
          //             decoration: BoxDecoration(
          //               color: Colors.grey[100],
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image.asset(
          //                   model.image!,
          //                   scale: 10,
          //                 ),
          //                 Text(model.label!),
          //               ],
          //             ));
          //       }),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          Row(
            children: [
              const Text(
                "The most searched Mobiles",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                "See all",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: HexColor("#FEDB39")),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _smartphoneModel.length,
                padding: const EdgeInsets.only(right: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: widthScreen / heightScreen,
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8),
                itemBuilder: (BuildContext context, index) {
                  SmartphoneModel model = _smartphoneModel[index];
                  return InkWell(
                    onTap: () => _onDetail(_smartphoneModel[index]),
                    child: Stack(
                      children: [
                        Positioned(
                          top: kToolbarHeight,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 135,
                                    child: Image.asset(
                                      model.image!,
                                      fit: BoxFit.fill,
                                    )),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(8),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.name!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        model.type!,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
