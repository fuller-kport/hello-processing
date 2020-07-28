# 再帰

これまでいくつかの関数を紹介してきました。ある関数の中でその関数を呼び出した場合，一体どうなるでしょうか。

```java
void hoge() {
  hoge();
}
```

関数 `hoge()` は自分自身を呼び出しています。このように，自分自身を呼び出す関数を「**再帰関数**」といいます。

しかし上記のコードは無限に自分自身を呼び出し続けて PC のリソースを消費し続けますので実行しないで下さい。安全に再帰を利用するには，有限回で終了するような工夫が必要です。

```java
void hoge(int n) {
  if (n != 0) {
    hoge(n - 1);
  }
}
```

上のように `n` を 1 つずつ減らしながら呼び出して，`n` が 0 になったら呼び出しをスキップするようにすると再帰呼び出しは n 回でストップします。

再帰を利用して円を繰り返し描画してみます。以下のコードを実行して下さい。

```java
void setup() {
  size(500, 500);
  noLoop();
}

void draw() {
  drawCircle(width / 2, height / 2, 500);
}

void drawCircle(float x, float y, float diameter) {
  circle(x, y, diameter);
  if(diameter > 2) {
    drawCircle(x, y, 0.75 * diameter);
  }
}
```

正方形を繰り返し描画してみます。以下のコードを実行して下さい。

```java
void setup() {
  size(500, 500);
  noLoop();
}

void draw() {
  recursiveSquare(0, 0, 500, 5);
}

void recursiveSquare(float x, float y, float s, int n) {
  if (n == 0) {
    return;
  }

  float hs = s / 2;

  square(x, y, hs);
  square(x + hs, y, hs);
  square(x, y + hs, hs);
  square(x + hs, y + hs, hs);

  recursiveSquare(x, y, hs, n - 1);
}
```

木を描画する。

```java
void setup() {
  size(500, 500);
  background(255);
  noLoop();
}

void draw() {
  translate(width / 2, height);
  branch(100);
}

void branch(float len) {
  line(0, 0, 0, -len);
  translate(0, -len);

  float l = len * 0.75;

  if (l < 10) {
    return;
  }

  push();
  rotate(PI / 6);
  line(0, 0, 0, -l);
  branch(l);
  pop();

  push();
  rotate(-PI / 6);
  line(0, 0, 0, -l);
  branch(l);
  pop();
}
```

色々試してみましょう。
