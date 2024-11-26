import 'end_address_model.dart';
import 'start_address_model.dart';

class TicketApplicationModel {
  final String id;
  final String name;
  final int guests;
  final List<String> photos;
  final StartAddressModel startAddress;
  final DestinationAddressModel destination;
  final double price;
  DateTime startTime;
  DateTime endTime;
  final String status;
  int? rating;

  TicketApplicationModel({
    required this.id,
    required this.name,
    required this.guests,
    required this.photos,
    required this.startAddress,
    required this.destination,
    required this.price,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.rating,
  });
  factory TicketApplicationModel.fromJson(Map<String, dynamic> json) {
    return TicketApplicationModel(
        id: json['id'],
        name: json['name'],
        guests: json['guests'],
        photos: List<String>.from(json['photos']),
        startAddress: StartAddressModel.fromJson(json['start_address']),
        destination:
            DestinationAddressModel.fromJson(json['destination_address']),
        price: json['price'].toDouble(),
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
        status: json['status'],
        rating: json['rating']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'guests': guests,
      'photos': photos,
      'start_address': startAddress,
      'destination_address': destination,
      'price': price,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'status': status,
      'rating': rating,
    };
  }
}
