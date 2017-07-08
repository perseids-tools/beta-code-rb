require 'json'

class BetaCode
  def self.greek_to_beta_code(greek)
    greek.chars.map { |c| unicode_to_beta_code_map[c] || c }.join('')
  end

  def self.beta_code_to_greek(beta_code)
    'χαῖρε ὦ κόσμε'
  end

  def self.beta_code_to_unicode_map
    @beta_code_to_unicode_map ||= JSON.parse(read_vendor_file('beta-code-json/beta_code_to_unicode.json'))
  end

  def self.unicode_to_beta_code_map
    @unicode_to_beta_code_map ||= JSON.parse(read_vendor_file('beta-code-json/unicode_to_beta_code.json'))
  end

  def self.read_vendor_file(file)
    File.read(File.expand_path("../../vendor/#{file}", __FILE__))
  end

  private_class_method :beta_code_to_unicode_map, :unicode_to_beta_code_map, :read_vendor_file
end
