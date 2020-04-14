# 親クラス
require './message_dialog'

class Character  
  attr_reader :offense,:defense
  attr_accessor :hp,:name
  
  include MessageDialog
  
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end