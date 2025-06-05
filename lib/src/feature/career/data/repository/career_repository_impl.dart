import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:recase/recase.dart';
import 'package:wahl_analytics/src/feature/career/data/mapper/mapper.dart';
import 'package:wahl_analytics/src/feature/career/data/model/model.dart';
import 'package:wahl_analytics/src/feature/career/domain/domain.dart';

const _collectionName = 'career';

class CareerRepositoryImpl implements CareerRepository {
  CareerRepositoryImpl(
    this._buildConfig,
    this._storageController,
    this._firestoreController,
    this._careerApplicationMapper,
    this._careerMapper,
  );

  final BuildConfig _buildConfig;
  final FbStorageController _storageController;
  final FbFirestoreController _firestoreController;
  final CareerApplicationMapper _careerApplicationMapper;
  final CareerMapper _careerMapper;

  @override
  Future<void> submitCareerApplication(
    CareerApplicationEntity careerApplicationEntity,
  ) async {
    try {
      final fileName =
          '${careerApplicationEntity.name.snakeCase.toLowerCase()}_${DateTime.now().millisecondsSinceEpoch}';
      final fileNameWithExtension = '$fileName.pdf';
      final resumeUrl = await uploadResume(
        fileNameWithExtension,
        careerApplicationEntity.fileData,
      );
      final dataMap = _careerApplicationMapper
          .map(
            careerApplicationEntity,
          )
          .copyWith(
            resumeName: fileNameWithExtension,
            resumeUrl: resumeUrl,
          )
          .toJson();

      return _firestoreController.addDocumentToCollection(
        collectionPath: _collectionName,
        documentPath: fileNameWithExtension,
        data: dataMap,
      );
    } catch (_) {
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

  @override
  Future<List<CareerEntity>> getCareersRequest() async {
    try {
      final dataMaps = await _firestoreController.getCollectionQuerySnapshot(
        _collectionName,
        field: 'env',
        isEqualTo: _buildConfig.buildEnvironment.name,
      );

      return dataMaps
          .map((map) => _careerMapper.to(CareerModel.fromJson(map)))
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCareerRequest(CareerEntity careerEntity) {
    try {
      return _firestoreController.deleteDocumentFromCollection(
        collectionPath: _collectionName,
        documentPath: careerEntity.resumeName,
      );
    } catch (_) {
      rethrow;
    }
  }
}
