import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_2/home/home_page.dart';

const String onboardingKey = 'isOnboardingWatched';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = pageIndex == 2;

    final bool isDarkTheme =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkTheme
          ? const Color(0xff1b1726)
          : const Color(0xfff5f3fa),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: openHomePage,
                    child: Text(
                      'Пропустить',
                      style: TextStyle(
                        color: isDarkTheme
                            ? const Color(0xff9ca3af)
                            : const Color(0xff9ca3af),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                children: [
                  OnboardingContent(
                    icon: Icons.done_all,
                    title: 'Todolist',
                    subTitle: 'Добро пожаловать!',
                    text:
                    'Организуйте свою жизнь с Todolist - приложением для управления задачами',
                    isDarkTheme: isDarkTheme,
                  ),
                  OnboardingContent(
                    icon: Icons.fact_check,
                    title: 'Все задачи',
                    subTitle: 'в одном месте',
                    text:
                    'Добавляйте и упорядочивайте задачи на день, неделю и месяц',
                    isDarkTheme: isDarkTheme,
                  ),
                  OnboardingContent(
                    icon: Icons.notifications_active,
                    title: 'Не забывайте',
                    subTitle: 'важные дела',
                    text:
                    'Отмечайте выполненные задачи и следите за списком',
                    isDarkTheme: isDarkTheme,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDot(0),
                buildDot(1),
                buildDot(2),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
                bottom: 18,
              ),
              child: Row(
                children: [
                  if (pageIndex > 0)
                    TextButton(
                      onPressed: previousPage,
                      child: const Text(
                        'Назад',
                        style: TextStyle(
                          color: Color(0xff9ca3af),
                        ),
                      ),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0d83f6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed:
                    isLastPage ? openHomePage : nextPage,
                    child: Text(
                      isLastPage ? 'Начать' : 'Далее',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    final bool isActive = pageIndex == index;

    return Container(
      width: isActive ? 9 : 6,
      height: 6,
      margin: const EdgeInsets.only(
        left: 3,
        right: 3,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xff0d83f6)
            : const Color(0xff4b5563),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  Future<void> openHomePage() async {
    final preferences =
    await SharedPreferences.getInstance();

    await preferences.setBool(
      onboardingKey,
      true,
    );

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.text,
    required this.isDarkTheme,
  });

  final IconData icon;
  final String title;
  final String subTitle;
  final String text;
  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 28,
        right: 28,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: const Color(0xffef4438),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 44,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkTheme
                  ? Colors.white
                  : const Color(0xff111827),
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkTheme
                  ? Colors.white
                  : const Color(0xff111827),
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkTheme
                  ? const Color(0xffb8b8c0)
                  : const Color(0xff7b7f8a),
              fontSize: 14,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}