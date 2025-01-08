import 'package:flutter_test/flutter_test.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/summary/summary.dart';
import 'package:wahl_analytics/src/feature/team/team.dart';

import '../../../../../mock/src/feature/client/domain/use_case/mock_get_business_client_use_case.dart';
import '../../../../../mock/src/feature/contact/domain/use_case/mock_get_business_contact_use_case.dart';
import '../../../../../mock/src/feature/service/domain/use_case/mock_get_business_service_use_case.dart';
import '../../../../../mock/src/feature/summary/domain/use_case/mock_get_business_summary_use_case.dart';
import '../../../../../mock/src/feature/team/domain/use_case/mock_get_business_team_use_case.dart';

void main() {
  late MockGetBusinessClientUseCase mockGetBusinessClientUseCase;
  late MockGetBusinessContactUseCase mockGetBusinessContactUseCase;
  late MockGetBusinessServiceUseCase mockGetBusinessServiceUseCase;
  late MockGetBusinessSummaryUseCase mockGetBusinessSummaryUseCase;
  late MockGetBusinessTeamUseCase mockGetBusinessTeamUseCase;

  late GetHomeContentUseCase getHomeContentUseCase;

  const businessClientEntity = BusinessClientEntity(
    name: 'name',
    title: 'title',
    description: 'description',
    action: 'action',
    clients: [],
  );

  const businessContactEntity = BusinessContactEntity(
    email: 'email',
    mobileNumber: 'mobileNumber',
    address: [],
  );

  const businessServiceEntity = BusinessServiceEntity(
    name: 'name',
    title: 'title',
    description: 'description',
    action: 'action',
    services: [],
  );

  const businessSummaryEntity = BusinessSummaryEntity(
    title: 'title',
    descriptions: [],
    urls: [],
  );

  const businessTeamEntity = BusinessTeamEntity(
    name: 'name',
    title: 'title',
    description: 'description',
    action: 'action',
    members: [],
  );

  setUp(() {
    mockGetBusinessClientUseCase = MockGetBusinessClientUseCase();
    mockGetBusinessContactUseCase = MockGetBusinessContactUseCase();
    mockGetBusinessServiceUseCase = MockGetBusinessServiceUseCase();
    mockGetBusinessSummaryUseCase = MockGetBusinessSummaryUseCase();
    mockGetBusinessTeamUseCase = MockGetBusinessTeamUseCase();

    getHomeContentUseCase = GetHomeContentUseCase(
      mockGetBusinessClientUseCase,
      mockGetBusinessContactUseCase,
      mockGetBusinessServiceUseCase,
      mockGetBusinessSummaryUseCase,
      mockGetBusinessTeamUseCase,
    );
  });

  test(
    'should return a list of HomeContentEntity when all use cases succeed',
    () async {
      mockGetBusinessClientUseCase.mockCallSuccess(businessClientEntity);
      mockGetBusinessContactUseCase.mockCallSuccess(businessContactEntity);
      mockGetBusinessServiceUseCase.mockCallSuccess(businessServiceEntity);
      mockGetBusinessSummaryUseCase.mockCallSuccess(businessSummaryEntity);
      mockGetBusinessTeamUseCase.mockCallSuccess(businessTeamEntity);

      final result = await getHomeContentUseCase();

      expect(result.isRight, isTrue);
      expect(result.right.length, 5);
      expect(result.right[0], isA<HeaderSection>());
      expect(result.right[1], isA<ServiceSection>());
      expect(result.right[2], isA<ClientSection>());
      expect(result.right[3], isA<TeamSection>());
      expect(result.right[4], isA<FooterSection>());
    },
  );

  test(
    'should skip footer content when GetBusinessSummaryUseCase ends with failure',
    () async {
      mockGetBusinessSummaryUseCase.mockCallFailure(
        const BusinessSummaryFailure(),
      );

      mockGetBusinessClientUseCase.mockCallSuccess(businessClientEntity);
      mockGetBusinessContactUseCase.mockCallSuccess(businessContactEntity);
      mockGetBusinessServiceUseCase.mockCallSuccess(businessServiceEntity);
      mockGetBusinessTeamUseCase.mockCallSuccess(businessTeamEntity);

      final result = await getHomeContentUseCase();

      expect(result.isRight, isTrue);
      expect(result.right.length, 4);
      expect(result.right[0], isA<ServiceSection>());
      expect(result.right[1], isA<ClientSection>());
      expect(result.right[2], isA<TeamSection>());
      expect(result.right[3], isA<FooterSection>());
    },
  );

  test(
    'should skip team content when GetBusinessTeamUseCase ends with failure',
    () async {
      mockGetBusinessTeamUseCase.mockCallFailure(const BusinessTeamFailure());

      mockGetBusinessClientUseCase.mockCallSuccess(businessClientEntity);
      mockGetBusinessContactUseCase.mockCallSuccess(businessContactEntity);
      mockGetBusinessServiceUseCase.mockCallSuccess(businessServiceEntity);
      mockGetBusinessSummaryUseCase.mockCallSuccess(businessSummaryEntity);

      final result = await getHomeContentUseCase();

      expect(result.isRight, isTrue);
      expect(result.right.length, 4);
      expect(result.right[0], isA<HeaderSection>());
      expect(result.right[1], isA<ServiceSection>());
      expect(result.right[2], isA<ClientSection>());
      expect(result.right[3], isA<FooterSection>());
    },
  );

  test(
    'should skip service content when GetBusinessServiceUseCase ends with failure',
    () async {
      mockGetBusinessServiceUseCase.mockCallFailure(
        const BusinessServiceFailure(),
      );

      mockGetBusinessClientUseCase.mockCallSuccess(businessClientEntity);
      mockGetBusinessContactUseCase.mockCallSuccess(businessContactEntity);
      mockGetBusinessSummaryUseCase.mockCallSuccess(businessSummaryEntity);
      mockGetBusinessTeamUseCase.mockCallSuccess(businessTeamEntity);

      final result = await getHomeContentUseCase();

      expect(result.isRight, isTrue);
      expect(result.right.length, 4);
      expect(result.right[0], isA<HeaderSection>());
      expect(result.right[1], isA<ClientSection>());
      expect(result.right[2], isA<TeamSection>());
      expect(result.right[3], isA<FooterSection>());
    },
  );

  test(
    'should skip contact content when GetBusinessContactUseCase ends with failure',
    () async {
      mockGetBusinessContactUseCase
          .mockCallFailure(const BusinessContactFailure());

      mockGetBusinessClientUseCase.mockCallSuccess(businessClientEntity);
      mockGetBusinessServiceUseCase.mockCallSuccess(businessServiceEntity);
      mockGetBusinessSummaryUseCase.mockCallSuccess(businessSummaryEntity);
      mockGetBusinessTeamUseCase.mockCallSuccess(businessTeamEntity);

      final result = await getHomeContentUseCase();

      expect(result.isRight, isTrue);
      expect(result.right.length, 4);
      expect(result.right[0], isA<HeaderSection>());
      expect(result.right[1], isA<ServiceSection>());
      expect(result.right[2], isA<ClientSection>());
      expect(result.right[3], isA<TeamSection>());
    },
  );

  test(
    'should skip clients content when GetBusinessClientUseCase ends with failure',
    () async {
      mockGetBusinessClientUseCase
          .mockCallFailure(const BusinessClientFailure());

      mockGetBusinessContactUseCase.mockCallSuccess(businessContactEntity);
      mockGetBusinessServiceUseCase.mockCallSuccess(businessServiceEntity);
      mockGetBusinessSummaryUseCase.mockCallSuccess(businessSummaryEntity);
      mockGetBusinessTeamUseCase.mockCallSuccess(businessTeamEntity);

      final result = await getHomeContentUseCase();

      expect(result.isRight, isTrue);
      expect(result.right.length, 4);
      expect(result.right[0], isA<HeaderSection>());
      expect(result.right[1], isA<ServiceSection>());
      expect(result.right[2], isA<TeamSection>());
      expect(result.right[3], isA<FooterSection>());
    },
  );
}
