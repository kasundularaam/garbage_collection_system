part of 'language_cubit.dart';

abstract class LanguageState {}

class LanguageEnglish extends LanguageState {
  final AppStrings appStrings;

  LanguageEnglish({required this.appStrings});
}

class LanguageSinhala extends LanguageState {
  final AppStrings appStrings;
  LanguageSinhala({required this.appStrings});
}
