import 'dart:math';

class OmusubiGame {
  int rowId = 0; // 入力中の行番号
  int letterId = 0; // 入力中の列番号

// どのクラスから呼ばれても一意なのでstatic
  static String game_message = ""; // ユーザーに表示するメッセージ
  static String game_guess = ""; // 目標値

  static List<String> word_list = [
    "WORLD",
    "FIGHT",
    "BRAIN",
    "PLANE",
    "EARTH",
    "ROBOT"
  ];
  // wordleBoard[row][letterId] = Letterクラス
  List<List<Letter>> wordleBoard = List.generate(
      5, (index) => List.generate(5, ((index) => Letter("", 0)))); // 文字を入力するボード

  static void initGame() {
    final random = new Random();
    int index = random.nextInt(word_list.length); // 0以上length未満の整数値を作成
    game_guess = word_list[index];
  }

  void insertWord(index, word) {
    wordleBoard[rowId][index] = word;
  }

  // bool checkWordExist(String word) {
  //   return word_list.contains(word);
  // }
}

class Letter {
  String? letter; // 入力された文字列を保持
  int code = 0; // 一致状態を保持 不一致:0 場所まで一致:1 文字が存在:2
  Letter(this.letter, this.code); // コンストラクタ
}
