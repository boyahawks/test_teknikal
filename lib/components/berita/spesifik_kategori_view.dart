import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:teknikal_test/components/berita/berita_controller.dart';
import 'package:teknikal_test/components/webview/webview_view.dart';
import 'package:teknikal_test/utils/utility.dart';
import 'package:teknikal_test/widget/card_custom.dart';
import 'package:teknikal_test/widget/main_scaffold.dart';
import 'package:teknikal_test/widget/text_label.dart';

class SpesifikKategoriView extends StatefulWidget {
  String spesifikId;
  SpesifikKategoriView({Key? key, required this.spesifikId}) : super(key: key);

  @override
  _SpesifikKategoriViewState createState() => _SpesifikKategoriViewState();
}

class _SpesifikKategoriViewState extends State<SpesifikKategoriView> {
  var controller = Get.put(BeritaController());

  @override
  void initState() {
    controller.loadNewsDetail(widget.spesifikId);
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
                  text: controller.nameSpesifik.value,
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
    return controller.loadDataDetail.value && controller.listNewsDetail.isEmpty
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
        : !controller.loadDataDetail.value && controller.listNewsDetail.isEmpty
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
                  controller.loadNewsDetail(widget.spesifikId);
                  controller.refreshDetailNews.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    controller.page.value = controller.page.value + 10;
                    controller.refreshDetailNews.loadComplete();
                  });
                },
                controller: controller.refreshDetailNews,
                child: ListView.builder(
                    physics: controller.listNewsDetail.length <= 5
                        ? AlwaysScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    itemCount:
                        controller.listNewsDetail.length > controller.page.value
                            ? controller.page.value
                            : controller.listNewsDetail.length,
                    itemBuilder: (context, index) {
                      var author = controller.listNewsDetail[index].author;
                      var title = controller.listNewsDetail[index].title;
                      var description =
                          controller.listNewsDetail[index].description;
                      var url = controller.listNewsDetail[index].url;
                      var urlToImage =
                          controller.listNewsDetail[index].urlToImage;
                      var publishedAt =
                          controller.listNewsDetail[index].publishedAt;

                      return GestureDetector(
                        onTap: () => Get.to(WebViewContentNews(
                          urlNew: url!,
                          title: title,
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              151, 209, 209, 209),
                                          borderRadius: Utility.borderStyle1,
                                          image: DecorationImage(
                                            image: NetworkImage(urlToImage!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 75,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextLabel(
                                              text:
                                                  Utility.limitText(title!, 50),
                                              weigh: FontWeight.bold,
                                              size: Utility.medium,
                                            ),
                                            SizedBox(
                                              height: Utility.verySmall,
                                            ),
                                            TextLabel(
                                              text: Utility.limitText(
                                                  description!, 100),
                                            ),
                                            SizedBox(
                                              height: Utility.verySmall,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextLabel(
                                                text: "$author, $publishedAt",
                                                size: Utility.verySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
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
