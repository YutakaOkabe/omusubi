import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:omusubi/board.dart';
import 'package:omusubi/provider.dart';
import 'package:collection/collection.dart';

class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key); // コンストラクタをここで定義
  OmusubiGame game;

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  Map row1 = {
    "nori": "images/nori.png",
    "tarako": "images/tarako.png",
    "mame": "images/mame.png",
    "yukari": "images/yukari.png",
  };
  Map row2 = {
    "konbu": "images/konbu.png",
    "tuna": "images/tuna.png",
    "ikura": "images/ikura.png",
    "ume": "images/ume.png",
  };
  List row3 = ["DELETE", "SUBMIT"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(OmusubiGame.game_message,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 20.0),
        GameBoard(widget.game),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1.keys
              .map((e) => InkWell(
                    onTap: () {
                      // letterIdが最後まで行ってなかったら入力可
                      if (widget.game.letterId < 5) {
                        setState(() {
                          widget.game.insertWord(
                              widget.game.letterId, Letter(e, row1[e], 0));
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
          children: row2.keys
              .map((e) => InkWell(
                    onTap: () {
                      if (widget.game.letterId < 5) {
                        setState(() {
                          widget.game.insertWord(
                              widget.game.letterId, Letter(e, row2[e], 0));
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
                      if (e == 'DELETE') {
                        if (widget.game.letterId > 0) {
                          setState(() {
                            widget.game.insertWord(
                                widget.game.letterId - 1, Letter("", "", 0));
                            widget.game.letterId--;
                          });
                        }
                      } else if (e == 'SUBMIT') {
                        if (widget.game.letterId >= 5) {
                          List guess = widget
                              .game.wordleBoard[widget.game.rowId]
                              .map((e) => e.letter)
                              .toList();
                          print('guess: ${guess}');
                          print('answer: ${OmusubiGame.game_guess}');

                          Function isEqual = const ListEquality().equals;
                          if (isEqual(guess, OmusubiGame.game_guess)) {
                            // 目標値と完全一致
                            setState(() {
                              OmusubiGame.game_message = "Congratulations!👏👏";
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
                              String gu = guess[i];
                              print(gu);
                              if (OmusubiGame.game_guess.contains(gu)) {
                                if (OmusubiGame.game_guess[i] == gu) {
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
                          setState(() {
                            OmusubiGame.game_message = "おにぎりが足りません";
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
