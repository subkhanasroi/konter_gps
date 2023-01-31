import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:konter_gps/model/smartphone_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({Key? key, required this.model}) : super(key: key);
  final SmartphoneModel model;

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  SmartphoneModel? _model;
  final _formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = widget.model;
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
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  "Product Detail",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
        body: _buildBody(),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 75,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              height: 50,
              color: HexColor("#FEDB39"),
              onPressed: () => _launchUrl(Uri.parse(
                  'https://wa.me/+6289521629677?text=Apakah Stock ${_model!.nama} masih ada?')),
              child: const Center(
                child: Text(
                  "CHAT OWNER",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildBody() {
    return ListView(
      children: [
        Container(
          color: Colors.grey[100],
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
              child: Image.network(
            _model!.gambar,
            fit: BoxFit.fill,
          )),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _model!.nama,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(_model!.type,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(_model!.warna,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    _formatCurrency.format(_model!.harga),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                _model!.deskripsi,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }
}
