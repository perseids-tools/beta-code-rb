# Beta Code Converter for Ruby

Converts Greek Beta Code to Greek characters and vice versa.

## Installation

Add this line to your application's Gemfile:

`gem 'beta_code'`

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install beta_code`

## Usage

```ruby
require 'beta_code'

BetaCode.greek_to_beta_code 'χαῖρε ὦ κόσμε'
# => 'xai=re w)= ko/sme'

BetaCode.beta_code_to_greek 'mh=nin a)/eide qea\\ *phlhi+a/dew *)axilh=os'
# => 'μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος'
```

### With additional mappings

```ruby
BetaCode.beta_code_to_greek('f2a/nac', custom_map: { f2: 'ϝ' })
# => 'ϝάναξ'
```

## Tests

`bundle exec ruby test/test_beta_code.rb`

## Updating JSON

```bash
git subtree pull --prefix vendor/beta-code-json/ https://github.com/perseids-tools/beta-code-json master --squash
```

In the case of a merge conflict:

```bash
git checkout --theirs vendor/beta-code-json/
git add vendor/beta-code-json
git commit
```

## Publishing

* Bump version in `beta_code.gemspec`
* Commit and push to GitHub
* On GitHub, create a new release
* Run `gem build beta_code.gemspec`
* Run `gem push beta_code-X.Y.Z.gem`

## Notes

For the mappings between Beta Code and Unicode, see [https://github.com/perseids-tools/beta-code-json](https://github.com/perseids-tools/beta-code-json).
