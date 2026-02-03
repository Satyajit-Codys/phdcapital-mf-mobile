import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';

class AppIcons {
  AppIcons._();

  // --------------------------------------------------
  // BASE PATH
  // --------------------------------------------------

  static const String _base = "assets/icons/";

  // --------------------------------------------------
  // ICON PATHS
  // --------------------------------------------------

  static const String arrowDown = "${_base}arrow_down_icon.svg";
  static const String arrowLeft = "${_base}arrow_left_icon.svg";
  static const String calendar = "${_base}calendar_icon.svg";
  static const String close = "${_base}close_icon.svg";
  static const String filter = "${_base}filter_icon.svg";
  static const String hide = "${_base}hide_icon.svg";
  static const String pending = "${_base}pending_icon.svg";
  static const String search = "${_base}search_icon.svg";
  static const String show = "${_base}show_icon.svg";
  static const String sort = "${_base}sort_icon.svg";

  // -------- Color Icons --------

  static const String doneColor = "${_base}done_color_icon.svg";
  static const String educationColor = "${_base}education_color_icon.svg";
  static const String failedColor = "${_base}failed_color_icon.svg";
  static const String homeColor = "${_base}home_color_icon.svg";
  static const String loaderColor = "${_base}loader_color_icon.svg";
  static const String personColor = "${_base}person_color_icon.svg";
  static const String starColor = "${_base}star_color_icon.svg";
  static const String travelColor = "${_base}travel_color_icon.svg";
  static const String weddingColor = "${_base}wedding_color_icon.svg";

  // --------------------------------------------------
  // GENERIC SVG LOADER
  // --------------------------------------------------

  static Widget svg(String asset, {double size = 20, Color? color}) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  // --------------------------------------------------
  // READY TO USE ICONS (MONO)
  // --------------------------------------------------

  static Widget arrowDownIcon({double size = 20, Color? color}) =>
      svg(arrowDown, size: size, color: color);

  static Widget arrowLeftIcon({double size = 20, Color? color}) =>
      svg(arrowLeft, size: size, color: color);

  static Widget calendarIcon({double size = 20, Color? color}) =>
      svg(calendar, size: size, color: color);

  static Widget closeIcon({double size = 20, Color? color}) =>
      svg(close, size: size, color: color);

  static Widget filterIcon({double size = 20, Color? color}) =>
      svg(filter, size: size, color: color);

  static Widget hideIcon({double size = 20, Color? color}) =>
      svg(hide, size: size, color: color);

  static Widget pendingIcon({double size = 20, Color? color}) =>
      svg(pending, size: size, color: color);

  static Widget searchIcon({double size = 20, Color? color}) =>
      svg(search, size: size, color: color);

  static Widget showIcon({double size = 20, Color? color}) =>
      svg(show, size: size, color: color);

  static Widget sortIcon({double size = 20, Color? color}) =>
      svg(sort, size: size, color: color);

  // --------------------------------------------------
  // COLOR ICONS (NO COLOR OVERRIDE)
  // --------------------------------------------------

  static Widget doneColorIcon({double size = 24}) => svg(doneColor, size: size);

  static Widget educationColorIcon({double size = 24}) =>
      svg(educationColor, size: size);

  static Widget failedColorIcon({double size = 24}) =>
      svg(failedColor, size: size);

  static Widget homeColorIcon({double size = 24}) => svg(homeColor, size: size);

  static Widget loaderColorIcon({double size = 24}) =>
      svg(loaderColor, size: size);

  static Widget personColorIcon({double size = 24}) =>
      svg(personColor, size: size);

  static Widget starColorIcon({double size = 24}) => svg(starColor, size: size);

  static Widget travelColorIcon({double size = 24}) =>
      svg(travelColor, size: size);

  static Widget weddingColorIcon({double size = 24}) =>
      svg(weddingColor, size: size);

  // --------------------------------------------------
  // COMMON PRESETS
  // --------------------------------------------------

  static Widget primary(String asset, {double size = 20}) =>
      svg(asset, size: size, color: AppColors.primary500);

  static Widget grey(String asset, {double size = 20}) =>
      svg(asset, size: size, color: AppColors.grey600);

  static Widget success(String asset, {double size = 20}) =>
      svg(asset, size: size, color: AppColors.green500);

  static Widget error(String asset, {double size = 20}) =>
      svg(asset, size: size, color: AppColors.red500);
}
