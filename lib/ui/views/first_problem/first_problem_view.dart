import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

import 'first_problem_viewmodel.dart';

class FirstProblemView extends StackedView<FirstProblemViewModel> {
  const FirstProblemView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FirstProblemViewModel viewModel,
    Widget? child,
  ) {
    final users = ['A', 'B', 'C'];
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
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Social Media Suggestions',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    // Users row
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) => _UserCard(
                              user: users[index],
                              index: index,
                              matrix: viewModel.matrix,
                              onToggle: viewModel.toggleFollow,
                            )),
                    const SizedBox(height: 30),
                    // Compute button
                    if (!viewModel.isLoading)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.13),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          textStyle: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          elevation: 8,
                        ),
                        onPressed: viewModel.computeTransitiveClosure,
                        child: const Text('Compute Transitive Closure'),
                      ),
                    if (viewModel.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 6),
                      ),
                    const SizedBox(height: 24),
                    // Show closure matrix
                    if (viewModel.closure != null)
                      Column(
                        children: [
                          Text(
                            'Transitive Closure Matrix:',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _MatrixTable(matrix: viewModel.closure!),
                        ],
                      ),
                    const SizedBox(height: 18),
                    // Show suggestions
                    if (viewModel.suggestions != null &&
                        viewModel.suggestions!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suggestions:',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ...viewModel.suggestions!.map((s) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  s,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    if (viewModel.suggestions != null &&
                        viewModel.suggestions!.isEmpty)
                      Text(
                        'No suggestions. The network is optimally connected.',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    const SizedBox(height: 30),
                    // Reset button
                    if (viewModel.closure != null ||
                        viewModel.suggestions != null)
                      TextButton(
                        onPressed: viewModel.reset,
                        child: Text(
                          'Reset',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  FirstProblemViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FirstProblemViewModel();
}

// User card widget
class _UserCard extends StatelessWidget {
  final String user;
  final int index;
  final List<List<int>> matrix;
  final void Function(int, int) onToggle;
  const _UserCard(
      {required this.user,
      required this.index,
      required this.matrix,
      required this.onToggle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = ['A', 'B', 'C'];
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                'User: ',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white.withOpacity(0.18),
                child: Text(
                  user,
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (j) {
            if (j == index) return const SizedBox.shrink();
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: matrix[index][j] == 1,
                  onChanged: (_) => onToggle(index, j),
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white38,
                  inactiveTrackColor: Colors.white24,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '$user follows ${users[j]}',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// Matrix table widget
class _MatrixTable extends StatelessWidget {
  final List<List<int>> matrix;
  const _MatrixTable({required this.matrix, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = ['A', 'B', 'C'];
    return Table(
      border: TableBorder.all(color: Colors.white24, width: 1.2),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            const SizedBox(),
            ...users.map((u) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(u,
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )),
          ],
        ),
        ...List.generate(
            3,
            (i) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(users[i],
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    ...List.generate(
                        3,
                        (j) => Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Center(
                                child: Text(
                                  matrix[i][j].toString(),
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            )),
                  ],
                )),
      ],
    );
  }
}
