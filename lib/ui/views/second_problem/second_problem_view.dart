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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("SecondProblemView")),
      ),
    );
  }

  @override
  SecondProblemViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SecondProblemViewModel();
}
