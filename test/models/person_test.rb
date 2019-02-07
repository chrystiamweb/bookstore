require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  
  setup do 
    @person = people(:admin)
  end

  test 'tem que ser válido sem alterações' do 
    assert @person.valid?
  end

  test 'nao pode ter nome vazio' do
    @person.name = ''
    assert !@person.valid?
  end

  test 'nao pode ter nome maior que 50 caracteres' do
    @person.name = '*' * 51
    assert !@person.valid?      
  end

  test 'nao pode ter email inválido' do 
    @person.email = 'foo@bar'
    assert !@person.valid?
  end

  test 'nao pode ter email repetido' do
    new_person = Person.new(@person.attributes)
    assert !new_person.valid?
  end

  test 'data de nascimento não pode ser menor que 16 anos' do
    @person.born_at = Date.current - 15.years
    assert !@person.valid?
  end

  test 'data de nascimento  pode ser maior que 16 anos' do
    @person.born_at = Date.current - 17.years
    assert @person.valid?
  end

  test 'pode ter email vazio' do
    @person.email = '' 
    assert @person.valid?
  end

end
