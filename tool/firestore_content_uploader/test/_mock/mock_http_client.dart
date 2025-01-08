import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {
  void mockGetOK(String expectedBody, String url) {
    when(() => get(Uri.parse(url))).thenAnswer(
      (_) async => http.Response(expectedBody, 200),
    );
  }

  void mockPatchOK(String url, Map<String, String> header, String body) {
    when(() => patch(Uri.parse(url), headers: header, body: body)).thenAnswer(
      (_) async => http.Response('OK', 200),
    );
  }

  void mockPatchBadRequest(
    String url,
    Map<String, String> header,
    String body,
  ) {
    when(() => patch(Uri.parse(url), headers: header, body: body)).thenAnswer(
      (_) async => http.Response('Bad Request', 400),
    );
  }

  void mockPatchFailure(
    Exception expected,
    String url,
    Map<String, String> header,
    String body,
  ) {
    when(() => patch(Uri.parse(url), headers: header, body: body))
        .thenThrow(expected);
  }
}
