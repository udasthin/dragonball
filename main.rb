require './zhero'
require './monster'
require './games_controller'
# GamesControllerクラスのインスタンス化
games_controller = GamesController.new
# 勇者クラスとモンスターをインスタンス化
gokuu = Zhero.new(name:"悟空",hp:500,offense:150,defense: 100)
vegeta = Zhero.new(name:"ベジータ",hp:400,offense:130,defense: 120)
freeza = Monster.new(name: "フリーザ",hp: 350,offense: 200, defense: 100)

# GamesControllerクラスのbattleメソッドを使用
games_controller.battle(zhero:gokuu,monster:freeza,zhero2:vegeta)


