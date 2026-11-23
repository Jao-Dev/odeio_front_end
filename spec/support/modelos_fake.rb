require "active_model"

class PersonagemFake
  include ActiveModel::Model

  attr_accessor :nome, :preco, :classe

  validates :nome, presence: true
end
