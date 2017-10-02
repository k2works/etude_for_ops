---
markdown:
  image_dir: /docs/assets
  path: spec.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

EtudeForOps
---

## 基本仕様
+ インフラ環境構築の基盤を提供するプログラム
+ 環境ごとにインフラ環境構築の基盤を生成できる。
+ 環境ごとにインフラ環境構築の戦略を選択できる。

## ユースケース
```puml
left to right direction
skinparam packageStyle rectangle
actor 開発者
rectangle EtudeForOps {
  開発者 -- (開発環境を構築する)
  開発者 -- (ステージング環境を構築する)
  開発者 -- (本番環境を構築する)
}
```

### ユースケース１：開発環境を構築する

### ユースケース２：ステージング環境を構築する

### ユースケース３：本番環境を構築する


## コアモデル
```puml
Environment <|-- Development
Environment <|-- Staging
Environment <|-- Production
Environment <|-- Share
Environment *--r Config
Environment *--r Source
Source *-- Build
Source *-- Ship
Source *-- Run
Config *-- EnvironmentVariable
Config *-- Secure
Strategy <|-- Onpremis
Strategy <|-- Cloud
Strategy *--r Environment
Environment *--u Platform
Platform <|--u Ruby
Ops --r> EnvironmentBuilder
EnvironmentBuilder --r> Environment
EnvironmentBuilder --r> Strategy
Cloud <|-- AWS

class Ops
abstract Environment
class Development
class Staging
class Production
abstract Strategy
class Share
class Config
class Source
class Build
class Ship
class Run
class Onpremis
class Cloud
class AWS
class Platform
```
