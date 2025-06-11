import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'second_problem_viewmodel.dart';

class SecondProblemView extends StackedView<SecondProblemViewModel> {
  const SecondProblemView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SecondProblemViewModel viewModel,
    Widget? child,
  ) {
    final List<String> vars = ['a', 'b', 'c'];
    final List<String> varLabels = [
      'Motion Detected',
      'Door Opened',
      'Glass Break Detected',
    ];
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
                      'Smart Alarm Trigger (K-Map)',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Set when the alarm should trigger based on the following conditions:',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    // Truth table
                    _TruthTable(
                      vars: vars,
                      varLabels: varLabels,
                      values: viewModel.truthTable,
                      onChanged: viewModel.toggleOutput,
                    ),
                    const SizedBox(height: 30),
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
                      onPressed: viewModel.generateKMap,
                      child: const Text('Generate K-Map (Coming Soon)'),
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
  SecondProblemViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SecondProblemViewModel();
}

class _TruthTable extends StatelessWidget {
  final List<String> vars;
  final List<String> varLabels;
  final List<bool> values;
  final void Function(int) onChanged;
  const _TruthTable(
      {required this.vars,
      required this.varLabels,
      required this.values,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white24, width: 1.2),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            ...varLabels.map((l) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(l,
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text('Alarm',
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        ...List.generate(8, (i) {
          final bits = [
            (i >> 2) & 1,
            (i >> 1) & 1,
            i & 1,
          ];
          return TableRow(
            children: [
              ...bits.map((b) => Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Center(
                      child: Text(b.toString(),
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 16)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Checkbox(
                    value: values[i],
                    onChanged: (_) => onChanged(i),
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
