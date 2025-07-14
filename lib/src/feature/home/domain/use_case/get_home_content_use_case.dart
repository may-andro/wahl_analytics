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
    if (businessSummaryEither.isLeft) {
      return Left(
        GetHomeContentFailure(
          message: businessSummaryEither.left.message,
          cause: businessSummaryEither.left.cause,
        ),
      );
    }
    homeContentList.add(
      HeaderSection(
        title: businessSummaryEither.right.title,
        descriptions: businessSummaryEither.right.descriptions,
        urls: businessSummaryEither.right.urls,
      ),
    );

    final businessServiceEither = await _getBusinessServiceUseCase();
    if (businessServiceEither.isLeft) {
      return Left(
        GetHomeContentFailure(
          message: businessServiceEither.left.message,
          cause: businessServiceEither.left.cause,
        ),
      );
    }
    homeContentList.add(
      ServiceSection(
        name: businessServiceEither.right.name,
        title: businessServiceEither.right.title,
        description: businessServiceEither.right.description,
        action: businessServiceEither.right.action,
        services: businessServiceEither.right.services,
      ),
    );

    final businessClientEither = await _getBusinessClientUseCase();
    if (businessClientEither.isLeft) {
      return Left(
        GetHomeContentFailure(
          message: businessClientEither.left.message,
          cause: businessClientEither.left.cause,
        ),
      );
    }
    homeContentList.add(
      ClientSection(
        name: businessClientEither.right.name,
        title: businessClientEither.right.title,
        description: businessClientEither.right.description,
        action: businessClientEither.right.action,
        clients: businessClientEither.right.clients,
      ),
    );

    final businessTeamEither = await _getBusinessTeamUseCase();
    if (businessClientEither.isLeft) {
      return Left(
        GetHomeContentFailure(
          message: businessTeamEither.left.message,
          cause: businessTeamEither.left.cause,
        ),
      );
    }
    homeContentList.add(
      TeamSection(
        name: businessTeamEither.right.name,
        title: businessTeamEither.right.title,
        description: businessTeamEither.right.description,
        action: businessTeamEither.right.action,
        members: businessTeamEither.right.members,
      ),
    );

    final businessContactEither = await _getBusinessContactUseCase();
    if (businessContactEither.isLeft) {
      return Left(
        GetHomeContentFailure(
          message: businessContactEither.left.message,
          cause: businessContactEither.left.cause,
        ),
      );
    }
    homeContentList.add(
      FooterSection(
        email: businessContactEither.right.email,
        mobileNumber: businessContactEither.right.mobileNumber,
        address: businessContactEither.right.address,
      ),
    );

    return Right(homeContentList);
  }

  @protected
  @override
  GetHomeContentFailure mapErrorToFailure(Object e, StackTrace st) {
    return GetHomeContentFailure(message: e.toString(), cause: e);
  }
}
