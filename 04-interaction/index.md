# インタラクション

マウスやキーボードなどのユーザ操作をプログラムで扱う方法を学びます。

## マウス

これまでも既に使用してきましたが， `mouseX` と `mouseY` を使うと現在のマウスの座標値にアクセスできます。

```java
void setup() {
  size(500, 500);
}

void draw() {
  background(0, 0, 0);
  circle(mouseX, mouseY, 10);
}
```

マウスがクリックされたことを検知するには [`mouseClicked()`](https://processing.org/reference/mouseClicked_.html) 関数を使います。

以下はクリックされる度にキャンバスの背景色が赤くなっていくプログラムです。

```java
int redValue = 0;

void setup() {
  size(500, 500);
}

void draw() {
  background(redValue, 0, 0);
}

void mouseClicked() {
  redValue = redValue + 10;
}
```

左クリックと右クリックを見分けることもできます。[`mouseButton`](https://processing.org/reference/mouseButton.html) というシステム変数が `LEFT` と等しければ左クリック，`RIGHT` と等しければ右クリックです。

右クリックされたときは赤い背景色を黒に近づけてみます。

```java
int redValue = 0;

void setup() {
  size(500, 500);
}

void draw() {
  background(redValue, 0, 0);
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    redValue = redValue + 10;
  } else if (mouseButton == RIGHT) {
    redValue = redValue - 10;
  }
}
```

マウスクリックのイベントをもう少し詳しく検知する方法もあります。クリックが開始されたとき，離したときをそれぞれ検知したい場合は，[`mousePressed()`](https://processing.org/reference/mousePressed_.html) と [`mouseReleased()`](https://processing.org/reference/mouseReleased_.html) を使います。

以下のコードを実行してみてください。マウスクリックを押した位置と離した位置がそれぞれ取得できていることがわかります。

```java
float pressedX = 0.0;
float pressedY = 0.0;
float releasedX = 0.0;
float releasedY = 0.0;

void setup() {
  size(500, 500);
}

void draw() {
  background(0, 0, 0);

  stroke(255, 255, 255);
  line(pressedX, pressedY, releasedX, releasedY);

  noStroke();
  fill(255, 0, 255);
  circle(pressedX, pressedY, 50);

  noStroke();
  fill(0, 255, 255);
  circle(releasedX, releasedY, 50);
}

void mousePressed() {
  pressedX = mouseX;
  pressedY = mouseY;
}

void mouseReleased() {
  releasedX = mouseX;
  releasedY = mouseY;
}
```

演習として，以下のように動作するコードを書いてみてください。

<img src="../assets/images/mouse-demo.gif" alt="Mouse demo" width="250px">

## キーボード
