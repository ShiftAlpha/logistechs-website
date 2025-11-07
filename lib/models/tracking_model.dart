// Tracking Models for parcel tracking feature

class TrackingStatus {
  final String statusName;
  final DateTime timestamp;
  final String location;
  final String locationCode;
  final bool isCompleted;

  TrackingStatus({
    required this.statusName,
    required this.timestamp,
    required this.location,
    required this.locationCode,
    required this.isCompleted,
  });
}

class ParcelDetails {
  final String waybillNumber;
  final String senderName;
  final String senderLocation;
  final String senderLocationCode;
  final String receiverName;
  final String receiverLocation;
  final String receiverLocationCode;
  final DateTime predictedArrival;
  final List<TrackingStatus> statuses;

  ParcelDetails({
    required this.waybillNumber,
    required this.senderName,
    required this.senderLocation,
    required this.senderLocationCode,
    required this.receiverName,
    required this.receiverLocation,
    required this.receiverLocationCode,
    required this.predictedArrival,
    required this.statuses,
  });
}

// Mock data for demonstration
class MockTrackingData {
  static ParcelDetails getMockParcel(String waybillNumber) {
    return ParcelDetails(
      waybillNumber: waybillNumber,
      senderName: 'TSHIP HAULAGE ANDSHINE',
      senderLocation: 'PEP GERMISTON GOLDENWALK',
      senderLocationCode: 'PB660',
      receiverName: 'PEP CELL OSHIMBI SHOPPING CENTRE',
      receiverLocation: 'PEP CELL OSHIMBI SHOPPING CENTRE',
      receiverLocationCode: 'P4844',
      predictedArrival: DateTime(2022, 11, 13, 14, 30),
      statuses: [
        TrackingStatus(
          statusName: 'PARCEL CLAIM',
          timestamp: DateTime(2022, 11, 7, 3, 26),
          location: 'PEP GERMISTON GOLDENWALK',
          locationCode: 'PB660',
          isCompleted: true,
        ),
        TrackingStatus(
          statusName: 'PARCEL COLLECTED BY COURIER FROM PB660 PEP GERMISTON GOLDENWALK',
          timestamp: DateTime(2022, 11, 7, 4, 53),
          location: 'PEP GERMISTON GOLDENWALK',
          locationCode: 'PB660',
          isCompleted: true,
        ),
        TrackingStatus(
          statusName: 'PARCEL ARRIVED AT COURIER JOHANNESBURG HUB',
          timestamp: DateTime(2022, 11, 7, 7, 58),
          location: 'JOHANNESBURG HUB',
          locationCode: 'JNB001',
          isCompleted: true,
        ),
        TrackingStatus(
          statusName: 'PARCEL DEPARTED FROM COURIER JOHANNESBURG HUB',
          timestamp: DateTime(2022, 11, 7, 10, 50),
          location: 'JOHANNESBURG HUB',
          locationCode: 'JNB001',
          isCompleted: true,
        ),
        TrackingStatus(
          statusName: 'IN TRANSIT',
          timestamp: DateTime(2022, 11, 7, 10, 50),
          location: 'EN ROUTE',
          locationCode: 'TRANSIT',
          isCompleted: false,
        ),
      ],
    );
  }
}
