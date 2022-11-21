import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:konter_gps/common/icon.dart';
import 'package:konter_gps/widget/background_wave_widget.dart';

import 'package:konter_gps/model/type_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<TypeModel> _typeModel;

  @override
  void initState() {
    super.initState();
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
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Image.asset(
                kIcLogo,
                scale: 10,
              ),
            )),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
                hintText: "Search Item",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ))),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: const [
              Text(
                "Choose brand",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                "See all",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 100,
            child: GridView.builder(
                shrinkWrap: true,
                primary: true,
                scrollDirection: Axis.horizontal,
                itemCount: _typeModel.length,
                padding: const EdgeInsets.only(right: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8,
                  crossAxisCount: 1,
                ),
                itemBuilder: (BuildContext context, index) {
                  TypeModel model = _typeModel[index];
                  return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            model.image!,
                            scale: 10,
                          ),
                          Text(model.label!),
                        ],
                      ));
                }),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: const [
              Text(
                "Popular Product",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                "See all",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
