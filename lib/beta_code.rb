require 'json'

class BetaCode
  def self.greek_to_beta_code(greek, custom_map: {})
    map = unicode_to_beta_code_map.merge(stringify_keys(custom_map))

    greek.unicode_normalize.chars.map { |c| map[c] || c }.join('')
  end

  # This method is absurd. But having the logic all in one method makes it easier to work with than
  # having it spread across multiple methods.
  # It also makes it easier to compare the logic to the Beta Code libraries in other languages.
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def self.beta_code_to_greek(beta_code, custom_map: {})
    map = beta_code_to_unicode_map.merge(stringify_keys(custom_map))
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

        if map[slice]
          current_character = map[slice]
          new_start = last
        end

        last += 1
      end

      greek_characters << current_character
      start = new_start
    end

    sigma_to_end_of_word_sigma(greek_characters.join(''))
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def self.max_beta_code_character_length
    @max_beta_code_character_length ||= beta_code_to_unicode_map.keys.map(&:length).max
  end

  def self.sigma_to_end_of_word_sigma(string)
    string.gsub(/σ(?=[,.:;·\s]|$)/, 'ς')
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

  def self.stringify_keys(hash)
    {}.tap do |stringified_hash|
      hash.each { |k, v| stringified_hash[k.to_s] = v }
    end
  end

  private_class_method :beta_code_to_unicode_map,
    :unicode_to_beta_code_map,
    :read_vendor_file,
    :sigma_to_end_of_word_sigma,
    :max_beta_code_character_length,
    :stringify_keys
end
