require './character'

class Monster < Character

  # HPが半分の時の処理 
  HALF_HP_MONSTER = 0.5
  # フルパワーになり攻撃力1.5倍
  HULL_POWER = 1.5

  def initialize(**params)
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )
    @trigger_of_transform = params[:hp] * HALF_HP_MONSTER
    # 変身したときのフラグ
    @trans_form_flag = false
  end

  def attack(zhero,zhero2)
    if @hp <= @trigger_of_transform && @trans_form_flag == false
      @trans_form_flag = true
      transform
    end
    target = [zhero,zhero2].sample
    damage = calculate_damage(zhero,zhero2)
    cause_damage(target:target,damage:damage)
    attack_message(target:target)
    damage_message(target:target,damage:damage)
  end

  private

  def calculate_damage(zhero,zhero2)
    @offense - zhero.defense
    @offense - zhero2.defense
  end 

  def cause_damage(**params)
    target = params[:target]
    damage = params[:damage]

    target.hp -= damage
    target.hp = 0 if target.hp < 0
  end

    def transform
      transform_name = "フルパワーフリーザ"

      transform_message(origin_name:@name,transform_name:transform_name)

      @offense *= HULL_POWER
      @name = transform_name
    end
# モンスタークラスの終わり
end 