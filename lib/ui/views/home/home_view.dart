import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'dart:ui';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    final double cardHeight = MediaQuery.of(context).size.height * 0.35;
    final double cardWidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF232526), Color(0xFF414345)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Glassmorphism effect overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                color: Colors.black.withOpacity(0.08),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Text(
                    'Discrete Project',
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore real-world implementations of Discrete Math problems',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Main options
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _OptionCard(
                          icon: Icons.account_tree_rounded,
                          title: 'Social Suggestion ',
                          subTitle: 'Warshall\'s Algorithm',
                          description:
                              'Visualize and solve real-world network problems using graph algorithms.',
                          onTap: viewModel.navigateToFirstProblem,
                          height: cardHeight,
                          width: cardWidth,
                        ),
                        _OptionCard(
                          icon: Icons.alarm_rounded,
                          title: 'Smart Alarm Logic',
                          subTitle: '(K-Map)',
                          description:
                              'Apply combinatorial logic to practical scenarios and optimize solutions.',
                          onTap: viewModel.navigateToSecondProblem,
                          height: cardHeight,
                          width: cardWidth,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Optional: Footer or credits
                  Text(
                    'Made with Flutter  •  2025',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final String description;
  final VoidCallback onTap;
  final double height;
  final double width;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.onTap,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
            width: 1.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(14),
                child: Icon(
                  icon,
                  size: 38,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subTitle,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              // Text(
              //   description,
              //   style: GoogleFonts.montserrat(
              //     fontSize: 15,
              //     color: Colors.white70,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
