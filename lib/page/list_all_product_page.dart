import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:konter_gps/data/request.dart';
import 'package:konter_gps/model/smartphone_model.dart';
import 'package:dio/dio.dart' as dio;

import 'device_detail_page.dart';

class ListAllPage extends StatefulWidget {
  const ListAllPage({Key? key}) : super(key: key);

  @override
  State<ListAllPage> createState() => _ListAllPageState();
}

class _ListAllPageState extends State<ListAllPage> {
  late List<SmartphoneModel> _smartphoneModel;
  late Future _future;
  late Request _request;
  late int _page;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              "List All Smartphone",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black),
            ),
          )),
      body: _buildBody(),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 40,
        margin: const EdgeInsets.all(16),
        child: Pagination(
          width: MediaQuery.of(context).size.width * .6,
          paginateButtonStyles: PaginateButtonStyles(
              backgroundColor: HexColor("#FEDB39"),
              activeBackgroundColor: HexColor("#1CD6CE")),
          prevButtonStyles: PaginateSkipButton(
              buttonBackgroundColor: HexColor("#293462"),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          nextButtonStyles: PaginateSkipButton(
              buttonBackgroundColor: HexColor("#293462"),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          onPageChange: (number) {
            setState(() {
              _page = number;
              _future = _request.gpsCell.catalog.listCatalog(page: _page);
            });
          },
          useGroup: true,
          totalPage: 30,
          show: 4,
          currentPage: _page,
        ),
      ),
    );
  }

  Widget _buildBody() {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    const double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double heightScreen =
        mediaQueryData.size.height - paddingTop - appBarHeight - 200;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
                    return const Center(
                      child: Text("No Data"),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
