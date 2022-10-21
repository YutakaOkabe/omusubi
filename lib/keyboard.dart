import 'package:flutter/material.dart';
import 'package:omusubi/board.dart';
import 'package:omusubi/provider.dart';

class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key); // コンストラクタをここで定義
  OmusubiGame game;

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  List row1 = "QWERTYUIOP".split("");
  List row2 = "ASDFGHJKL".split("");
  List row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  @override
  Widget build(BuildContext context) {
    print('message: ${OmusubiGame.game_message}');
    return Column(
      children: [
        Text(OmusubiGame.game_message,
            style: const TextStyle(color: Colors.black)),
        const SizedBox(height: 20.0),
        GameBoard(widget.game),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1
              .map((e) => InkWell(
                    onTap: () {
                      print(e);
                      // letterIdが最後まで行ってなかったら入力可
                      if (widget.game.letterId < 5) {
                        setState(() {
                          widget.game
                              .insertWord(widget.game.letterId, Letter(e, 0));
                          widget.game.letterId++;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "$e",
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2
              .map((e) => InkWell(
                    onTap: () {
                      print(e);
                      if (widget.game.letterId < 5) {
                        setState(() {
                          widget.game
                              .insertWord(widget.game.letterId, Letter(e, 0));
                          widget.game.letterId++;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "${e}",
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3
              .map((e) => InkWell(
                    onTap: () {
                      print(e);
                      if (e == 'DEL') {
                        if (widget.game.letterId > 0) {
                          setState(() {
                            widget.game.insertWord(
                                widget.game.letterId - 1, Letter("", 0));
                            widget.game.letterId--;
                          });
                        }
                      } else if (e == 'SUBMIT') {
                        print('letterId: ${widget.game.letterId}');
                        if (widget.game.letterId >= 5) {
                          String guess = widget
                              .game.wordleBoard[widget.game.rowId]
                              .map((e) => e.letter)
                              .join(); // ユーザーが推測した文字列
                          print('guess: ${guess}');
                          if (guess == OmusubiGame.game_guess) {
                            // 目標値と完全一致
                            setState(() {
                              OmusubiGame.game_message = "Congratulations!";
                              widget.game.wordleBoard[widget.game.rowId]
                                  .forEach((element) {
                                element.code = 1;
                              });
                            });
                          } else {
                            // 目標値と不一致
                            int listLength = guess.length;
                            bool findAtLeastOne = false;
                            for (int i = 0; i < listLength; i++) {
                              // ユーザーが推測した1文字1文字を検証する
                              String char = guess[i];
                              print(char);
                              if (OmusubiGame.game_guess.contains(char)) {
                                if (OmusubiGame.game_guess[i] == char) {
                                  // 場所まで一致している場合
                                  setState(() {
                                    widget
                                        .game
                                        .wordleBoard[widget.game.rowId][i]
                                        .code = 1;
                                  });
                                } else {
                                  // 文字だけ存在している場合
                                  setState(() {
                                    widget
                                        .game
                                        .wordleBoard[widget.game.rowId][i]
                                        .code = 2;
                                  });
                                }
                                setState(() {
                                  OmusubiGame.game_message = "いい感じに絞れてるよ！";
                                });
                                findAtLeastOne = true;
                              }
                            }
                            // 1文字も掠ってない場合
                            if (!findAtLeastOne) {
                              setState(() {
                                OmusubiGame.game_message = "センス悪いね";
                              });
                            }
                            // 次の行の最初の文字からスタート
                            widget.game.rowId++;
                            widget.game.letterId = 0;
                          }
                        } else {
                          OmusubiGame.game_message = "文字数が足りません";
                        }
                      } else {
                        if (widget.game.letterId < 5) {
                          setState(() {
                            widget.game
                                .insertWord(widget.game.letterId, Letter(e, 0));
                            widget.game.letterId++;
                          });
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "${e}",
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
