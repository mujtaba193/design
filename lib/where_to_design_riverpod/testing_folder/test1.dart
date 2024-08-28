import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getAddressFromLatLng(double lat, double lng) async {
  final apiKey = '04188329-577f-4a62-bdc9-59ba584b8451';
  final url =
      'https://geocode-maps.yandex.ru/1.x/?apikey=$apiKey&geocode=$lng,$lat&format=json';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(response.body); // Print the full response to debug
    final String address = data['response']['GeoObjectCollection']
            ['featureMember'][0]['GeoObject']['metaDataProperty']
        ['GeocoderMetaData']['text'];
    return address;
  } else {
    print('Error: ${response.statusCode}');
    return 'No address found';
  }
}

// Example usage:
void main() async {
  double latitude = 55.755814;
  double longitude = 37.617635;

  String address = await getAddressFromLatLng(latitude, longitude);
  print('Address: $address');
}
