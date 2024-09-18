import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/UploadFileListener/upload_file_listener.dart';
import 'package:peopleqlik_debug/Version1/models/uploaded_file_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class AttachmentFileWidget extends StatefulWidget {
  final double? height,horizontalMargin,verticalMargin;
  final String? headerText;
  final FileTypeServer? fileTypeServer;
  final Function(List<GetFileType>)? pathCallBack;
  final double? topMargin,bottomMargin;
  const AttachmentFileWidget(this.headerText,this.pathCallBack,this.fileTypeServer,{this.height,this.horizontalMargin,this.verticalMargin,this.topMargin,this.bottomMargin,Key? key}) : super(key: key);

  @override
  _AttachmentFileWidgetState createState() => _AttachmentFileWidgetState();
}

class _AttachmentFileWidgetState extends State<AttachmentFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).heightOnly(widget.height??15),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(MyColor.colorGreySecondary),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenSize(context).heightOnly( 2),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
            child: Text(
              widget.headerText??'',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
          ),
          Flexible(child:
          Consumer<TimeOffAddEditAttachments>(
            builder: (context,data,child) {
              return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4)),
                  itemBuilder: (context,index)
                  {
                    if(data.getFileTypeList?[index].fileOrUrl == FileOrUrl.button)
                      {
                        print('if');
                        return
                          Container(
                            key: Key('indexItem$index'),
                            width: ScreenSize(context).heightOnly( 12),
                            margin: widget.topMargin!=null?EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),ScreenSize(context).widthOnly(widget.topMargin??0.0),ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),ScreenSize(context).widthOnly(widget.bottomMargin??0.0)):EdgeInsets.symmetric(horizontal:ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),vertical: ScreenSize(context).widthOnly(widget.verticalMargin??0.0)),
                            decoration: BoxDecoration(
                              color: const Color(MyColor.colorWhite),
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              //color: const Color(MyColor.colorWhite),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 0.0,
                                    blurRadius: 14,
                                    offset: const Offset(3.0, 3.0)),
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 0.0,
                                    blurRadius: 14 / 2.0,
                                    offset: const Offset(3.0, 3.0)),
                                BoxShadow(
                                    color: Colors.grey.shade50,
                                    spreadRadius: 2.0,
                                    blurRadius: 14,
                                    offset: const Offset(0.0, -3.0)),
                                BoxShadow(
                                    color: Colors.grey.shade50,
                                    spreadRadius: 2.0,
                                    blurRadius: 14 / 2,
                                    offset: const Offset(0.0, -3.0)),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: Material(
                                color: const Color(MyColor.colorWhite),
                                child: InkWell(
                                  splashColor: const Color(MyColor.colorGrey0),
                                  onTap: () async {
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['png','jpg', 'pdf', 'doc', 'txt'],
                                    );
                                    if (result != null) {
                                      PlatformFile file = result.files.first;

                                      // PrintLogs.printLogs(file.name);
                                      // PrintLogs.printLogs(file.bytes);
                                      // PrintLogs.printLogs(file.size);
                                      // PrintLogs.printLogs(file.extension);
                                      // PrintLogs.printLogs(file.path);

                                      UploadedResultSet? uploadedResultSet = await UploadFileListener().start(file.path!, widget.fileTypeServer!,context);
                                      PrintLogs.printLogs('fileeeeee ${uploadedResultSet?.docName}');
                                      if(uploadedResultSet!=null)
                                        {
                                          data.addFile(file,uploadedResultSet);
                                          PrintLogs.printLogs('fileeeeee ${data.getFileTypeList!.length}');
                                          widget.pathCallBack!(data.getFileTypeList!);

                                          data.notify();
                                        }
                                    } else {
                                      //PrintLogs.print('failedpic');
                                      // User canceled the picker
                                    }
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      size: ScreenSize(context).heightOnly( 5.5),
                                      color: const Color(MyColor.colorBlack),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                      }
                    else if(data.getFileTypeList?[index].fileOrUrl == FileOrUrl.file)
                      {
                        print('else if');
                        return
                          Container(
                              key: Key('indexItem$index'),
                              width: ScreenSize(context).heightOnly( 12),
                              margin: widget.topMargin!=null?EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),ScreenSize(context).widthOnly(widget.topMargin??0.0),ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),ScreenSize(context).widthOnly(widget.bottomMargin??0.0)):EdgeInsets.symmetric(horizontal:ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),vertical: ScreenSize(context).widthOnly(widget.verticalMargin??0.0)),
                              decoration: BoxDecoration(
                                color: const Color(MyColor.colorWhite),
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                //color: const Color(MyColor.colorWhite),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 0.0,
                                      blurRadius: 14,
                                      offset: const Offset(3.0, 3.0)),
                                  BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 0.0,
                                      blurRadius: 14 / 2.0,
                                      offset: const Offset(3.0, 3.0)),
                                  BoxShadow(
                                      color: Colors.grey.shade50,
                                      spreadRadius: 2.0,
                                      blurRadius: 14,
                                      offset: const Offset(0.0, -3.0)),
                                  BoxShadow(
                                      color: Colors.grey.shade50,
                                      spreadRadius: 2.0,
                                      blurRadius: 14 / 2,
                                      offset: const Offset(0.0, -3.0)),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          data.getFileTypeList?[index].file?.extension=='png'||data.getFileTypeList?[index].file?.extension=='jpg'?Icons.photo_outlined:Icons.file_copy_outlined,
                                          size: ScreenSize(context).heightOnly( 4),
                                          color: const Color(MyColor.colorPrimary),
                                        ),
                                        SizedBox(height: ScreenSize(context).heightOnly( 1),),
                                        Padding(
                                          padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.4)),
                                          child: Text(
                                            data.getFileTypeList?[index].file?.name??'',
                                            style: GetFont.get(
                                                context,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 1.2,
                                                color: MyColor.colorBlack
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
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
                                            data.removeItem(index);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.6)),
                                            child: Icon(
                                              Icons.cancel,
                                              size: ScreenSize(context).heightOnly( 2.6),
                                              color: const Color(MyColor.colorGrey3),
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
                        Container(
                            key: Key('indexItem$index'),
                            width: ScreenSize(context).heightOnly( 12),
                            margin: widget.topMargin!=null?EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),ScreenSize(context).widthOnly(widget.topMargin??0.0),ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),ScreenSize(context).widthOnly(widget.bottomMargin??0.0)):EdgeInsets.symmetric(horizontal:ScreenSize(context).widthOnly(widget.horizontalMargin??0.0),vertical: ScreenSize(context).widthOnly(widget.verticalMargin??0.0)),
                            decoration: BoxDecoration(
                              color: const Color(MyColor.colorWhite),
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              //color: const Color(MyColor.colorWhite),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 0.0,
                                    blurRadius: 14,
                                    offset: const Offset(3.0, 3.0)),
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 0.0,
                                    blurRadius: 14 / 2.0,
                                    offset: const Offset(3.0, 3.0)),
                                BoxShadow(
                                    color: Colors.grey.shade50,
                                    spreadRadius: 2.0,
                                    blurRadius: 14,
                                    offset: const Offset(0.0, -3.0)),
                                BoxShadow(
                                    color: Colors.grey.shade50,
                                    spreadRadius: 2.0,
                                    blurRadius: 14 / 2,
                                    offset: const Offset(0.0, -3.0)),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo_outlined,
                                        size: ScreenSize(context).heightOnly( 4),
                                        color: const Color(MyColor.colorPrimary),
                                      ),
                                      SizedBox(height: ScreenSize(context).heightOnly( 1),),
                                      Text(
                                        'Jpg',
                                        style: GetFont.get(
                                            context,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 1.4,
                                            color: MyColor.colorBlack
                                        ),
                                        maxLines: 1,
                                      )
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

                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.6)),
                                          child: Icon(
                                            Icons.cancel,
                                            size: ScreenSize(context).heightOnly( 2.6),
                                            color: const Color(MyColor.colorGrey3),
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
                    return SizedBox(width: ScreenSize(context).widthOnly( 0),);
                  },
                  itemCount: data.getFileTypeList?.length??1
              );
            }
          ),)
        ],
      )
    );
  }
}
