import 'dart:async';

import 'package:currency_app/data/ApiProvider.dart';
import 'package:currency_app/data/CryptoDataRepository.dart';
import 'package:flutter/cupertino.dart';
import '../data/AllCryptoModel.dart';
import '../data/ResponseModel.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  CryptoDataRepository repository = CryptoDataRepository();

  getAllMarketCapData() async {
    state = ResponseModel.loading("is Loading...");

    try {
      response = await apiProvider.getAllCryptoData();

      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something wrong...");
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

  getTopMarketCapData() async {
    state = ResponseModel.loading("is Loading...");

    try {
      response = await apiProvider.getTopMarketCapData();

      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something wrong...");
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = ResponseModel.loading("is Loading...");

    try {
      dataFuture = await repository.getTopGainerData();
      state = ResponseModel.completed(dataFuture);
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

  getTopLosersData() async {
    state = ResponseModel.loading("is Loading...");

    try {
      response = await apiProvider.getTopLosersData();

      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something wrong...");
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }
}
