import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'show.dart';

enum ShowType{Show1, Show2, Show3}

///This is a model class used to bind data to the UI
class MyModel with ChangeNotifier{

   /// Three objects of Show, one for each show
   Show show1;
   Show show2;
   Show show3;


    String _show = "";
    String _audi = "";
    Show _showObj;

    String get show => _show;
    String get audi => _audi;
    Show get showObj => _showObj;

    set show(String show){
      _show = show;
      //notifyListeners();
    }

    set audi(String audi){
      _audi = audi;
      //notifyListeners();
    }

    set showObj(Show showObj){
      _showObj = showObj;
      notifyListeners();
    }

    void onShowChange(String showName){
      show = showName;
    }

    void onAudiChange(String audiName){
      audi = audiName;
    }

    ///Books tickets
    void book(){
      showObj.bookTicket();
      //showObj.generateTotalSales();
      notifyListeners();
      log("booking completed..");
    }

    void showTotalSales(){
      showObj.generateTotalSales();
      notifyListeners();
    }

    /// Configures a show when it is first selected through combo-box
    prepareShow(String showName){
        if(showName == 'Show1'){
          if(show1 == null){
            log("1111");
            show1 = new Show();
            show1.setShowName(showName);
            show1.setAudi(showName);
          }
          showObj = show1;

        }else if(showName == 'Show2'){
          if(show2 == null){
            show2 = new Show();
            show2.setShowName(showName);
            show2.setAudi(showName);
          }
          showObj = show2;

        }else if(showName == 'Show3'){
          if(show3 == null){
            show3 = new Show();
            show3.setShowName(showName);
            show3.setAudi(showName);
          }
          showObj = show3;
        }
        //notifyListeners();
    }

    Show getShow(showName){
      Show show;
      if(showName == 'Show1'){
        log("model: getShow(): show1");
        show = show1;
      }else if(showName == 'Show2'){
        show = show2;
        log("model: getShow(): show2");
      }else if(showName == 'Show3'){
        show = show3;
        log("model: getShow(): show3");
      }
      return show;
    }
}