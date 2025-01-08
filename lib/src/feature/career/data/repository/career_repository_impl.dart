import 'package:firebase/firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:wahl_analytics/src/feature/career/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

class CareerRepositoryImpl implements CareerRepository {
  CareerRepositoryImpl(
    this._storageController,
    this._firestoreController,
    this._careerMapper,
  );

  final FbStorageController _storageController;
  final FbFirestoreController _firestoreController;
  final CareerMapper _careerMapper;

  @override
  Future<void> submitCareerApplication(CareerEntity careerEntity) async {
    try {
      final resumeUrl = await uploadResume(
        '${careerEntity.name.toLowerCase()}_${DateTime.now().millisecondsSinceEpoch}.pdf',
        careerEntity.fileData,
      );
      final model = _careerMapper.map(careerEntity);

      return _firestoreController.addToCollection(
        'career',
        model.copyWith(resumeUrl: resumeUrl).toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadResume(String finalName, Uint8List data) {
    try {
      return _storageController.uploadRawDocument(finalName, data);
    } catch (e, st) {
      if (e is FireStorageException) {
        throw UploadDocumentFailureException(e, st);
      }
      throw UnknownCareerException(e, st);
    }
  }
}
