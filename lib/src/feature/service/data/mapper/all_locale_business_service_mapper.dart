import 'package:core/core.dart';
import 'package:wahl_analytics/src/feature/service/data/mapper/business_service_mapper.dart';
import 'package:wahl_analytics/src/feature/service/data/model/all_locale_business_service_model.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';

class AllLocaleBusinessServiceMapper
    implements
        BiMapper<
          AllLocaleBusinessServiceModel,
          AllLocaleBusinessServiceEntity
        > {
  AllLocaleBusinessServiceMapper(this._businessServiceMapper);

  final BusinessServiceMapper _businessServiceMapper;

  @override
  AllLocaleBusinessServiceModel from(AllLocaleBusinessServiceEntity from) {
    return AllLocaleBusinessServiceModel(
      en: _businessServiceMapper.from(from.en),
      es: _businessServiceMapper.from(from.es),
      nl: _businessServiceMapper.from(from.nl),
    );
  }

  @override
  AllLocaleBusinessServiceEntity to(AllLocaleBusinessServiceModel from) {
    return AllLocaleBusinessServiceEntity(
      en: _businessServiceMapper.to(from.en),
      es: _businessServiceMapper.to(from.es),
      nl: _businessServiceMapper.to(from.nl),
    );
  }
}
