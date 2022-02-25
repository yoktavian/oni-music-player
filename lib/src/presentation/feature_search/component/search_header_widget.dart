import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/component/text_field_widget.dart';

class SearchHeaderWidget extends StatelessWidget {
  final String headerImage;

  final String title;

  final String searchPlaceholder;

  final ValueChanged<String>? onKeywordChanged;

  final ValueChanged<String>? onKeywordSubmitted;

  const SearchHeaderWidget(
    this.headerImage,
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
          child: Image.network(headerImage, fit: BoxFit.cover),
          height: 180,
          width: MediaQuery.of(context).size.width,
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
                  children: [
                    TextSpan(text: title),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: TextFieldWidget(
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
