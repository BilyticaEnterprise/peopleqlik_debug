import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../listeners/floating_action_button_bloc.dart';
import '../../listeners/move_to_page.dart';
import 'edit_dialog_view.dart';

class FloatingActionButtonView extends StatelessWidget {
  const FloatingActionButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FloatingActionButtonBloc,double>(
        listener: (context,data){},
        builder: (context, data) {
          return Padding(
            padding: EdgeInsets.all(ScreenSize(context).heightOnly(1)),
            child: Opacity(
                opacity: data,
                child: FloatingActionButton(
                  backgroundColor: const Color(MyColor.colorPrimary),
                    onPressed: () {
                      BlocProvider.of<FloatingActionButtonBloc>(context,listen: false).update(0);
                      EditDialogView.show(context,(index){
                        BlocProvider.of<FloatingActionButtonBloc>(context,listen: false).update(1);
                        Future.delayed(const Duration(milliseconds: 200),(){
                          if(index!=null) {
                            MoveToProfilePage.move(index, context);
                          }
                        });
                      });
                    },
                  child: const Icon(Icons.edit,color: Colors.white,),
                )
            ),
          );
        }
    );
  }
}
