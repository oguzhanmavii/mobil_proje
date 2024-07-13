import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          // Onboarding sayfalarını buraya ekleyin
          OnboardingPage(
            title: 'İstinye Gallery1',
            description: 'ISU G1',
            imagePath: 'assets/image/ISUG1.jpg',
          ),
         OnboardingPage(
            title: 'İstinye Gallery1',
            description: 'ISU G1',
            imagePath: 'assets/image/ISUG1.jpg',
          ),
           OnboardingPage(
            title: 'İstinye Gallery2',
            description: 'ISU G2',
            imagePath: 'assets/image/ISUG2.jpg',
          ),
           OnboardingPage(
            title: 'İstinye Gallery3',
            description: 'ISU G3',
            imagePath: 'assets/image/ISUG3.jpg',
          ),
           OnboardingPage(
            title: 'İstinye Gallery4',
            description: 'ISU G4',
            imagePath: 'assets/image/ISUG4.jpg',
          ),
           OnboardingPage(
            title: 'İstinye Gallery5',
            description: 'ISU G5',
            imagePath: 'assets/image/ISUG5.jpg',
          ),
          // İstediğiniz kadar onboarding sayfası ekleyebilirsiniz
        ],
      ),
    );
  }
}


class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
