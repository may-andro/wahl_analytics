import 'package:flutter/cupertino.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/feature_flag.dart';

extension FeatureFlagBlocExtension on BuildContext {
  FeatureFlagBloc get bloc => read<FeatureFlagBloc>();
}
