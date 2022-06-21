
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
install.packages("easyestat", repos = "https://uribo.r-universe.dev")
```

## Example

### 地図で見る統計(統計GIS)

統計GISで提供される境界データのダウンロードを
`download_stat_map()`で実行します。ダウンロードしたShapefileを`read_estat_map()`で読み込むことでsf形式のオブジェクトとしてR上で境界データを扱えるようになります。

**小地域**

``` r
download_stat_map(prefcode = "36", .survey_id = "A002005212015")
```

``` r
read_estat_map("A002005212015DDSWC36/h27ka36.shp")
```

**人口集中地区**

``` r
download_stat_map(prefcode = "08", .survey_id = "D002005212015")
read_estat_map("D002005212015DDSWC08/h27_did_08.shp")
```

**4次メッシュ（500mメッシュ） その１　人口等基本集計に関する事項**

``` r
read_estat_meshpop("tblT000847H3622.txt")
```
