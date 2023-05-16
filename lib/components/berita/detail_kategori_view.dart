import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:teknikal_test/components/berita/berita_controller.dart';
import 'package:teknikal_test/components/berita/spesifik_kategori_view.dart';
import 'package:teknikal_test/utils/utility.dart';
import 'package:teknikal_test/widget/card_custom.dart';
import 'package:teknikal_test/widget/main_scaffold.dart';
import 'package:teknikal_test/widget/text_label.dart';

class DetailKategori extends StatefulWidget {
  String nameKategori;
  DetailKategori({Key? key, required this.nameKategori}) : super(key: key);

  @override
  _DetailKategoriState createState() => _DetailKategoriState();
}

class _DetailKategoriState extends State<DetailKategori> {
  var controller = Get.put(BeritaController());

  @override
  void initState() {
    controller.loadNewsHeadLine(widget.nameKategori);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      type: "default",
      returnOnWillpop: true,
      backFunction: () {},
      content: Obx(
        () => Padding(
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
                  text: widget.nameKategori,
                  weigh: FontWeight.bold,
                  size: Utility.large,
                ),
              ),
              SizedBox(
                height: Utility.extraLarge,
              ),
              Flexible(child: listviewDetailKategori())
            ],
          ),
        ),
      ),
    );
  }

  Widget listviewDetailKategori() {
    return controller.loadData.value && controller.listNewsHeadLine.isEmpty
        ? Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Utility.primaryDefault,
                ),
                SizedBox(
                  height: Utility.verySmall,
                ),
                TextLabel(
                  text: "Loading Data...",
                  weigh: FontWeight.bold,
                )
              ],
            ),
          )
        : !controller.loadData.value && controller.listNewsHeadLine.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLabel(
                      text: "Tidak ada data",
                      weigh: FontWeight.bold,
                    )
                  ],
                ),
              )
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: MaterialClassicHeader(
                  color: Utility.primaryDefault,
                ),
                footer: ClassicFooter(
                  loadingText: "Load More...",
                  noDataText: "Finished loading data",
                  loadStyle: LoadStyle.ShowWhenLoading,
                  loadingIcon: Icon(Iconsax.more),
                ),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  controller.page.value = 10;
                  controller.page.refresh();
                  controller.loadNewsHeadLine(widget.nameKategori);
                  controller.refreshHeadLineNews.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    controller.page.value = controller.page.value + 10;
                    controller.refreshHeadLineNews.loadComplete();
                  });
                },
                controller: controller.refreshHeadLineNews,
                child: ListView.builder(
                    physics: controller.listNewsHeadLine.length <= 5
                        ? AlwaysScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    itemCount: controller.listNewsHeadLine.length >
                            controller.page.value
                        ? controller.page.value
                        : controller.listNewsHeadLine.length,
                    itemBuilder: (context, index) {
                      var id = controller.listNewsHeadLine[index].id;
                      var name = controller.listNewsHeadLine[index].name;
                      var description =
                          controller.listNewsHeadLine[index].description;

                      return InkWell(
                        onTap: () {
                          Get.to(
                              SpesifikKategoriView(
                                spesifikId: "$id",
                              ),
                              duration: const Duration(milliseconds: 300),
                              transition: Transition.rightToLeftWithFade);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextLabel(
                              text: name,
                              weigh: FontWeight.bold,
                              size: Utility.large,
                            ),
                            SizedBox(
                              height: Utility.normal,
                            ),
                            TextLabel(
                              text: description,
                            ),
                            const Divider(),
                            SizedBox(
                              height: Utility.medium,
                            ),
                          ],
                        ),
                      );
                    }));
  }
}
