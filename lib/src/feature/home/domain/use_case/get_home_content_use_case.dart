import 'dart:async';

import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/summary/summary.dart';
import 'package:wahl_analytics/src/feature/team/team.dart';

class GetHomeContentFailure extends BasicFailure {
  const GetHomeContentFailure({super.message, super.cause});
}

class GetHomeContentUseCase
    extends BaseNoParamUseCase<List<HomeContentEntity>, GetHomeContentFailure> {
  GetHomeContentUseCase(
    this._getBusinessClientUseCase,
    this._getBusinessContactUseCase,
    this._getBusinessServiceUseCase,
    this._getBusinessSummaryUseCase,
    this._getBusinessTeamUseCase,
  );

  final GetBusinessClientUseCase _getBusinessClientUseCase;
  final GetBusinessContactUseCase _getBusinessContactUseCase;
  final GetBusinessServiceUseCase _getBusinessServiceUseCase;
  final GetBusinessSummaryUseCase _getBusinessSummaryUseCase;
  final GetBusinessTeamUseCase _getBusinessTeamUseCase;

  @protected
  @override
  Future<Either<GetHomeContentFailure, List<HomeContentEntity>>>
      execute() async {
    final homeContentList = <HomeContentEntity>[];

    final businessSummaryEither = await _getBusinessSummaryUseCase();
    businessSummaryEither.fold(
      (failure) {
        return GetHomeContentFailure(
          message: failure.message,
          cause: failure.cause,
        );
      },
      (businessSummary) {
        homeContentList.add(
          HeaderSection(
            title: businessSummary.title,
            descriptions: businessSummary.descriptions,
            urls: businessSummary.urls,
          ),
        );
      },
    );

    final businessServiceEither = await _getBusinessServiceUseCase();
    businessServiceEither.fold(
      (failure) {
        return GetHomeContentFailure(
          message: failure.message,
          cause: failure.cause,
        );
      },
      (businessService) {
        homeContentList.add(
          ServiceSection(
            name: businessService.name,
            title: businessService.title,
            description: businessService.description,
            action: businessService.action,
            services: businessService.services,
          ),
        );
      },
    );

    final businessClientEither = await _getBusinessClientUseCase();
    businessClientEither.fold(
      (failure) {
        return GetHomeContentFailure(
          message: failure.message,
          cause: failure.cause,
        );
      },
      (businessClient) {
        homeContentList.add(
          ClientSection(
            name: businessClient.name,
            title: businessClient.title,
            description: businessClient.description,
            action: businessClient.action,
            clients: businessClient.clients,
          ),
        );
      },
    );

    final businessTeamEither = await _getBusinessTeamUseCase();
    businessTeamEither.fold(
      (failure) {
        return GetHomeContentFailure(
          message: failure.message,
          cause: failure.cause,
        );
      },
      (businessTeam) {
        homeContentList.add(
          TeamSection(
            name: businessTeam.name,
            title: businessTeam.title,
            description: businessTeam.description,
            action: businessTeam.action,
            members: businessTeam.members,
          ),
        );
      },
    );

    final businessContactEither = await _getBusinessContactUseCase();
    businessContactEither.fold(
      (failure) {
        return GetHomeContentFailure(
          message: failure.message,
          cause: failure.cause,
        );
      },
      (businessContact) {
        homeContentList.add(
          FooterSection(
            email: businessContact.email,
            mobileNumber: businessContact.mobileNumber,
            address: businessContact.address,
          ),
        );
      },
    );

    return Right(homeContentList);
  }

  @protected
  @override
  GetHomeContentFailure mapErrorToFailure(Object e, StackTrace st) {
    return GetHomeContentFailure(message: e.toString(), cause: e);
  }
}
