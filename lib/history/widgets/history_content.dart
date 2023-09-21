import 'package:asman_rider/history/history.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/network_error/network_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider_ui/rider_ui.dart';

class HistoryContent extends StatelessWidget {
  const HistoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((HistoryBloc bloc) => bloc.state.status);
    final content = context.select((HistoryBloc bloc) => bloc.state.content);
    final hasMoreContent = context.select((HistoryBloc bloc) => bloc.state.hasMoreContent);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HistoryBloc>().add(HistoryRefreshRequested());
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(UISpacing.lg),
        itemCount: content.length + 1,
        itemBuilder: (context, index) {
          if (index == content.length) {
            /// First: Check the failure status
            if (status == HistoryStatus.failure) {
              return NetworkError(
                onRetry: () => context.read<HistoryBloc>().add(HistoryRequested()),
              );
            }

            /// Second: Check if there more
            if (hasMoreContent) {
              return HistoryContentLoaderItem(
                onPresented: () => context.read<HistoryBloc>().add(HistoryRequested()),
              );
            }

            /// Third: Check for empty
            if (content.isEmpty) {
              return SizedBox(
                height: .8.sh,
                child: Center(
                  child: Text(context.l10n.emptyList),
                ),
              );
            }

            return const SizedBox();
          }

          return HistoryContentItemCard(historyItem: content[index]);
        },
        separatorBuilder: (_, __) => const SizedBox(height: UISpacing.lg),
      ),
    );
  }
}
