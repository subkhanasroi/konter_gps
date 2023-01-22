import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:konter_gps/common/images.dart';
import 'package:konter_gps/data/request.dart';
import 'package:konter_gps/model/smartphone_model.dart';

import 'package:konter_gps/page/device_detail_page.dart';
import 'package:dio/dio.dart' as dio;
import 'package:konter_gps/page/list_all_product_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<SmartphoneModel> _smartphoneModel;
  late List<SmartphoneModel> _result;
  late bool _search;
  late TextEditingController _textEditingController;
  late Future _future;
  late Request _request;
  late int _page;

  @override
  void initState() {
    super.initState();
    _search = false;
    _textEditingController = TextEditingController();
    _page = 1;
    _request = Request();
    _future = _request.gpsCell.catalog.listCatalog(page: _page);
  }

  void _onDetail(SmartphoneModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DeviceDetailPage(
                  model: model,
                )));
  }

  void _seeAll() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListAllPage()));
  }

  void _filterSearchResult(String query) {
    if (query.isEmpty) {
      setState(() {
        _result = _smartphoneModel;
      });
    } else {
      setState(() {
        _result = _smartphoneModel
            .where((result) => result.nama.contains(query))
            .toList();
      });
    }
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
        body: _search ? _searchView() : _buildBody(context),
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
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 0),
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
                  onTap: () {
                    setState(() {
                      _search = !_search;
                    });
                  },
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
              InkWell(
                onTap: () => _seeAll(),
                child: Text(
                  "See all",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HexColor("#FEDB39")),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return const SpinKitPouringHourGlassRefined(
                      color: Colors.yellow,
                      size: 64,
                    );
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      dio.Response res = snapshot.data as dio.Response;
                      _smartphoneModel = List<SmartphoneModel>.from(res
                          .data["data"]["data"]
                          .map((x) => SmartphoneModel.fromJson(x)));
                      return GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _smartphoneModel.length,
                          padding: const EdgeInsets.only(right: 16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: widthScreen / heightScreen,
                                  mainAxisSpacing: 8,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8),
                          itemBuilder: (BuildContext context, index) {
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
                                              child: Image.network(
                                                _smartphoneModel[index].gambar,
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(8),
                                            height: 60,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _smartphoneModel[index].nama,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  _smartphoneModel[index].type,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            );
                          });
                    }
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _textEditingController,
            onChanged: (value) {
              _filterSearchResult(value);
            },
            decoration: InputDecoration(
                suffixIcon: _textEditingController.text.isEmpty
                    ? null
                    : InkWell(
                        onTap: () {
                          setState(() {
                            _textEditingController.clear();
                            _result = _smartphoneModel;
                          });
                        },
                        child: Icon(Icons.delete, color: Colors.grey[300]),
                      ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[300]),
                contentPadding:
                    const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
                hintText: "Search Mobile Device",
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
          const SizedBox(
            height: 8,
          ),
          _textEditingController.text.isEmpty
              ? Column(
                  children: [
                    const Text("no data view"),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _search = false;
                        });
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                      ),
                    ),
                  ],
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: _result.length,
                  itemBuilder: (context, index) {
                    String? name = _result[index].nama;
                    String? cName = name.replaceAll(_textEditingController.text,
                        "#${_textEditingController.text}");
                    List<String> sss = cName.split("#");
                    List<TextSpan> children = [];
                    for (var result in sss) {
                      children.add(TextSpan(
                        text: result,
                        style: const TextStyle(color: Colors.black),
                      ));
                    }
                    print(jsonEncode(sss));
                    return Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                              height: 100,
                              width: 75,
                              child: Image.network(
                                _smartphoneModel[index].gambar,
                                fit: BoxFit.fill,
                              )),
                          title: RichText(text: TextSpan(children: children)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    );
                  },
                )),
          _textEditingController.text.isNotEmpty
              ? MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: HexColor("#FEDB39"),
                  onPressed: () {
                    setState(() {
                      _search = false;
                      _textEditingController.clear();
                    });
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
