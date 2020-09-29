# 群れのシミュレーション

夕方に空を見上げると鳥の大群を見ることがあります。群れが二手に別れたり一つに合併したりしながら空を飛び回っているのを見たことがあるかもしれません。
今回は「群れ」をシミュレートするプログラムを通じて様々なことを学んでいきましょう。

## ボイドモデル

「群れ」のシミュレーションにおいては，1986 年にクレイグ・レイノルズが提案した「ボイド（Boid）」というモデルが有名です。

<iframe width="560" height="315" src="https://www.youtube.com/embed/3bTqWsVqyzE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

3 つのルール

1. 分離 (seperation): 周りとぶつからないように離れる
2. 整列 (alignment): 周りと同じ方向に向きを変える
3. 結合 (cohesion): 周りと一体化しようと近く

たったこれだけのルールを個体に与えることで，群れをシミュレートできます。
