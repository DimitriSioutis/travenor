import '../models/onboarding_page.dart';

abstract class RemoteConfigRepository {
  Future<List<OnboardingPageInfo>> getOnboardingPages();
}
