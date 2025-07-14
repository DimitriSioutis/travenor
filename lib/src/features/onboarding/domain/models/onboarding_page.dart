import 'package:equatable/equatable.dart';

class OnboardingPageInfo extends Equatable {
  final String title;
  final String description;
  final String imageLocalPath;
  final String lastWord;

  const OnboardingPageInfo({
    required this.title,
    required this.description,
    required this.imageLocalPath,
    required this.lastWord,
  });

  @override
  List<Object> get props => [title, description, imageLocalPath, lastWord];
}
