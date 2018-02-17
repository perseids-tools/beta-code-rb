require 'json'

class BetaCode
  def self.greek_to_beta_code(greek)
    greek.unicode_normalize.chars.map { |c| unicode_to_beta_code_map[c] || c }.join('')
  end

  def self.beta_code_to_greek(beta_code)
    beta_code_characters = beta_code.chars
    greek_characters = []
    start = 0

    while start <= beta_code_characters.length
      current_character = beta_code_characters[start]
      new_start = start + 1
      max_length = [beta_code_characters.length, start + max_beta_code_character_length].min

      last = new_start
      while last <= max_length
        slice = beta_code_characters[start...last].join('')

        if beta_code_to_unicode_map[slice]
          current_character = beta_code_to_unicode_map[slice]
          new_start = last
        end

        last += 1
      end

      greek_characters << current_character
      start = new_start
    end

    sigma_to_end_of_word_sigma(greek_characters.join(''))
  end

  def self.max_beta_code_character_length
    @max_beta_code_character_length ||= beta_code_to_unicode_map.keys.map(&:length).max
  end

  def self.sigma_to_end_of_word_sigma(string)
    string.gsub(/σ(?=[,.:;·\s]|$)/, 'ς');
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

  private_class_method :beta_code_to_unicode_map, :unicode_to_beta_code_map, :read_vendor_file, :sigma_to_end_of_word_sigma, :max_beta_code_character_length
end
