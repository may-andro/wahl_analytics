import 'package:equatable/equatable.dart';
import 'package:feature_flag/feature_flag.dart';

class FeatureFlag extends Equatable {
  const FeatureFlag(this.feature, this.isEnabled);

  final Feature feature;
  final bool isEnabled;

  @override
  List<Object?> get props => [feature, isEnabled];
}
