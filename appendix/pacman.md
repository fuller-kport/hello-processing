# パックマンをつくるには

## ヒット判定について

物体と物体がぶつかったかどうかを判定するためのコードをみていきます。

```java
// プレイヤー
float selfX = 0.0;
float selfY = 0.0;
float selfSize = 20;

// ドット（プレイヤーが食べるやつ）
float dotX = 250;
float dotY = 250;
float dotSize = 100;

float threshould = 60;
boolean hit = false;

void setup() {
  size(500, 500);
}

void draw() {
  background(0, 0, 0);

  selfX = mouseX;
  selfY = mouseY;

  float dist = sqrt(sq(dotX - selfX) + sq(dotY - selfY));
  hit = dist < threshould;
  if (hit) {
    // ヒットしたらドットをランダムな場所に移動
    dotX = random(width);
    dotY = random(height);
  }

  // player
  circle(selfX, selfY, selfSize);

  // dot
  if (!hit) {
    circle(dotX, dotY, dotSize);
  }
}
```

---

TBD
