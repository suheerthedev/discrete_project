import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'first_problem_viewmodel.dart';

class FirstProblemView extends StackedView<FirstProblemViewModel> {
  const FirstProblemView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FirstProblemViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("FirstProblemView")),
      ),
    );
  }

  @override
  FirstProblemViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FirstProblemViewModel();
}
