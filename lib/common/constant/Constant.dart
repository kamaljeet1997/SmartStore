import 'package:flutter/services.dart';

class Constants {
  const Constants._();

  static const String CHATBOAT_BASE_URL = 'https://chatbot.aasoka.com/';
  // todo=====* Note: E-Vox Base Url *======
  static const String E_VOX_BASE_URL = 'http://ell-api.adurox.com:3002/v1/';
  // todo=====* Note: base Url Of Ask Question *======
  static const String ASK_QUESTION_BASE_URL = 'http://15.206.186.246:5000/';
  // todo=====* Note: before deploy need to update latest version *======
  static const String LATEST_VERSION = '1.0.28';
  // todo=====* BASE URL Working all Networks *======
  //------------Beta URL-----------//
  //------------Beta URL-----------//
  // static const String BASE_URL = 'http://mbdguide.com/mobileapp/api/v3/';
  //------------Live URL-----------//
  static const String BASE_URL = 'http://122.160.201.198:3032/';

  //call method channel only android for native code
  static const platformMethodChannel =
      MethodChannel('com.erp_school/erpnative');
  static const String nativeMessage = '';
  static const timeout = Duration(minutes: 8);
  static const String TOKEN = 'authToken';
  static const String SUPPORTBOARDTOKEN =
      '8b61e12454d10ee54868e9fbd56111761a786b67';
  static const String USER_DATA = 'userData';
  static const String DYAMICMODULE_Response = 'dynamicmoduleResponse';
  static const String OFFLINEDATA_RESPONSE = 'offlineDataResponse';
  static const String PRACTICE_CAT_RESPONSE = 'practiceCategoryResponse';
  static const String USER_DATA_LIST = 'userDataList';
  static const String PARENT_DATA_LIST = 'parentDataList';
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';
  static const String REMEMBER_ME = 'rememberme';
  static const String USER_PROFILE = 'userProfile';
  static const String KIDS_CLASSES = 'kidsClasses';
  static const String KIDS_DYNAMIC_MENU = 'kidsDynamicMenu';
  static const String KIDS_EBOOK_LIST = 'kidsEbookList';
  static const String KIDS_SUBJECT_LIST = 'kidsSubjectList';
  static const String KIDS_CONTENT_LIST = 'kidsContentList';
  static const String KIDS_WORKBOOK_LIST = 'kidsWorkbookList';
  static const String KIDS_QUIZ_LIST = 'kidsQuizList';
  static const String KIDS_FLASH_CARDS_LIST = 'kidsFlashCardsList';
  static const String KIDS_FLASH_CARDS_LKG_LIST = 'kidsFlashCardsLKGList';
  static const String KIDS_FLASH_CARDS_UKG_LIST = 'kidsFlashCardsUKGList';
  static const String KIDS_LEARN_DATA = 'kidsLearnData';
  static const String KIDS_HI_LEARN_DATA = 'kidsHiLearnData';
  static const String KIDS_MA_LEARN_DATA = 'kidsMaLearnData';
  static const String KIDS_QUIZ_DATA = 'kidsQuizData';
  static const String KIDS_Hi_QUIZ_DATA = 'kidsHiQuizData';
  static const String KIDS_Ma_QUIZ_DATA = 'kidsMaQuizData';
  static const String KIDS_WORKBOOK_DATA = 'kidsWorkbookData';
  static const String KIDS_Hi_WORKBOOK_DATA = 'kidsHiWorkbookData';
  static const String KIDS_Ma_WORKBOOK_DATA = 'kidsMaWorkbookData';
  static const String KIDS_OFFLINE_CONTENT_DATA = 'kidsOfflineContentData';
  static const String KIDS_OFFLINE_READ_ALONG_RESPONSE =
      'kidsOfflineReadAlongResponse';
  static const String KIDS_OFFLINE_READ_ALONG = 'kidsOfflineReadAlong';
  static const String KIDS_FLASH_CARD_LIST = 'kidsFlashCardList';
  static const String KIDS_SCAN_AND_LEARN = 'kidsScanAndLearn';
  static const String KIDS_LKG_SCAN_AND_LEARN = 'kidsLKGScanAndLearn';
  static const String KIDS_UKG_SCAN_AND_LEARN = 'kidsUKGScanAndLearn';
  static const String KIDS_OFFLINE_T_FLASH_CARDS = 'OfflineTFlashCard';
  static const String KIDS_OFFLINE_S_FLASH_CARDS = 'OfflineSFlashCard';
}
