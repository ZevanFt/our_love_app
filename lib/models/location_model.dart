import 'dart:convert';

// Helper function to decode the main object
LocationResponse locationResponseFromJson(String str) =>
    LocationResponse.fromJson(json.decode(str));

// Main response object
class LocationResponse {
  final AddressComponent addressComponent;
  final String formattedAddress;

  LocationResponse({
    required this.addressComponent,
    required this.formattedAddress,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        addressComponent: AddressComponent.fromJson(json["addressComponent"]),
        formattedAddress: json["formatted_address"],
      );
}

// Address component object
class AddressComponent {
  final String city;
  final String province;
  final String adcode;
  final String district;
  final String towncode;
  final StreetNumber streetNumber;
  final String country;
  final String township;
  final String citycode;

  AddressComponent({
    required this.city,
    required this.province,
    required this.adcode,
    required this.district,
    required this.towncode,
    required this.streetNumber,
    required this.country,
    required this.township,
    required this.citycode,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    // Helper to safely get a string, defaulting to empty string if the value is not a string (e.g., an empty list []).
    String safeGetString(dynamic value) => value is String ? value : '';

    return AddressComponent(
      city: safeGetString(json["city"]),
      province: safeGetString(json["province"]),
      adcode: safeGetString(json["adcode"]),
      district: safeGetString(json["district"]),
      towncode: safeGetString(json["towncode"]),
      // A further improvement would be to also safely handle streetNumber if it can be non-Map.
      streetNumber: json["streetNumber"] is Map<String, dynamic>
          ? StreetNumber.fromJson(json["streetNumber"])
          : StreetNumber.fromJson({
              "number": "",
              "location": "",
              "direction": "",
              "distance": "",
              "street": "",
            }),
      country: safeGetString(json["country"]),
      township: safeGetString(json["township"]),
      citycode: safeGetString(json["citycode"]),
    );
  }
}

// Street number object
class StreetNumber {
  final String number;
  final String location;
  final String direction;
  final String distance;
  final String street;

  StreetNumber({
    required this.number,
    required this.location,
    required this.direction,
    required this.distance,
    required this.street,
  });

  factory StreetNumber.fromJson(Map<String, dynamic> json) => StreetNumber(
    number: json["number"],
    location: json["location"],
    direction: json["direction"],
    distance: json["distance"],
    street: json["street"],
  );
}
