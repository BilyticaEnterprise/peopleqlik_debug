import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/icon_view/done_icon.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import '../../domain/model/attahcment_upload_model.dart';
import '../../utils/basic_image_view.dart';
import '../../utils/file_type.dart';
import '../listener/attachment_bloc.dart';

class AttachmentFileWidget extends StatefulWidget {
  final double height;
  final String? headerText;
  final AttachmentUploadMapper attachmentUploaderMapper;
  final Function(dynamic) result;
  // final FileTypeServer? fileTypeServer;
  const AttachmentFileWidget({required this.attachmentUploaderMapper,required this.result, this.headerText,this.height = 29,Key? key}) : super(key: key);

  @override
  _AttachmentFileWidgetState createState() => _AttachmentFileWidgetState();
}

class _AttachmentFileWidgetState extends State<AttachmentFileWidget> {
  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<AttachmentBloc>(create: (_) => AttachmentBloc(AppStateNothing(),widget.attachmentUploaderMapper),)
      ],
      builder: (context) {
        return Container(
            height: ScreenSize(context).heightOnly(widget.height),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(MyColor.colorGreySecondary),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenSize(context).heightOnly(2),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6.6)),
                  child: Text(
                    widget.headerText??'',
                    style: GetFont.get(
                        context,
                        fontSize: 1.8,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorBlack
                    ),
                  ),
                ),
                Flexible(
                  child: _GetAttachmentFileWidget(widget.result),
                )
              ],
            )
        );
      }
    );
  }
}
class _GetAttachmentFileWidget extends StatelessWidget {
  final Function(dynamic) result;
  const _GetAttachmentFileWidget(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    AttachmentBloc attachmentBloc = BlocProvider.of<AttachmentBloc>(context,listen: false);
    return BlocConsumer<AttachmentBloc,AppState>(
        listener: (context,data){
          if(data is AppStateDone)
            {
              result(attachmentBloc.prepareDataForResult());
            }
        },
        builder: (context,data) {
          return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(4)),
              itemBuilder: (context,index)
              {
                if(attachmentBloc.useCase.getFilesList()[index].dataType == DataType.button)
                {
                  print('if');
                  return
                    BasicImageView(
                      key: Key('indexItem$index'),
                      onTap: (){
                        attachmentBloc.addFile(context);
                      },
                      child: Center(
                        child: Icon(
                          Icons.add_circle_outline,
                          size: ScreenSize(context).heightOnly(6.5),
                          color: const Color(MyColor.colorBlack),
                        ),
                      ),
                    );
                }
                else if(attachmentBloc.useCase.getFilesList()[index].dataType == DataType.file)
                {
                  print('else if');
                  return
                    BasicImageView(
                        key: Key('indexItem$index'),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    attachmentBloc.getIconType(attachmentBloc.useCase.getFilesList()[index].file),
                                    size: ScreenSize(context).heightOnly( 4),
                                    color: const Color(MyColor.colorPrimary),
                                  ),
                                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1.4),vertical: ScreenSize(context).heightOnly(0.4)),
                                    child: Text(
                                      attachmentBloc.useCase.getFilesList()[index].file?.name??'',
                                      style: GetFont.get(
                                          context,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 1.2,
                                          color: MyColor.colorBlack
                                      ),
                                      maxLines: 4,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const DividerByHeight(1.5),

                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: ClipOval(
                                child: Material(
                                  color: const Color(MyColor.colorWhite),
                                  child: InkWell(
                                    splashColor: const Color(MyColor.colorGrey0),
                                    onTap: (){
                                      attachmentBloc.removeFile(index);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.8)),
                                      child: Icon(
                                        Icons.cancel,
                                        size: ScreenSize(context).heightOnly( 2.6),
                                        color: const Color(MyColor.colorBackgroundDark),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    );
                }
                else if(attachmentBloc.useCase.getFilesList()[index].dataType == DataType.failedFile)
                {
                  print('else if');
                  return
                    BasicImageView(
                        key: Key('indexItem$index'),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.sd_card_alert_outlined,
                                    size: ScreenSize(context).heightOnly( 4),
                                    color: const Color(MyColor.colorRed),
                                  ),
                                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1.4),vertical: ScreenSize(context).heightOnly(0.4)),
                                    child: Text(
                                      attachmentBloc.useCase.getFilesList()[index].file?.name??'',
                                      style: GetFont.get(
                                          context,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 1.2,
                                          color: MyColor.colorBlack
                                      ),
                                      maxLines: 4,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const DividerByHeight(1.5),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: ClipOval(
                                child: Material(
                                  color: const Color(MyColor.colorWhite),
                                  child: InkWell(
                                    splashColor: const Color(MyColor.colorGrey0),
                                    onTap: (){
                                      attachmentBloc.reUpload(context,index);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.8)),
                                      child: SvgPicture.string(
                                        SvgPicturesData.reUpload,
                                        height: ScreenSize(context).heightOnly(2.6),
                                        width: ScreenSize(context).heightOnly(2.6),
                                       // color: const Color(MyColor.colorRed),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    );
                }
                else
                {
                  print('else');
                  return
                    BasicImageView(
                        key: Key('indexItem$index'),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const DoneIcon(isSelected: true,size: 3.5,),
                                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1.4),vertical: ScreenSize(context).heightOnly(0.4)),
                                    child: Text(
                                      attachmentBloc.useCase.getFilesList()[index].file?.name??'',
                                      style: GetFont.get(
                                          context,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 1.2,
                                          color: MyColor.colorBlack
                                      ),
                                      maxLines: 4,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const DividerByHeight(1.5),

                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: ClipOval(
                                child: Material(
                                  color: const Color(MyColor.colorWhite),
                                  child: InkWell(
                                    splashColor: const Color(MyColor.colorGrey0),
                                    onTap: (){
                                      attachmentBloc.removeFile(index);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.8)),
                                      child: Icon(
                                        Icons.cancel,
                                        size: ScreenSize(context).heightOnly( 2.6),
                                        color: const Color(MyColor.colorBackgroundDark),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    );
                }

              },
              separatorBuilder: (context,index)
              {
                return SizedBox(width: ScreenSize(context).widthOnly(4),);
              },
              itemCount: attachmentBloc.useCase.getFilesList().length
          );
        }
    );
  }
}
