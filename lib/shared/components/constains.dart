

import 'package:social_app/shared/network/local/cache_helper.dart';


void signOut(context) {
  CacheHelper.removeData(
    key: "token",
  ).then((value) {
    if (value) {
      // navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String token = '';

String uId = '';
