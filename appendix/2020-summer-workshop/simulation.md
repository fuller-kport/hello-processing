# 物体のシミュレーション

## クラスを準備

まず，`Bird` クラスを定義します。（今回は鳥の群れをシミュレートすることをゴールにしているので）

```java
class Bird {
  PVector position; // 位置
  PVector velocity; // 速度
  PVector acceleration; // 加速度

  Bird(PVector position) {
    this.position = position;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
  }
}
```

位置，速度，加速度のベクトルをそれぞれ持っています。コンストラクタに位置を指定できるようにしました。速度と加速度はゼロベクトルで初期化されます。

次に，状態を更新する `update()` メソッドと，キャンバスへの描画を行う `render()` メソッドを定義します。

```java
class Bird {
  // 省力...

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
  }

  void render() {
    circle(position.x, position.y, 20);
  }
}
```

外側から力を加えて操作できるように，`applyForce()` メソッドも定義します。

```java
void applyForce(PVector f) {
  acceleration.set(f);
}
```

ここまでの `Bird` クラスは以下のようになります。

```java
class Bird {
  PVector position;
  PVector velocity;
  PVector acceleration;

  Bird(PVector position, PVector velocity) {
    this.position = position;
    this.velocity = velocity;
    this.acceleration = new PVector(0, 0);
  }

  void applyForce(PVector f) {
    acceleration.set(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
  }

  void render() {
    circle(position.x, position.y, 20);
  }
}
```

下向きに力を加えることで落下の動きをシミュレートします。

```java
Bird b;

void setup() {
  size(500, 500);
  PVector p = new PVector(width / 2, height / 2);
  b = new Bird(p);
}

void draw() {
  background(0);
  PVector g = new PVector(0, 0.5);
  b.applyForce(g);
  b.update();
  b.render();
}
```

- **演習**：マウスの位置と `Bird` の位置の距離を利用してバネのような動きを作ってみましょう。

```java
Bird b;

void setup() {
  size(500, 500);
  PVector p = new PVector(width / 2, height / 2);
  b = new Bird(p);
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
