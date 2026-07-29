import 'package:craftybay/core/services/llm_model_services.dart';

import '../../../app/urls.dart';

LlmModelServices getModelCaller() {
  return LlmModelServices(
    headers: () {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${Urls.openRouterToken}',
      };

      return headers;
    },
  );
}
