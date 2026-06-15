import "../core/constants/api_constants.dart";
import "user_model.dart";

class ReportModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String image;
  final String location;
  final String status;
  final DateTime createdAt;
  final UserModel? user;

  const ReportModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.status,
    required this.createdAt,
    this.user,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String? ?? '',
      location: json['location'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  String get imageUrl {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }

    return '${ApiConstants.baseUrl}$image';
  }

  String get statusLabel {
    switch (status) {
      case 'PENDING':
        return 'Pending';
      case 'PROCESS':
        return 'Diproses';
      case 'DONE':
        return 'Selesai';
      default:
        return status;
    }
  }
}

