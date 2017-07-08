require 'test/unit'
require 'beta_code'

class BetaCodeTest < Test::Unit::TestCase
  def test_greek_to_beta_code
    assert_equal 'xai=re w)= ko/sme', BetaCode.greek_to_beta_code('χαῖρε ὦ κόσμε')
  end

  def test_beta_code_to_greek
    assert_equal 'χαῖρε ὦ κόσμε', BetaCode.beta_code_to_greek('xai=re w)= ko/sme')
  end
end
