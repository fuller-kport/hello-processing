# 物体のシミュレーション

## クラスを準備

まず，`Ball` クラスを定義します。

```java
class Ball {
  PVector position; // 位置
  PVector velocity; // 速度
  PVector acceleration; // 加速度

  Ball(PVector position) {
    this.position = position;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
  }
}
```

位置，速度，加速度のベクトルをそれぞれ持っています。コンストラクタに位置を指定できるようにしました。速度と加速度はゼロベクトルで初期化されます。

次に，状態を更新する `update()` メソッドと，キャンバスへの描画を行う `render()` メソッドを定義します。

```java
class Ball {
  // 省略...

  void update() {
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.set(0, 0); // 加速度を 0 にリセット
  }

  void render() {
    circle(position.x, position.y, 20);
  }
}
```

外側から力を加えて操作できるように，`applyForce()` メソッドも定義します。

```java
void applyForce(PVector f) {
  acceleration.add(f); // F = ma の m = 1 に相当する
}
```

ここまでの `Ball` クラスは以下のようになります。

```java
class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;

  Ball(PVector position) {
    this.position = position;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.set(0, 0); // 加速度を 0 にリセット
  }

  void render() {
    circle(position.x, position.y, 20);
  }
}
```

下向きに力を加えることで落下の動きをシミュレートします。

```java
Ball b;

void setup() {
  size(500, 500);
  PVector p = new PVector(width / 2, height / 2);
  b = new Ball(p);
}

void draw() {
  background(0);
  PVector g = new PVector(0, 0.5);
  b.applyForce(g);
  b.update();
  b.render();
}
```

- **演習 1**：`Ball` クラスに速度の最大値 `maxSpeed` プロパティを追加しましょう。
- **演習 2**：マウスの位置と `Ball` の位置の距離を利用してバネのような動きを作ってみましょう。

```java
Ball b;

void setup() {
  size(500, 500);
  PVector p = new PVector(width / 2, height / 2);
  b = new Ball(p);
}

void draw() {
  background(0);
  PVector mouse = new PVector(mouseX, mouseY);
  PVector l = PVector.sub(b.position, mouse);
  l.mult(-1);
  l.limit(1);
  b.applyForce(l);
  b.update();
  b.render();
}
```

## ステアリング (Steering)

ここでは [The Nature of Code](https://natureofcode.com/book/chapter-6-autonomous-agents/#63-the-steering-force:~:text=6.3%20The%20Steering%20Force) の内容に沿ってステアリング (Steering)について見ていきます。

> steering force = desired velocity - current velocity

(ステアリング力ベクトル) = (理想的な速度ベクトル) - (速度ベクトル)

上記の式が表すのは，ステアリングに必要な力です。この力を `Ball` に加える `seek()` メソッドを追加します。

**Ball**

```java
class Ball {
  // 省略...

  void seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxSpeed);

    PVector steer = PVector.sub(desired, velocity);
    applyForce(steer);
  }
}
```

**sketch**

```java
Ball b;

void setup() {
  size(500, 500);
  PVector p = new PVector(width / 2, height / 2);
  b = new Ball(p);
}

void draw() {
  background(0);
  PVector mouse = new PVector(mouseX, mouseY);
  b.seek(mouse);
  b.update();
  b.render();
}
```

ステアリングによってマウスの位置を追跡する挙動を確認できたでしょうか。
現時点ではマウスの位置を通り過ぎて行ったり来たりを繰り返しています。`desired` ベクトルが常に最高速度と同じ大きさに設定されているためです。マウスの位置で停止するように `seek()` メソッドを変更してみましょう。

```java
class Ball {
  // 省略...

  void seek(PVector target) {
    PVector dist = PVector.sub(target, position); // targetとの距離ベクトル
    float d = dist.mag(); // 距離の大きさ

    dist.normalize();
    if (d < 100) {
      float m = map(d, 0, 100, 0, maxSpeed);
      dist.mult(m);
    } else {
      dist.mult(maxSpeed);
    }

    PVector steer = PVector.sub(dist, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
}
```
