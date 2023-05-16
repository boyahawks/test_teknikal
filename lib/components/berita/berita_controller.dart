import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:teknikal_test/components/berita/berita_model.dart';
import 'package:teknikal_test/utils/api.dart';
import 'package:teknikal_test/utils/toast.dart';
import 'package:teknikal_test/utils/utility.dart';

class BeritaController extends GetxController {
  RefreshController refreshHeadLineNews =
      RefreshController(initialRefresh: false);
  RefreshController refreshDetailNews =
      RefreshController(initialRefresh: false);

  var kategori = [
    {
      "id": 1,
      "nama": "Business",
      "gambar": "bisnis.jpeg",
    },
    {
      "id": 2,
      "nama": "Entertainment",
      "gambar": "entertainment.jpeg",
    },
    {
      "id": 3,
      "nama": "General",
      "gambar": "general.jpeg",
    },
    {
      "id": 4,
      "nama": "Health",
      "gambar": "healt.jpeg",
    },
    {
      "id": 5,
      "nama": "Science",
      "gambar": "science.jpeg",
    },
    {
      "id": 6,
      "nama": "Sports",
      "gambar": "sport.jpeg",
    },
    {
      "id": 7,
      "nama": "Technology",
      "gambar": "teknologi.jpeg",
    },
  ];

  var listNewsHeadLine = <DetailKategoriModel>[].obs;
  var listNewsDetail = <SpesifikKategoriModel>[].obs;

  var loadData = false.obs;
  var loadDataDetail = false.obs;
  var nameSpesifik = "".obs;

  var page = 10.obs;

  void loadNewsHeadLine(String namaKategori) async {
    listNewsHeadLine.clear();
    listNewsHeadLine.refresh();
    loadData.value = true;
    loadData.refresh();
    var connect = Api.connectionApi("get", "",
        "top-headlines/sources?category=$namaKategori&apiKey=${Utility.apiKey}");
    var getValue = await connect;
    var valueBody = jsonDecode(getValue.body);
    if (valueBody["status"] == "ok") {
      List<DetailKategoriModel> tampung = [];
      for (var element in valueBody["sources"]) {
        tampung.add(DetailKategoriModel(
          id: element['id'] ?? "",
          name: element['name'] ?? "",
          description: element['description'] ?? "",
        ));
      }
      listNewsHeadLine.value = tampung;
      listNewsHeadLine.refresh();
      loadData.value = false;
      loadData.refresh();
    } else {
      Get.back();
      UtilsAlert.showToast(valueBody["message"]);
    }
  }

  void loadNewsDetail(String speskId) async {
    listNewsDetail.clear();
    listNewsDetail.refresh();
    loadDataDetail.value = true;
    loadDataDetail.refresh();
    var connect = Api.connectionApi(
        "get", "", "top-headlines?sources=$speskId&apiKey=${Utility.apiKey}");
    var getValue = await connect;
    var valueBody = jsonDecode(getValue.body);
    if (valueBody["status"] == "ok") {
      List<SpesifikKategoriModel> tampung = [];
      for (var element in valueBody["articles"]) {
        nameSpesifik.value = element["source"]["name"];
        nameSpesifik.refresh();
        if (element['url'] != null || element['url'] != "") {
          tampung.add(SpesifikKategoriModel(
            author: element['author'] ?? "",
            title: element['title'] ?? "",
            description: element['description'] ?? "",
            url: element['url'] ?? "",
            urlToImage: element['urlToImage'] ?? "",
            publishedAt: DateFormat("dd MMMM yyyy")
                .format(DateTime.parse(element['publishedAt'])),
          ));
        }
      }
      listNewsDetail.value = tampung;
      listNewsDetail.refresh();
      loadDataDetail.value = false;
      loadDataDetail.refresh();
    } else {
      Get.back();
      UtilsAlert.showToast(valueBody["message"]);
    }
  }
}
