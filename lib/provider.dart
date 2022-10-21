import 'dart:math';

class OmusubiGame {
  int rowId = 0; // 入力中の行番号
  int letterId = 0; // 入力中の列番号

// どのクラスから呼ばれても一意なのでstatic
  static String game_message = ""; // ユーザーに表示するメッセージ
  static List game_guess = []; // 目標値

// TODO: リストからランダムに具を選ぶ
  static List<String> word_list = [
    "nori",
    "tarako",
    "mame",
    "yukari",
    "konbu",
    "tuna",
    "ikura",
    "ume"
  ];
  // wordleBoard[row][letterId] = Letterクラス
  List<List<Letter>> wordleBoard = List.generate(
      5,
      (index) =>
          List.generate(5, ((index) => Letter("", "", 0)))); // 文字を入力するボード

  static void initGame() {
    final random = new Random();
    for (int i = 0; i < 5; i++) {
      int index = random.nextInt(word_list.length); // 0以上length未満の整数値を作成
      game_guess.add(word_list[index]);
    }
  }

  void insertWord(index, word) {
    wordleBoard[rowId][index] = word;
  }
}

class Letter {
  String? letter; // 入力された文字列を保持
  String icon; // 入力された文字列を保持
  int code = 0; // 一致状態を保持 不一致:0 場所まで一致:1 文字が存在:2
  Letter(this.letter, this.icon, this.code); // コンストラクタ
}
