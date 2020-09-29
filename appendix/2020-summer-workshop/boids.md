# 群れのシミュレーション

夕方に空を見上げると鳥の大群を見ることがあります。群れが二手に別れたり一つに合併したりしながら空を飛び回っているのを見たことがあるかもしれません。
今回は「群れ」をシミュレートするプログラムを通じて様々なことを学んでいきましょう。

ここでも [The Nature of Code](https://natureofcode.com/book/chapter-6-autonomous-agents/#63-the-steering-force:~:text=6.3%20The%20Steering%20Force) の内容を大いに参考にしています。

## ボイドモデル

「群れ」のシミュレーションにおいては，1986 年にクレイグ・レイノルズが提案した「ボイド（Boid）」というモデルが有名です。

<iframe width="560" height="315" src="https://www.youtube.com/embed/3bTqWsVqyzE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Boid クラスの用意

Boid とは "bird-oid" すなわち「鳥っぽいもの」という意味の造語だそうです。まずは `Boid` クラスをつくります。

```java
class Boid {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r = 3.0;
  float maxForce = 0.05;
  float maxSpeed = 3;

  Boid(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(random(-1, 1),random(-1, 1));
    acceleration = new PVector(0, 0);
  }
}
```

次に，`render()` メソッドを追加しましょう。

```java
class Boid {
  // ...省略

  void render() {
    float theta = velocity.heading() + HALF_PI;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r * 2);
    vertex(-r, r * 2);
    vertex(r, r * 2);
    endShape();
    popMatrix();
  }
}
```

三角形が速度ベクトルの方向を向くように`theta` を調整しています。`render()` メソッドを試してみましょう。

```java
Boid b;

void setup() {
  size(500, 500);
  b = new Boid(width / 2, height / 2);
}

void draw() {
  background(255);
  b.render();
}
```

`applyForce()`, `update()` と `seek()` メソッドもまとめて追加してしまいます。

```java
class Boid {
  // ...省略

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.set(0, 0);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
```

境界条件のための `border()` メソッドも追加します。

```java
class Boid {
  // ...省略

  void borders() {
    if (position.x + r < 0) {
      position.x = width + r;
    }
    if (position.y + r < 0) {
      position.y = height + r;
    }
    if (position.x - r > width) {
      position.x = -r;
    }
    if (position.y - r > height) {
      position.y = -r;
    }
  }
}
```

ここまでで `Boid` を動かしてみましょう。

```java
Boid b;

void setup() {
  size(500, 500);
  b = new Boid(width / 2, height / 2);
}

void draw() {
  background(255);
  b.update();
  b.borders();
  b.render();
}
```

## Boid モデルのルール

3 つのルール

1. 分離 (seperation): 周りとぶつからないように離れる
2. 整列 (alignment): 周りと同じ方向に向きを変える
3. 結合 (cohesion): 周りと一体化しようと近く

たったこれだけのルールを個体に与えることで，群れをシミュレートできます。

3 つのルールによる力をそれぞれ足し合わせた力を受ける `flock()` メソッドを以下のように実装しましょう。

```java
class Boid {
  // ...省略

  void flock(Boid[] boids) {
    PVector sep = separate(boids);
    PVector ali = align(boids);
    PVector coh = cohesion(boids);

    // 重み付けする
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);

    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  PVector separate(Boid[] boids) {
    // ...
  }

  PVector align(Boid[] boids) {
    // ...
  }

  PVector cohesion(Boid[] boids) {
    // ...
  }
}
```

### 分離 (seperation)

```java
PVector separate(Boid[] boids) {
  float desiredDistance = 25.0f;
  PVector steer = new PVector(0, 0, 0);
  int count = 0;

  for (Boid other : boids) {
    float d = PVector.dist(position, other.position);

    if ((d > 0) && (d < desiredDistance)) {
      PVector diff = PVector.sub(position, other.position);
      diff.normalize();
      diff.div(d);
      steer.add(diff);
      count++;
    }
  }

  if (count > 0) {
    steer.div((float) count);
  }

  if (steer.mag() > 0) {
    steer.normalize();
    steer.mult(maxSpeed);
    steer.sub(velocity);
    steer.limit(maxForce);
  }
  return steer;
}
```

### 整列 (alignment)

```java
PVector align(Boid[] boids) {
  float neighborDistance = 50;
  PVector sum = new PVector(0, 0);
  int count = 0;
  for (Boid other : boids) {
    float d = PVector.dist(position, other.position);
    if ((d > 0) && (d < neighborDistance)) {
      sum.add(other.velocity);
      count++;
    }
  }

  if (count > 0) {
    sum.div((float) count);
    sum.normalize();
    sum.mult(maxSpeed);
    PVector steer = PVector.sub(sum, velocity);
    steer.limit(maxForce);
    return steer;
  } else {
    return new PVector(0, 0);
  }
}
```

### 結合 (cohesion)

```java
PVector cohesion(Boid[] boids) {
  float neighborDistance = 50;
  PVector sum = new PVector(0, 0);
  int count = 0;
  for (Boid other : boids) {
    float d = PVector.dist(position, other.position);
    if ((d > 0) && (d < neighborDistance)) {
      sum.add(other.position);
      count++;
    }
  }

  if (count > 0) {
    sum.div(count);
    return seek(sum);
  } else {
    return new PVector(0, 0);
  }
}
```

## シミュレーション

```java
Boid[] boids = new Boid[200];

void setup() {
  size(640, 480);
  for (int i = 0; i < boids.length; i++) {
    boids[i] = new Boid(width / 2, height / 2);
  }
}

void draw() {
  background(255);

  for (Boid b : boids) {
    b.flock(boids);
    b.update();
    b.borders();
    b.render();
  }
}
```

## 発展課題

- 3 つのルールを実装するとき，Boid の視野を考慮してみましょう（現状は全方位が見えています）。
- Boid は近傍の個体と相互作用をするので，全個体に対して探索するのは非効率です。どのような最適化が考えられるでしょうか。
