import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/bloc_logic_utils/bloc_provider_extended.dart';
import '../../../../utils/page_state.dart';
import '../../../bloc/current_page_bloc.dart';

class MobilePrompt extends StatelessWidget {
  const MobilePrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<CurrentMobileBlockModulePage>(create: (_) => CurrentMobileBlockModulePage(PageStateRegister()))
      ],
      builder: (context) {
        return BlocConsumer<CurrentMobileBlockModulePage,MobileBlocPageState>(
          listener: (context,data){},
          builder: (context, data) {
            if(data is PageStateRegister)
              {
                return PromptView();
              }
            else
              {
                return const Placeholder();
              }
          }
        );
      }
    );
  }
}
class PromptView extends StatelessWidget {
  const PromptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

      ],
    );
  }
}
