import 'package:get/get.dart';

class RiskAssessmentController extends GetxController {
  final RxInt currentQuestion = 1.obs;
  final RxMap<int, String> answers = <int, String>{}.obs;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'How long do you plan to stay invested?',
      'options': [
        {
          'title': 'Less than 1 year',
          'subtitle': 'Short-term investments usually prefer low risk',
        },
        {
          'title': '1 - 3 years',
          'subtitle': 'Moderate risk may help balance growth and safety',
        },
        {
          'title': '3 - 5 years',
          'subtitle': 'Longer horizons can handle market fluctuations',
        },
        {
          'title': 'More than 5 years',
          'subtitle': 'Higher risk may offer better long-term returns',
        },
      ],
    },
    {
      'question': 'What is your primary investment goal?',
      'options': [
        {
          'title': 'Capital preservation',
          'subtitle': 'Protect my money with minimal risk',
        },
        {
          'title': 'Regular income',
          'subtitle': 'Generate steady returns periodically',
        },
        {
          'title': 'Balanced growth',
          'subtitle': 'Mix of safety and growth potential',
        },
        {
          'title': 'Wealth creation',
          'subtitle': 'Maximize returns with higher risk tolerance',
        },
      ],
    },
    {
      'question': 'How would you react to a 20% drop in your portfolio?',
      'options': [
        {'title': 'Sell immediately', 'subtitle': 'I cannot handle losses'},
        {
          'title': 'Wait and monitor',
          'subtitle': 'I would be concerned but patient',
        },
        {
          'title': 'Hold my investments',
          'subtitle': 'Market fluctuations are normal',
        },
        {
          'title': 'Invest more',
          'subtitle': 'I see it as a buying opportunity',
        },
      ],
    },
    {
      'question': 'What is your investment experience level?',
      'options': [
        {'title': 'Beginner', 'subtitle': 'New to investing'},
        {'title': 'Some experience', 'subtitle': 'Invested in a few products'},
        {
          'title': 'Experienced',
          'subtitle': 'Regular investor with good knowledge',
        },
        {'title': 'Expert', 'subtitle': 'Deep understanding of markets'},
      ],
    },
    {
      'question': 'What percentage of your income can you invest?',
      'options': [
        {'title': 'Less than 10%', 'subtitle': 'Limited funds available'},
        {'title': '10% - 20%', 'subtitle': 'Moderate investment capacity'},
        {'title': '20% - 30%', 'subtitle': 'Good savings potential'},
        {'title': 'More than 30%', 'subtitle': 'High investment capacity'},
      ],
    },
  ];

  int get totalQuestions => questions.length;

  bool get canProceed => answers.containsKey(currentQuestion.value);

  bool get isLastQuestion => currentQuestion.value == totalQuestions;

  String get buttonText =>
      isLastQuestion ? 'Check your risk profile' : 'Continue';

  void selectAnswer(String answer) {
    answers[currentQuestion.value] = answer;
  }

  void nextQuestion() {
    if (currentQuestion.value < totalQuestions) {
      currentQuestion.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestion.value > 1) {
      currentQuestion.value--;
    }
  }

  void submitAssessment() {
    // Calculate risk profile based on answers
    // Navigate to risk profile screen
    Get.toNamed('/risk-profile');
  }
}
