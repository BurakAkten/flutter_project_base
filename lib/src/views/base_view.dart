import 'package:flutter/material.dart';
import 'package:flutter_project_base/src/viewmodels/base_viewmodel.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T Function(BuildContext)? vmBuilder;
  final Widget Function(BuildContext, T)? builder;

  const BaseView({Key? key, required this.vmBuilder, required this.builder})
      : assert(vmBuilder != null, builder != null),
        super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.vmBuilder!(context),
      child: Consumer<T>(
        builder: _buildScreenContent,
      ),
    );
  }

  Widget _buildScreenContent(
          BuildContext context, T viewModel, Widget? child) =>
      !viewModel.isInitialized
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Stack(
              children: [
                widget.builder!(context, viewModel),
                Visibility(
                  visible: viewModel.isLoading,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              ],
            );
}
