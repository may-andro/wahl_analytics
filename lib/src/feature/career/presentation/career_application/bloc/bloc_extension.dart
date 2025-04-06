import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/bloc/career_application_bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/bloc/career_application_state.dart';

extension ContextExtension on BuildContext {
  CareerApplicationBloc get bloc => read<CareerApplicationBloc>();

  CareerApplicationState get state => bloc.state;
}
