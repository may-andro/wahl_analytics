import 'dart:ui';

import 'package:equatable/equatable.dart';

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

final class OnInitEvent extends LocaleEvent {
  const OnInitEvent();
}

final class UpdateLocaleEvent extends LocaleEvent {
  const UpdateLocaleEvent(this.updatedLocale);

  final Locale updatedLocale;
}

final class LocaleClickEvent extends LocaleEvent {
  const LocaleClickEvent();
}

final class PopupVisibleEvent extends LocaleEvent {
  const PopupVisibleEvent();
}
