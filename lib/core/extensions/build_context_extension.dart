import 'package:flutter/material.dart';

import '../l10n/generated/l10n.dart';
import '../theme/colors_palette.dart';
import '../theme/styles_palette.dart';
import '../theme/theme_style.dart';

extension BuildContextExtension on BuildContext {
  L10n get l10n => L10n.of(this);

  ColorsPalette get colors => Theme.of(this).extension<ThemeStyle>()!.colors;

  StylesPalette get styles => Theme.of(this).extension<ThemeStyle>()!.styles;
}
