import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';

extension ContextExtension on BuildContext {
  ServicesUpdateBloc get bloc => read<ServicesUpdateBloc>();

  ServicesUpdateState get state => bloc.state;

  ServiceUpdateBloc get serviceUpdateBloc => read<ServiceUpdateBloc>();

  ServiceUpdateState get serviceUpdateState => serviceUpdateBloc.state;
}
