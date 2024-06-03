// import 'package:BYM/by_header.dart';
import 'package:BYM/utils/ERApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





// 关于baseVC，我不太想用getx，但是这个StatefulWidget的继承感觉很麻烦。。。。。。。
// 这个Getview就是为了方便取到controller
abstract class BYBasePageGetX<Controller extends BYBasePageGontroller> extends GetView<Controller> {

  Color bgColor = Color(0xFFF4F6FA);
  String title = '';
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: GetBuilder(
        init: controller,
        initState: initState,
        dispose: dispose,
        builder: (controller) { 
          return pageBody(context);
        }
      ),
      backgroundColor: bgColor,
    );
  }


  Widget pageBody(BuildContext context);
 


  PreferredSizeWidget? appbar(){
    return AppBar(
      backgroundColor: bgColor,
      centerTitle: false,
      scrolledUnderElevation: 0.0,
      title: Text(
        '${title}',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal
        )
      ),
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: UnconstrainedBox(
          child:Container(
            height: 24,
            width: 24,
            // child: BYM.svg('assets/er_back_black.svg')
          )
        ),
        onTap: (){
          back();
        }
      ),
    );
}

  
  void back(){
    Get.back();
  }




  void initState(GetBuilderState<BYBasePageGontroller> state) {
    
  }
  


  void dispose(GetBuilderState<BYBasePageGontroller> state) {
  
  }

  


}






abstract class BYBasePageGontroller extends GetxController{

}

