# 変数

変数の使い方を学びます。変数とは，値を一時的に保持するための仕組みです。

## 宣言，初期化，代入

次のプログラムでは，`x` と `y` という 2 つの変数を宣言しています。いずれも `0` で初期化して， `draw()` 関数で使用しています。

```java
float x = 0; // xを宣言して0で初期化
float y = 0; // yを宣言して0で初期化

void setup() {
  size(500, 500);
}

void draw() {
  circle(x, y, 80); // ここでxとy使う
}
```

`setup()` 関数で `x` と `y` に値を代入してみます。

```java
float x = 0;
float y = 0;

void setup() {
  x = 100; // xに100を代入
  y = 200; // yに200を代入
  size(500, 500);
}

void draw() {
  circle(x, y, 80);
}
```

`x` と `y` に好きな値を代入して結果を確認してみて下さい。

## 変数の型

変数には**型**があります。Processing に用意されている主な型をみていきます。

次のプログラムをみて下さい。

```java
int n = 30; // 整数型 n
float l = 22.5; // 浮動小数点数型 f
color col = color(155, 120, 80); // 色型 col

void setup() {
  size(500, 500);
}

void draw() {
  background(col);

  // 整数型 i
  for (int i = 0; i < n; i++) {

    // 真偽値型 isEvenNumber
    boolean isEvenNumber = i % 2 == 0;

    if (isEvenNumber) {
      // 浮動小数点数型 x, y
      float x = i * 10;
      float y = i * 10;
      circle(x, y, l);
    }
  }
}
```

このブログラムは，キャンバスの対角線上に大きさ `l` の円を `n` 個描画するプログラムです。

プログラムの先頭で，[整数型](https://processing.org/reference/int.html)，[浮動小数点数型](https://processing.org/reference/float.html)と[色型](https://processing.org/reference/color_datatype.html)の変数を宣言・初期化しています。

変数は，関数の中で宣言することも出来ます。上の例では，[真偽値型](https://processing.org/reference/boolean.html) の変数 `isEvenNumber` を使っています。

文字を表現する [`文字型`](https://processing.org/reference/char.html)を使ってプログラムを少し変更してみます。

```java
int n = 30;
float l = 22.5;
color col = color(155, 120, 80);
char plus = '+'; // 文字型

void setup() {
  size(500, 500);
}

void draw() {
  background(col);

  for (int i = 0; i < n; i++) {

    boolean isEvenNumber = i % 2 == 0;

    if (isEvenNumber) {
      float x = i * 10;
      float y = i * 10;
      circle(x, y, l);
    }
  }
}

void keyPressed() {
  // 文字がplusだった場合，nに1を足す
  if (key == plus) {
    n = n + 1;
  }
}
```
