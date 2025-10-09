import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/reciters_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/reciter_widget.dart';

class RecitersPage extends StatelessWidget {
  const RecitersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecitersCubit(sl())..getReciters(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'القرّاء',
            style: TextStyles.semiBold32(context,
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: BlocBuilder<RecitersCubit, RecitersState>(
          builder: (context, state) {
            if (state is RecitersFailure) {
              return Center(child: Text(state.message));
            } else if (state is RecitersLoading) {
              return SizedBox.shrink();
            } else if (state is RecitersLoaded) {
              return ListView.builder(
                itemCount: state.reciters.length,
                itemBuilder: (context, index) {
                  return ReciterCardWidget(
                    reciter: state.reciters[index],
                    onPressed: () {},
                  );
                },
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
