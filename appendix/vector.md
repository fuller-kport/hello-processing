# ベクター

```java
float x = 0.0;
float y = 0.0;
float vx = 1.0;
float vy = 3.3;

void setup() {
  size(500, 500);
  fill(80);
}

void draw() {
  if (x > width || x < 0) {
    vx = -1 * vx;
  }
  if (y > height || y < 0) {
    vy = -1 * vy;
  }

  background(255, 255, 255);
  x = x + vx;
  y = y + vy;
  circle(x, y, 80);
}
```

```java
PVector location = new PVector(0, 0);
PVector velocity = new PVector(1.0, 3.3);

void setup() {
  size(500, 500);
  fill(80);
}

void draw() {
  background(255, 255, 255);
  location.add(velocity);

  if (location.x > width || location.x < 0) {
    velocity.x = -1 * velocity.x;
  }
  if (location.y > height || location.y < 0) {
    velocity.y = -1 * velocity.y;
  }

  circle(location.x, location.y, 80);
}
```
