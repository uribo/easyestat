
<!-- README.md is generated from README.Rmd. Please edit that file -->

# easyestat

<!-- badges: start -->
<!-- badges: end -->

easyestatパッケージは[e-Stat
政府統計の総合窓口](https://www.e-stat.go.jp)に掲載されている各種統計データをR上で扱いやすくした整形データとして提供するものです。

一部のデータはe-Stat
API（統計データを機械判読可能な形式で取得できるAPI機能）を介して利用可能になります。e-Stat
APIが発行するアプリケーションIDが必要となりますので、各自で用意するようにしてください（該当する関数の引数*appId*に値を指定）。
なお、このサービスは、政府統計総合窓口(e-Stat)のAPI機能を使用していますが、サービスの内容は国によって保証されたものではありません。

## Installation

パッケージは現在CRANには登録されていません。次のコマンドを実行してインストールをしてください。

``` r
if (!requireNamespace("remotes"))
  install.packages("remotes")

remotes::install_github("uribo/easyestat")
```

## Example

-   政府統計 国勢調査
-   政府統計 人口推計
