import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'k_map_viewmodel.dart';

class KMapView extends StackedView<KMapViewModel> {
  const KMapView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    KMapViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("KMapView")),
      ),
    );
  }

  @override
  KMapViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      KMapViewModel();
}
