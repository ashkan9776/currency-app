import 'package:currency_app/data/ApiProvider.dart';

import 'AllCryptoModel.dart';


class CryptoDataRepository {
  var response;
  ApiProvider apiProvider = ApiProvider();
  late AllCryptoModel dataFuture;

  Future<AllCryptoModel> getTopGainerData() async {
    response = await apiProvider.getTopGainerData();
    dataFuture = AllCryptoModel.fromJson(response.data);

    return dataFuture;
  }
}
