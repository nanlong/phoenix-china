# Phoenix 中文社区

[![Build Status](https://travis-ci.org/nanlong/phoenix_china_umbrella.svg?branch=master)](https://travis-ci.org/nanlong/phoenix_china_umbrella)

## 依赖
1. elixir >= 1.4.2
2. phoenix >= 1.3.0-rc.1
3. postgresql >= 9.6
4. node >= 7.2.0
5. yarn >= 0.17.9

## 开发环境首次运行
1. 安装elixir包 `cd ~/phoenix_china_umbrella && mix deps.get`
2. 创建数据库并创建表，在当前目录下 `mix ecto.create && mix ecto.migrate`
3. 如有预装数据 `mix run apps/phoenix_china/priv/repo/seeds.exs`
4. 安装前端依赖 `cd ~/phoenix_china_umbrella/apps/phoenix_china_web/assets && yarn install`

## 开发环境
1. `cd ~/phoenix_china_umbrella && mix phx.server`
