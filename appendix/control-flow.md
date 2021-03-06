# 制御構文

プログラミングの制御構文を使いましょう。

## `if` で条件分岐

次のプログラムを実行してみてください。

```java
void setup() {
  size(500, 500);
}

void draw() {
  if (mouseX > 250) {
    background(255, 255, 255);
  } else {
    background(0, 0, 0);
  }
}
```

ここでは `if` を使って背景色の切り替えを行っています。マウスの位置が半分よりも右側であれば白背景，それ以外の場合は黒背景に塗りつぶしています。

もう少しじっくり見てみます。if 文は次のような形をしています。

```java
if (条件式) {
  // 条件式を満たす場合にのみ実行される箇所
}
```

条件式を満たさない場合の処理も記述したい場合には `else` を使います。

```java
if (条件式) {
  // 条件式を満たす場合にのみ実行される箇所
} else {
  // 条件式を満たさない場合にのみ実行される箇所
}
```

`else` に続けて `if` を書くことで，より複雑な分岐を作ることができます。

```java
if (条件式1) {
  // 条件式1を満たす場合に実行
} else if (条件式2) {
  // 条件式1を満たさないが条件式2を満たす場合に実行
} else {
  // それ以外，つまり条件式1も条件式2もどちらも満たさない場合に実行
}
```

"条件式" の書き方には様々な種類があります。基本的なものは以下にまとめます。

| 条件式   | 説明                    |
| -------- | ----------------------- |
| `x == y` | `x` と `y` は等しい     |
| `x != y` | `x` と `y` は等しくない |
| `x < y`  | `x` は `y` 未満         |
| `x > y`  | `x` は `y` より大きい   |
| `x <= y` | `x` は `y` 以下         |
| `x >= y` | `x` は `y` 以上         |

条件式を組み合わせるには"論理演算子"を使います。

```java
if (mouseX >= 100 && mouseX <= 300) {
  // マウスのX値が100以上かつ300以下の場合に実行
}
```

```java
if (mouseX <= 50 || mouseX >= 400) {
  // マウスのX値が50以下または400以上の場合に実行
}
```

上の例の `&&` と `||` が論理演算子です。これらを使ってプログラムを書いてみます。

```java
void setup() {
  size(500, 500);
}

void draw() {
  if (mouseX > 250 && mouseY > 250) {
    background(255, 0, 0);
  } else if (mouseX > 250 && mouseY <= 250) {
    background(0, 255, 0);
  } else if (mouseX <= 250 && mouseY <= 250) {
    background(0, 0, 255);
  } else {
    background(0, 0, 0);
  }
}
```

## `for` で繰り返し

繰り返し処理を行うには `for` を使います。

まずは以下のプログラムを実行してみて下さい。

```java
void setup() {
  for (int i = 0; i < 3; i++) {
    println("Hello!");
  }
}
```

コンソールエリアに "Hello!" という文字列が 3 回出力されたら成功です。

`for` の文法は以下のようになっています。

```java
for ( 初期化式 ; 継続条件式 ; 更新式) {
  // 繰り返したい処理
}
```

`for` を使ったコードを書いてみます。以下のプログラムを実行してみて下さい。

```java
void setup() {
  size(500, 500);

  for (int i = 0; i < 3; i++) {
    float x = random(500);
    float y = random(500);
    circle(x, y, 100);
  }
}
```

このプログラムは，500 × 500 のキャンバス上のランダムな位置に円を 3 つ繰り返して描画します。

以下の [`random()`](https://processing.org/reference/random_.html) はランダムな数値を取得するための関数です。ここでは 0 ~ 500 までの範囲でランダムな数値を取得しています。

```java
float x = random(500);
```

以下の演習に挑戦してみて下さい。

1. 円の数を 3 つではなく 100 個に増やしてみて下さい。
2. 円の大きさをランダムにしてみて下さい。

解答例)

```java
void setup() {
  size(500, 500);

  for (int i = 0; i < 100; i++) {
    float x = random(500);
    float y = random(500);
    float d = random(100);
    circle(x, y, d);
  }
}
```

3. 円の色をランダムにして下さい。

解答例 1)

```java
void setup() {
  size(500, 500);

  for (int i = 0; i < 100; i++) {
    float x = random(500);
    float y = random(500);

    float r = random(255);
    float g = random(255);
    float b = random(255);
    fill(r, g, b);

    circle(x, y, 100);
  }
}
```

解答例 2)

```java
void setup() {
  size(500, 500);

  colorMode(HSB, 360, 100, 100); // HSBカラー

  for (int i = 0; i < 100; i++) {
    float x = random(500);
    float y = random(500);

    float hue = random(180, 240); // 180 ~ 240のランダム値
    fill(hue, 80, 100);

    circle(x, y, 100);
  }
}
```

4. 下の画像のように正方形を敷き詰めてみて下さい。

<img src="../assets/images/grid.png" alt="grid" width="120px">

解答例)

```java
void setup() {
  size(500, 500);

  float step = 100;

  for (float x = 0; x < width; x += step) {
    for (float y = 0; y < height; y += step) {
      square(x, y, step);
    }
  }
}
```

5. 下の画像のように円を敷き詰めてみて下さい。

<img src="../assets/images/circles.png" alt="circles" width="120px">

解答例)

```java
void setup() {
  size(500, 500);

  float step = 100;

  for (float x = 0; x < width; x += step) {
    for (float y = 0; y < height; y += step) {
      float r = step / 2;
      circle(x + r, y + r, step);
    }
  }
}
```
