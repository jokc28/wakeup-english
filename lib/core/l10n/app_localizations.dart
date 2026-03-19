import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'OK-Morning'**
  String get appTitle;

  /// Label for alarms tab
  ///
  /// In en, this message translates to:
  /// **'Alarms'**
  String get alarms;

  /// Label for settings tab
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Button to add new alarm
  ///
  /// In en, this message translates to:
  /// **'Add Alarm'**
  String get addAlarm;

  /// Title for edit alarm screen
  ///
  /// In en, this message translates to:
  /// **'Edit Alarm'**
  String get editAlarm;

  /// Button to delete alarm
  ///
  /// In en, this message translates to:
  /// **'Delete Alarm'**
  String get deleteAlarm;

  /// Button to save alarm
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAlarm;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Label for alarm time picker
  ///
  /// In en, this message translates to:
  /// **'Alarm Time'**
  String get alarmTime;

  /// Label for repeat days selection
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeatDays;

  /// Label for alarm name input
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get alarmLabel;

  /// Label for quiz difficulty selection
  ///
  /// In en, this message translates to:
  /// **'Quiz Difficulty'**
  String get quizDifficulty;

  /// Easy difficulty
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// Medium difficulty
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get difficultyMedium;

  /// Hard difficulty
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get difficultyHard;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunday;

  /// Instruction on quiz lock screen
  ///
  /// In en, this message translates to:
  /// **'Solve the quiz to stop the alarm'**
  String get solveToStop;

  /// Shown when answer is correct
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// Shown when answer is wrong
  ///
  /// In en, this message translates to:
  /// **'Incorrect, try again'**
  String get incorrect;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Shows remaining questions
  ///
  /// In en, this message translates to:
  /// **'{count} questions remaining'**
  String questionsRemaining(int count);

  /// Shown when there are no alarms
  ///
  /// In en, this message translates to:
  /// **'No alarms set'**
  String get noAlarms;

  /// Shown when alarm is enabled
  ///
  /// In en, this message translates to:
  /// **'Alarm enabled'**
  String get alarmEnabled;

  /// Shown when alarm is disabled
  ///
  /// In en, this message translates to:
  /// **'Alarm disabled'**
  String get alarmDisabled;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Korean language option
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get korean;

  /// Alarm sound setting
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// Vibration setting
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// Snooze setting
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get snooze;

  /// Label for snooze duration
  ///
  /// In en, this message translates to:
  /// **'Snooze Duration'**
  String get snoozeDuration;

  /// Minutes label
  ///
  /// In en, this message translates to:
  /// **'{count} minutes'**
  String minutes(int count);

  /// Label for number of quiz questions
  ///
  /// In en, this message translates to:
  /// **'Number of Questions'**
  String get quizCount;

  /// No description provided for @errorRestartApp.
  ///
  /// In en, this message translates to:
  /// **'Please restart the app'**
  String get errorRestartApp;

  /// No description provided for @errorTemporaryIssue.
  ///
  /// In en, this message translates to:
  /// **'A temporary error occurred.'**
  String get errorTemporaryIssue;

  /// No description provided for @errorLoadingAlarms.
  ///
  /// In en, this message translates to:
  /// **'Error loading alarms'**
  String get errorLoadingAlarms;

  /// No description provided for @alarmDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'\"{label}\" deleted'**
  String alarmDeletedMessage(String label);

  /// No description provided for @alarmDeletedGeneric.
  ///
  /// In en, this message translates to:
  /// **'Alarm deleted'**
  String get alarmDeletedGeneric;

  /// No description provided for @undoAction.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoAction;

  /// No description provided for @confirmDeleteAlarm.
  ///
  /// In en, this message translates to:
  /// **'Delete this alarm?'**
  String get confirmDeleteAlarm;

  /// No description provided for @confirmDeleteAlarmWithLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{label}\" alarm?'**
  String confirmDeleteAlarmWithLabel(String label);

  /// No description provided for @confirmDeleteAlarmWithTime.
  ///
  /// In en, this message translates to:
  /// **'Delete {time} alarm?'**
  String confirmDeleteAlarmWithTime(String time);

  /// No description provided for @alarmUpdated.
  ///
  /// In en, this message translates to:
  /// **'Alarm updated'**
  String get alarmUpdated;

  /// No description provided for @alarmCreated.
  ///
  /// In en, this message translates to:
  /// **'Alarm created'**
  String get alarmCreated;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @timePickerTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to change time'**
  String get timePickerTapHint;

  /// No description provided for @alarmNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Alarm Name'**
  String get alarmNameLabel;

  /// No description provided for @optionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optionalLabel;

  /// No description provided for @wakeMissionLabel.
  ///
  /// In en, this message translates to:
  /// **'Wake-up Mission'**
  String get wakeMissionLabel;

  /// No description provided for @difficultyLabel.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficultyLabel;

  /// No description provided for @alarmSoundLabel.
  ///
  /// In en, this message translates to:
  /// **'Alarm Sound'**
  String get alarmSoundLabel;

  /// No description provided for @soundLabel.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get soundLabel;

  /// No description provided for @gradualVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Gradual Volume'**
  String get gradualVolumeLabel;

  /// No description provided for @volumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volumeLabel;

  /// No description provided for @snoozeLabel.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get snoozeLabel;

  /// No description provided for @snoozeIntervalLabel.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get snoozeIntervalLabel;

  /// No description provided for @maxSnoozesLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Count'**
  String get maxSnoozesLabel;

  /// No description provided for @maxSnoozesFormat.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String maxSnoozesFormat(int count);

  /// No description provided for @setAlarmTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Alarm Time'**
  String get setAlarmTimeTitle;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @repeatOnce.
  ///
  /// In en, this message translates to:
  /// **'Once'**
  String get repeatOnce;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get repeatDaily;

  /// No description provided for @repeatWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays'**
  String get repeatWeekdays;

  /// No description provided for @repeatWeekends.
  ///
  /// In en, this message translates to:
  /// **'Weekends'**
  String get repeatWeekends;

  /// No description provided for @goodMorningGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good morning!'**
  String get goodMorningGreeting;

  /// No description provided for @loadingQuiz.
  ///
  /// In en, this message translates to:
  /// **'Loading quiz...'**
  String get loadingQuiz;

  /// No description provided for @explanationLabel.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get explanationLabel;

  /// No description provided for @quizCompleteButton.
  ///
  /// In en, this message translates to:
  /// **'Complete Quiz'**
  String get quizCompleteButton;

  /// No description provided for @nextQuestionButton.
  ///
  /// In en, this message translates to:
  /// **'Next Question'**
  String get nextQuestionButton;

  /// No description provided for @scoreDisplay.
  ///
  /// In en, this message translates to:
  /// **'{correct}/{total} correct!'**
  String scoreDisplay(int correct, int total);

  /// No description provided for @quizCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Quiz complete!'**
  String get quizCompletedMessage;

  /// No description provided for @dismissAlarmButton.
  ///
  /// In en, this message translates to:
  /// **'Dismiss Alarm'**
  String get dismissAlarmButton;

  /// No description provided for @trialExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Trial Ended'**
  String get trialExpiredTitle;

  /// No description provided for @trialExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Your free trial (7 days) has expired.\nPlease subscribe to continue using the app.'**
  String get trialExpiredMessage;

  /// No description provided for @restorePurchasesDebug.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases (Debug)'**
  String get restorePurchasesDebug;

  /// No description provided for @subscribeButton.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribeButton;

  /// No description provided for @correctAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Answer: '**
  String get correctAnswerLabel;

  /// No description provided for @hintLabel.
  ///
  /// In en, this message translates to:
  /// **'Hint: {hint}'**
  String hintLabel(String hint);

  /// No description provided for @enterAnswerPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your answer...'**
  String get enterAnswerPlaceholder;

  /// No description provided for @startMissionSlide.
  ///
  /// In en, this message translates to:
  /// **'Start Mission'**
  String get startMissionSlide;

  /// No description provided for @speakInstructions.
  ///
  /// In en, this message translates to:
  /// **'Speak the sentence below in English'**
  String get speakInstructions;

  /// No description provided for @recognizedTextLabel.
  ///
  /// In en, this message translates to:
  /// **'Recognized text:'**
  String get recognizedTextLabel;

  /// No description provided for @similarityPercentage.
  ///
  /// In en, this message translates to:
  /// **'Similarity: {percent}%'**
  String similarityPercentage(String percent);

  /// No description provided for @micNotAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Microphone is not available. Please type your answer instead.'**
  String get micNotAvailableMessage;

  /// No description provided for @enterEnglishPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type in English...'**
  String get enterEnglishPlaceholder;

  /// No description provided for @holdToSpeak.
  ///
  /// In en, this message translates to:
  /// **'Hold to speak'**
  String get holdToSpeak;

  /// No description provided for @typeInsteadButton.
  ///
  /// In en, this message translates to:
  /// **'Type instead'**
  String get typeInsteadButton;

  /// No description provided for @listeningMessage.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listeningMessage;

  /// No description provided for @wordScrambleInstruction.
  ///
  /// In en, this message translates to:
  /// **'Unscramble the word'**
  String get wordScrambleInstruction;

  /// No description provided for @speakingChallengeInstruction.
  ///
  /// In en, this message translates to:
  /// **'Speak the following sentence in English'**
  String get speakingChallengeInstruction;

  /// No description provided for @noAlarmsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the button below to create an English quiz alarm'**
  String get noAlarmsSubtitle;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Another fresh OK-Morning!'**
  String get homeWelcome;

  /// No description provided for @quizInfoFormat.
  ///
  /// In en, this message translates to:
  /// **'{difficulty} {count} questions'**
  String quizInfoFormat(String difficulty, int count);

  /// No description provided for @alarmSoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Alarm Sound'**
  String get alarmSoundTitle;

  /// No description provided for @soundPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to preview, long press to select'**
  String get soundPickerHint;

  /// No description provided for @defaultAlarmSettings.
  ///
  /// In en, this message translates to:
  /// **'Default Alarm Settings'**
  String get defaultAlarmSettings;

  /// No description provided for @defaultQuizCount.
  ///
  /// In en, this message translates to:
  /// **'Default Quiz Count'**
  String get defaultQuizCount;

  /// No description provided for @defaultDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Default Difficulty'**
  String get defaultDifficulty;

  /// No description provided for @defaultSnoozeTime.
  ///
  /// In en, this message translates to:
  /// **'Default Snooze Time'**
  String get defaultSnoozeTime;

  /// No description provided for @missionTypeHeader.
  ///
  /// In en, this message translates to:
  /// **'Mission Type'**
  String get missionTypeHeader;

  /// No description provided for @wordScrambleMission.
  ///
  /// In en, this message translates to:
  /// **'Word Scramble'**
  String get wordScrambleMission;

  /// No description provided for @wordScrambleDescription.
  ///
  /// In en, this message translates to:
  /// **'Unscramble letters to complete words'**
  String get wordScrambleDescription;

  /// No description provided for @speakingChallengeMission.
  ///
  /// In en, this message translates to:
  /// **'Speaking Challenge'**
  String get speakingChallengeMission;

  /// No description provided for @speakingChallengeDescription.
  ///
  /// In en, this message translates to:
  /// **'Say English sentences aloud'**
  String get speakingChallengeDescription;

  /// No description provided for @soundVibrationHeader.
  ///
  /// In en, this message translates to:
  /// **'Sound & Vibration'**
  String get soundVibrationHeader;

  /// No description provided for @vibrationDescription.
  ///
  /// In en, this message translates to:
  /// **'Vibrate when alarm rings'**
  String get vibrationDescription;

  /// No description provided for @gradualVolumeDescription.
  ///
  /// In en, this message translates to:
  /// **'Gradually increase alarm volume'**
  String get gradualVolumeDescription;

  /// No description provided for @subscriptionHeader.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscriptionHeader;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @unlockAllContent.
  ///
  /// In en, this message translates to:
  /// **'Unlock all sounds and questions'**
  String get unlockAllContent;

  /// No description provided for @restorePurchasesLabel.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchasesLabel;

  /// No description provided for @restorePurchasesDescription.
  ///
  /// In en, this message translates to:
  /// **'Restore previous purchases'**
  String get restorePurchasesDescription;

  /// No description provided for @debugPremiumMode.
  ///
  /// In en, this message translates to:
  /// **'[Debug] Premium Mode'**
  String get debugPremiumMode;

  /// No description provided for @debugPremiumEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled - tap to disable'**
  String get debugPremiumEnabled;

  /// No description provided for @debugPremiumDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled - tap to enable'**
  String get debugPremiumDisabled;

  /// No description provided for @aboutHeader.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutHeader;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @licensesLabel.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get licensesLabel;

  /// No description provided for @licensesDescription.
  ///
  /// In en, this message translates to:
  /// **'View open source licenses'**
  String get licensesDescription;

  /// No description provided for @dataHeader.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get dataHeader;

  /// No description provided for @clearProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear Quiz Progress'**
  String get clearProgressLabel;

  /// No description provided for @clearProgressDescription.
  ///
  /// In en, this message translates to:
  /// **'Reset all learning progress'**
  String get clearProgressDescription;

  /// No description provided for @selectLanguageDialog.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguageDialog;

  /// No description provided for @selectQuizCountDialog.
  ///
  /// In en, this message translates to:
  /// **'Default Quiz Count'**
  String get selectQuizCountDialog;

  /// No description provided for @quizCountFormat.
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String quizCountFormat(int count);

  /// No description provided for @selectDifficultyDialog.
  ///
  /// In en, this message translates to:
  /// **'Default Difficulty'**
  String get selectDifficultyDialog;

  /// No description provided for @easyDifficultyDesc.
  ///
  /// In en, this message translates to:
  /// **'Basic vocabulary and grammar'**
  String get easyDifficultyDesc;

  /// No description provided for @mediumDifficultyDesc.
  ///
  /// In en, this message translates to:
  /// **'Intermediate level'**
  String get mediumDifficultyDesc;

  /// No description provided for @hardDifficultyDesc.
  ///
  /// In en, this message translates to:
  /// **'Advanced vocabulary and idioms'**
  String get hardDifficultyDesc;

  /// No description provided for @selectSnoozeDialog.
  ///
  /// In en, this message translates to:
  /// **'Default Snooze Time'**
  String get selectSnoozeDialog;

  /// No description provided for @clearProgressDialog.
  ///
  /// In en, this message translates to:
  /// **'Clear Progress'**
  String get clearProgressDialog;

  /// No description provided for @clearProgressWarning.
  ///
  /// In en, this message translates to:
  /// **'All quiz learning progress will be cleared. This action cannot be undone.'**
  String get clearProgressWarning;

  /// No description provided for @progressClearedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Progress has been cleared'**
  String get progressClearedSnackbar;

  /// No description provided for @resetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButton;

  /// No description provided for @purchasesRestoredSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored!'**
  String get purchasesRestoredSnackbar;

  /// No description provided for @noPurchasesToRestore.
  ///
  /// In en, this message translates to:
  /// **'No purchases to restore'**
  String get noPurchasesToRestore;

  /// No description provided for @unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock Premium'**
  String get unlockPremium;

  /// No description provided for @premiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Make your morning perfect with OK-Morning Pro'**
  String get premiumSubtitle;

  /// No description provided for @feature1Title.
  ///
  /// In en, this message translates to:
  /// **'120 Quiz Questions'**
  String get feature1Title;

  /// No description provided for @feature1Desc.
  ///
  /// In en, this message translates to:
  /// **'Full library across all categories and difficulties'**
  String get feature1Desc;

  /// No description provided for @feature2Title.
  ///
  /// In en, this message translates to:
  /// **'10 Alarm Sounds'**
  String get feature2Title;

  /// No description provided for @feature2Desc.
  ///
  /// In en, this message translates to:
  /// **'Premium sounds: ocean waves, piano, jazz & more'**
  String get feature2Desc;

  /// No description provided for @feature3Title.
  ///
  /// In en, this message translates to:
  /// **'Advanced Learning'**
  String get feature3Title;

  /// No description provided for @feature3Desc.
  ///
  /// In en, this message translates to:
  /// **'Personalized quizzes focused on your weak areas'**
  String get feature3Desc;

  /// No description provided for @feature4Title.
  ///
  /// In en, this message translates to:
  /// **'New Content Updates'**
  String get feature4Title;

  /// No description provided for @feature4Desc.
  ///
  /// In en, this message translates to:
  /// **'Regular new questions and sound additions'**
  String get feature4Desc;

  /// No description provided for @subscribeNowButton.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Now'**
  String get subscribeNowButton;

  /// No description provided for @startTrialButton.
  ///
  /// In en, this message translates to:
  /// **'Start Free Trial'**
  String get startTrialButton;

  /// No description provided for @subscriptionTerms.
  ///
  /// In en, this message translates to:
  /// **'Subscription automatically renews unless canceled at least 24 hours before the end of the current period. You can manage your subscription in device settings.'**
  String get subscriptionTerms;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @premiumMonthlyPlan.
  ///
  /// In en, this message translates to:
  /// **'Premium Monthly'**
  String get premiumMonthlyPlan;

  /// No description provided for @premiumMonthlyPrice.
  ///
  /// In en, this message translates to:
  /// **'{price}/mo'**
  String premiumMonthlyPrice(String price);

  /// No description provided for @trialIncluded.
  ///
  /// In en, this message translates to:
  /// **'Includes 7-day free trial'**
  String get trialIncluded;

  /// No description provided for @welcomeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Premium!'**
  String get welcomeToPremium;

  /// No description provided for @purchasesRestored.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored!'**
  String get purchasesRestored;

  /// No description provided for @morningStreak.
  ///
  /// In en, this message translates to:
  /// **'Morning Streak'**
  String get morningStreak;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count}-Day Streak!'**
  String streakDays(int count);

  /// No description provided for @streakRecord.
  ///
  /// In en, this message translates to:
  /// **'Record: {count}'**
  String streakRecord(int count);

  /// No description provided for @streakNewRecord.
  ///
  /// In en, this message translates to:
  /// **'New Record!'**
  String get streakNewRecord;

  /// No description provided for @streakStart.
  ///
  /// In en, this message translates to:
  /// **'Start your streak!'**
  String get streakStart;

  /// No description provided for @completedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed today'**
  String get completedToday;

  /// No description provided for @premiumStatus.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premiumStatus;

  /// No description provided for @premiumAllContent.
  ///
  /// In en, this message translates to:
  /// **'All content available'**
  String get premiumAllContent;

  /// No description provided for @freeTrialStatus.
  ///
  /// In en, this message translates to:
  /// **'Free Trial'**
  String get freeTrialStatus;

  /// No description provided for @trialDaysRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} days remaining'**
  String trialDaysRemaining(int count);

  /// No description provided for @freePlanStatus.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get freePlanStatus;

  /// No description provided for @freePlanLimits.
  ///
  /// In en, this message translates to:
  /// **'30 questions, 3 sounds'**
  String get freePlanLimits;

  /// No description provided for @upgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgradeButton;

  /// No description provided for @xpEarned.
  ///
  /// In en, this message translates to:
  /// **'+{xp} XP'**
  String xpEarned(int xp);

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String levelLabel(int level);

  /// No description provided for @xpToNext.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP to next level'**
  String xpToNext(int xp);

  /// No description provided for @totalXpLabel.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP total'**
  String totalXpLabel(int xp);

  /// No description provided for @levelUpMessage.
  ///
  /// In en, this message translates to:
  /// **'Level Up! Lv.{level}'**
  String levelUpMessage(int level);

  /// No description provided for @masteredCount.
  ///
  /// In en, this message translates to:
  /// **'{count} mastered'**
  String masteredCount(int count);

  /// No description provided for @devForceSeedDb.
  ///
  /// In en, this message translates to:
  /// **'DEV: Force Seed DB'**
  String get devForceSeedDb;

  /// No description provided for @devForceSeedDbDesc.
  ///
  /// In en, this message translates to:
  /// **'Re-seed vocabulary from bundled JSON'**
  String get devForceSeedDbDesc;

  /// No description provided for @devSeedComplete.
  ///
  /// In en, this message translates to:
  /// **'Seeded {count} items into DB'**
  String devSeedComplete(int count);

  /// No description provided for @xpLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress Locked'**
  String get xpLockedTitle;

  /// No description provided for @xpLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your trial has ended. XP and progress cannot be saved.'**
  String get xpLockedMessage;

  /// No description provided for @xpLockedSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to Keep Growing'**
  String get xpLockedSubscribe;

  /// No description provided for @xpLockedFomo.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to OK-Morning Pro to keep leveling up.'**
  String get xpLockedFomo;

  /// No description provided for @dismissAlarmOnly.
  ///
  /// In en, this message translates to:
  /// **'Just Dismiss Alarm'**
  String get dismissAlarmOnly;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'A fresh morning,\nOK-Morning!'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start each morning brighter with English'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingValueTitle.
  ///
  /// In en, this message translates to:
  /// **'Your alarm won\'t stop\nuntil you solve English!'**
  String get onboardingValueTitle;

  /// No description provided for @onboardingValueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Level up every morning.\nGrow your English while waking up.'**
  String get onboardingValueSubtitle;

  /// No description provided for @onboardingPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Just two permissions\nfor a perfect morning'**
  String get onboardingPermissionsTitle;

  /// No description provided for @onboardingPermissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We need these to ring your alarm and hear your voice.'**
  String get onboardingPermissionsSubtitle;

  /// No description provided for @onboardingNotificationBtn.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications'**
  String get onboardingNotificationBtn;

  /// No description provided for @onboardingMicrophoneBtn.
  ///
  /// In en, this message translates to:
  /// **'Allow Microphone'**
  String get onboardingMicrophoneBtn;

  /// No description provided for @onboardingPermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Granted'**
  String get onboardingPermissionGranted;

  /// No description provided for @onboardingCtaTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re all set!'**
  String get onboardingCtaTitle;

  /// No description provided for @onboardingCtaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set your first alarm and start growing tomorrow morning.'**
  String get onboardingCtaSubtitle;

  /// No description provided for @onboardingCtaButton.
  ///
  /// In en, this message translates to:
  /// **'Set My First Alarm'**
  String get onboardingCtaButton;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
