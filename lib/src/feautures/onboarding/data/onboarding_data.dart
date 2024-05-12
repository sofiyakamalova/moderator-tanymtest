import 'package:tanymtest_moderator_app/src/feautures/onboarding/model/onboarding_details.dart';

class OnboardingData {
  List<OnboardingDetails> items = [
    OnboardingDetails(
      title: 'Добро пожаловать в PsychoTest!',
      description:
          'Приветствуем вас в PsychoTest, где вы сможете погрузиться в мир самопознания и открыть для себя новые возможности!',
      image: 'assets/images/onboarding_1.png',
    ),
    OnboardingDetails(
      title: 'Узнайте свой внутренний мир',
      description:
          'Исследуйте свою личность, понимайте свои эмоции и открывайте новые горизонты с нашими уникальными тестами!',
      image: 'assets/images/onboarding_2.png',
    ),
    OnboardingDetails(
      title: 'Связь с психологом',
      description:
          'Получайте ценные советы и поддержку от наших опытных психологов! Давайте вместе создадим ваш путь к самопознанию!',
      image: 'assets/images/onboarding_3.png',
    ),
  ];
}
