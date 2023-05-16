import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknikal_test/components/berita/berita_controller.dart';
import 'package:teknikal_test/components/berita/detail_kategori_view.dart';
import 'package:teknikal_test/components/webview/webview_view.dart';
import 'package:teknikal_test/utils/utility.dart';
import 'package:teknikal_test/widget/card_custom.dart';
import 'package:teknikal_test/widget/main_scaffold.dart';
import 'package:teknikal_test/widget/text_label.dart';

class MainKategori extends StatefulWidget {
  @override
  _MainKategoriState createState() => _MainKategoriState();
}

class _MainKategoriState extends State<MainKategori> {
  var controller = Get.put(BeritaController());

  @override
  void initState() {
    // controller.getDataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      type: "default",
      returnOnWillpop: true,
      backFunction: () {},
      content: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Utility.medium,
            ),
            Align(
              alignment: Alignment.center,
              child: TextLabel(
                text: "Category",
                weigh: FontWeight.bold,
                size: Utility.large,
              ),
            ),
            SizedBox(
              height: Utility.large,
            ),
            Flexible(child: tampilanGridView())
          ],
        ),
      ),
    );
  }

  Widget tampilanGridView() {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemCount: controller.kategori.length,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          var nama = controller.kategori[index]['nama'];
          var gambar = controller.kategori[index]['gambar'];
          return InkWell(
            onTap: () {
              Get.to(
                  DetailKategori(
                    nameKategori: "$nama",
                  ),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.rightToLeftWithFade);
            },
            child: Container(
                margin: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 6.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(151, 209, 209, 209),
                  borderRadius: Utility.borderStyle1,
                  image: DecorationImage(
                      image: AssetImage('assets/$gambar'),
                      fit: BoxFit.cover,
                      opacity: 0.5),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: TextLabel(
                    text: nama,
                    weigh: FontWeight.bold,
                    size: Utility.medium,
                  ),
                )),
          );
        });
  }
}
