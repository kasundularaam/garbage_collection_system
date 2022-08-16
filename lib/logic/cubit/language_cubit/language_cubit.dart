import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_strings/app_str.dart';
import '../../../core/app_strings/english_str.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageEnglish(appStrings: EnglishStrings()));

  setEnglish() {}

  setSinhala() {}

  loadLanguage() {}
}
