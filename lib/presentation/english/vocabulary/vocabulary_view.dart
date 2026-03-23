import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/widgets/item_voice_dialog.dart';
import 'package:putu_education/presentation/widgets/item_voice_widget.dart';
import '../../../app/service/tts_service.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';

enum VocabType{
  animal,
  color,
  food,
  all
}

class EnglishVocabularyView extends StatefulWidget {
  const EnglishVocabularyView({super.key});

  @override
  State<EnglishVocabularyView> createState() => _EnglishVocabularyViewState();
}

class _EnglishVocabularyViewState extends State<EnglishVocabularyView> {
  VocabType _vocabType = VocabType.all;
  FlutterTts flutterTts = TtsService.instance.flutterTts;

  List<String> photoList = [
    'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    'https://images.unsplash.com/photo-1598755257130-c2aaca1f061c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA3L3JvYl9yYXdwaXhlbF9zdHVkaW9fcGhvdG9fb2ZfYV9vcmFuZ3V0YW5fZnVsbF9ib2R5X2lzb2xhdGVkX29uX182Nzc4MjQxOS1lYTFjLTQ1ODItYmExMy0xMzYzZDY0MDU2MzYtNXgtaHEtc2NhbGUtNV8wMHgtam9iMTg5NC0wMS5qcGc.jpg',
    'https://images.unsplash.com/photo-1592670130429-fa412d400f50?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D'
        'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    'https://images.unsplash.com/photo-1598755257130-c2aaca1f061c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA3L3JvYl9yYXdwaXhlbF9zdHVkaW9fcGhvdG9fb2ZfYV9vcmFuZ3V0YW5fZnVsbF9ib2R5X2lzb2xhdGVkX29uX182Nzc4MjQxOS1lYTFjLTQ1ODItYmExMy0xMzYzZDY0MDU2MzYtNXgtaHEtc2NhbGUtNV8wMHgtam9iMTg5NC0wMS5qcGc.jpg',
    'https://images.unsplash.com/photo-1592670130429-fa412d400f50?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    'https://images.unsplash.com/photo-1598755257130-c2aaca1f061c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA3L3JvYl9yYXdwaXhlbF9zdHVkaW9fcGhvdG9fb2ZfYV9vcmFuZ3V0YW5fZnVsbF9ib2R5X2lzb2xhdGVkX29uX182Nzc4MjQxOS1lYTFjLTQ1ODItYmExMy0xMzYzZDY0MDU2MzYtNXgtaHEtc2NhbGUtNV8wMHgtam9iMTg5NC0wMS5qcGc.jpg',
    'https://images.unsplash.com/photo-1592670130429-fa412d400f50?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D'

  ];

  List<String> nameList = ['cat','squirrel', 'zebra', 'ape', 'elephant',
    'cat','squirrel', 'zebra', 'ape', 'elephant',
    'cat','squirrel', 'zebra', 'ape', 'elephant'];
  int selectedIndex=0;


  Widget tabItem(VocabType type){
    return GestureDetector(
      onTap: (){
        setState(() {
          _vocabType = type;
        });
      },
      child:  Container(
        width: 100,
        height: 40,
        // constraints: BoxConstraints(
        //   minHeight: 48
        // ),
        // padding: EdgeInsets.only(left: 20, right: 20),
        decoration: type==_vocabType?
        selectedTabDecoration():unselectedTabDecoration(),
        child: Center(child:
        Text(tr(type.name),
          style: FontFamily().medium.copyWith(fontSize:16
            // FontSize.twenty(context)
          ),)
        ),
      ),
    );
  }
  speak() async{
    await flutterTts.stop();
    await flutterTts.speak(nameList[selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: tr('vocabulary'),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/light_background.png",),
                fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(width: 10,),
                    tabItem(VocabType.all),
                    const SizedBox(width: 10,),
                    tabItem(VocabType.animal),
                    const SizedBox(width: 10,),
                    tabItem(VocabType.color),
                    const SizedBox(width: 10,),
                    tabItem(VocabType.food)
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16.0, // gap between adjacent items
                    runSpacing: 16.0, // gap between lines
                    children:
                    List.generate(
                      photoList.length,
                          (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex=index;
                            });
                            speak();
                            showImageDialog
                              (context: context,
                              photoList: photoList,
                              nameList: nameList,
                              selectedIndex: selectedIndex,
                            );
                            // _showImageDialog();
                            // Navigator.of(context).push(PhotoViewOverlay(image: 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg'));
                          },
                          child: ItemVoiceWidget(photo: photoList[index], name: nameList[index])

                      ),
                    ),
                  ),
                ),
              ),
            ],
          ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom)
        ),
      ),
    );
  }
}
