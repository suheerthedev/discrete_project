import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'k_map_viewmodel.dart';

class KMapView extends StackedView<KMapViewModel> {
  final List<bool> truthTable;
  const KMapView({Key? key, required this.truthTable}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    KMapViewModel viewModel,
    Widget? child,
  ) {
    // For demo: get the K-map data from the viewModel (should be passed from previous screen)

    // K-map for 3 variables: a (row), b,c (column)
    // Row 0: a=0, Row 1: a=1
    // Col 0: b=0,c=0; Col 1: b=0,c=1; Col 2: b=1,c=1; Col 3: b=1,c=0 (Gray code)
    final List<List<int>> kmapIndices = [
      [0, 1, 3, 2], // a=0
      [4, 5, 7, 6], // a=1
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Generated K-Map',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),
                  // K-map table
                  _KMapTable(truthTable: truthTable, kmapIndices: kmapIndices),
                  const SizedBox(height: 32),
                  Text(
                    'Cells marked 1 indicate alarm triggers for those input combinations.',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back'),
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
  KMapViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      KMapViewModel();
}

class _KMapTable extends StatelessWidget {
  final List<bool> truthTable;
  final List<List<int>> kmapIndices;
  const _KMapTable(
      {required this.truthTable, required this.kmapIndices, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colLabels = ['b=0,c=0', 'b=0,c=1', 'b=1,c=1', 'b=1,c=0'];
    return Table(
      border: TableBorder.all(color: Colors.white24, width: 1.2),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            const SizedBox(),
            ...colLabels.map((l) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                  child: Text(l,
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )),
          ],
        ),
        ...List.generate(
            2,
            (row) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('a=${row}',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    ...List.generate(4, (col) {
                      final idx = kmapIndices[row][col];
                      final isOne = truthTable[idx];
                      return Container(
                        height: 48,
                        color: isOne
                            ? Colors.redAccent.withOpacity(0.5)
                            : Colors.transparent,
                        child: Center(
                          child: Text(
                            isOne ? '1' : '0',
                            style: GoogleFonts.montserrat(
                              color: isOne ? Colors.white : Colors.white54,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                )),
      ],
    );
  }
}
