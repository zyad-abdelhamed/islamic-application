import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/cubit/reciters_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/current_reciter.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';

class TestWidgets extends StatelessWidget {
  const TestWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => showPlayingRecitersBottomSheet(context),
          child: const Text("عرض القراء"),
        ),
      ),
    );
  }
}

Future<void> showPlayingRecitersBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return const _ModernBottomSheet();
    },
  );
}

class _ModernBottomSheet extends StatelessWidget {
  const _ModernBottomSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkModeScaffoldBackGroundColor
              : AppColors.lightModeScaffoldBackGroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 25,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ▫️ Handle bar
              Center(
                child: Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                "القراء المتاحين الآن",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // ▫️ Reciters List
              Expanded(
                child: BlocProvider(
                  create: (context) =>
                      RecitersCubit(sl())..getReciters(surahName: 'الفاتحة'),
                  child: BlocBuilder<RecitersCubit, RecitersState>(
                    builder: (context, state) {
                      if (state is RecitersFailure) {
                        return ErrorWidgetIslamic(message: state.message);
                      } else if (state is RecitersLoading) {
                        return SizedBox.shrink();
                      } else if (state is RecitersLoaded) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.reciters.length,
                          separatorBuilder: (context, _) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            return CurrentReciter(
                              reciter: state.reciters[index],
                            );
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
