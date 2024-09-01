import 'package:flutter/material.dart';
import 'package:mental_wellbeing/QuestionPage%202/questionnairepage.dart';

import 'list.dart';

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void _nextPage() {
    setState(() {
      _currentPageIndex++;
    });
    _pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void _previousPage() {
    setState(() {
      _currentPageIndex--;
    });
    _pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: questions.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return QuestionnairePage(
            pageIndex: index,
            questions: questions[index],
            onNext: _nextPage,
            onBack: _previousPage,
            isLastPage: index == questions.length - 1,
          );
        },
      ),
    );
  }
}
