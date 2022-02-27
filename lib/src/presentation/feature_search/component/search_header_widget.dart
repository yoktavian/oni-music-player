import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/component/text_field_widget.dart';
import 'package:oni_music_player/src/presentation/base/style/oni_color_token.dart';

class SearchHeaderWidget extends StatelessWidget {
  static const searchTextFieldKey = 'search-text-field';

  final String greetingLabel;

  final String name;

  final String title;

  final String searchPlaceholder;

  final ValueChanged<String>? onKeywordChanged;

  final ValueChanged<String>? onKeywordSubmitted;

  const SearchHeaderWidget(
    this.greetingLabel,
    this.name,
    this.title, {
    Key? key,
    this.searchPlaceholder = '',
    this.onKeywordChanged,
    this.onKeywordSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 160,
          width: MediaQuery.of(context).size.width,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  OniColorToken.mineShaft,
                  OniColorToken.bleachedCedar,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 26),
                  children: [
                    TextSpan(text: '$greetingLabel, '),
                    TextSpan(
                      text: '$name!',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(color: Colors.amberAccent)),
              const SizedBox(height: 16),
              SizedBox(
                height: 36,
                child: TextFieldWidget(
                  key: const Key(searchTextFieldKey),
                  onChanged: onKeywordChanged,
                  onSubmitted: onKeywordSubmitted,
                  placeholder: searchPlaceholder,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
