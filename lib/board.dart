import 'package:flutter/material.dart';
import 'package:omusubi/provider.dart';

class GameBoard extends StatefulWidget {
  GameBoard(this.game, {Key? key}) : super(key: key);
  OmusubiGame game;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.game.wordleBoard
          .map((e) => Row(
                // 1行分
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: e
                    .map((e) => Container(
                        // 1文字分
                        padding: const EdgeInsets.all(16.0),
                        width: 64,
                        height: 64,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: e.code == 0
                              ? Colors.grey.shade400
                              : e.code == 1
                                  ? Colors.green.shade400 // 場所まで一致
                                  : Colors.amber.shade400, // 文字が存在
                        ),
                        child: Center(
                          child: Text(
                            e.letter!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        )))
                    .toList(),
              ))
          .toList(),
    );
  }
}
