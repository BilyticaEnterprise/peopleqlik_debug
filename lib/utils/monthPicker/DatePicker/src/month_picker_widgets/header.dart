import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/utils/MonthPicker/DatePicker/src/helpers/common.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:rxdart/rxdart.dart';

class PickerHeader extends StatelessWidget {
  const PickerHeader(
      {Key? key,
      required this.theme,
      required this.locale,
      this.headerColor,
      this.headerTextColor,
      required this.capitalizeFirstLetter,
      required this.selectedDate,
      required this.isMonthSelector,
      required this.onDownButtonPressed,
      required this.onSelectYear,
      required this.onUpButtonPressed,
      required this.upDownButtonEnableStatePublishSubject,
      required this.upDownPageLimitPublishSubject})
      : super(key: key);
  final ThemeData theme;
  final String locale;
  final Color? headerTextColor, headerColor;
  final bool capitalizeFirstLetter;
  final DateTime selectedDate;
  final bool isMonthSelector;
  final VoidCallback onSelectYear, onUpButtonPressed, onDownButtonPressed;
  final PublishSubject<UpDownPageLimit>? upDownPageLimitPublishSubject;
  final PublishSubject<UpDownButtonEnableState>? upDownButtonEnableStatePublishSubject;

  @override
  Widget build(BuildContext context) {
    final TextStyle? _headline5 = headerTextColor == null
        ? theme.primaryTextTheme.headline5
        : theme.primaryTextTheme.headline5!.copyWith(color: headerTextColor);
    final Color? _arrowcolors = headerTextColor ?? theme.primaryIconTheme.color;

    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
      child: Material(
        color: headerColor ?? theme.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${DateFormat.MMM(locale).format(selectedDate)},',
                style: GetFont.get(
                    context,
                    fontSize: 2.2,
                    fontWeight: FontWeight.w400,
                    color: MyColor.colorWhite
                ),
              ),
              // Text(
              //   capitalizeFirstLetter
              //       ? '${toBeginningOfSentenceCase(DateFormat.yMMM(locale).format(selectedDate))}'
              //       : '${DateFormat.yMMM(locale).format(selectedDate).toLowerCase()}',
              //   style: headerTextColor == null
              //       ? theme.primaryTextTheme.subtitle1
              //       : theme.primaryTextTheme.subtitle1!
              //           .copyWith(color: headerTextColor),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isMonthSelector
                      ? GestureDetector(
                          onTap: onSelectYear,
                          child: StreamBuilder<UpDownPageLimit>(
                            stream: upDownPageLimitPublishSubject,
                            initialData: const UpDownPageLimit(0, 0),
                            builder: (_, AsyncSnapshot<UpDownPageLimit> snapshot) => Text(
                              DateFormat.y(locale).format(DateTime(snapshot.data!.upLimit)),
                              style: GetFont.get(
                                  context,
                                  fontSize: 3.4,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorWhite
                              ),
                            ),
                          ),
                        )
                      : StreamBuilder<UpDownPageLimit>(
                          stream: upDownPageLimitPublishSubject,
                          initialData: const UpDownPageLimit(0, 0),
                          builder: (_, AsyncSnapshot<UpDownPageLimit> snapshot) => Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${DateFormat.y(locale).format(DateTime(snapshot.data!.upLimit))}',
                                style: _headline5,
                              ),
                              Text(
                                '-',
                                style: _headline5,
                              ),
                              Text(
                                '${DateFormat.y(locale).format(DateTime(snapshot.data!.downLimit))}',
                                style: _headline5,
                              ),
                            ],
                          ),
                        ),
                  StreamBuilder<UpDownButtonEnableState>(
                    stream: upDownButtonEnableStatePublishSubject,
                    initialData: const UpDownButtonEnableState(true, true),
                    builder: (_, AsyncSnapshot<UpDownButtonEnableState> snapshot) => Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            color: snapshot.data!.upState
                                ? _arrowcolors
                                : _arrowcolors!.withOpacity(0.5),
                          ),
                          onPressed:
                              snapshot.data!.upState ? onUpButtonPressed : null,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: snapshot.data!.downState
                                ? _arrowcolors
                                : _arrowcolors!.withOpacity(0.5),
                          ),
                          onPressed: snapshot.data!.downState
                              ? onDownButtonPressed
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
