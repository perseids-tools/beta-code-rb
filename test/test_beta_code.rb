require 'test/unit'
require 'beta_code'

class BetaCodeTest < Test::Unit::TestCase
  def test_greek_to_beta_code
    assert_equal(
      'xai=re w)= ko/sme',
      BetaCode.greek_to_beta_code('χαῖρε ὦ κόσμε'),
      'hello world',
    )

    assert_equal(
      'mh=nin a)/eide qea\\ *phlhi+a/dew *)axilh=os',
      BetaCode.greek_to_beta_code('μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος'),
      'first line of the Iliad',
    )

    assert_equal(
      'kate/bhn xqe\\s ei)s *peiraia= meta\\ *glau/kwnos tou= *)ari/stwnos proseuco/meno/s te th=| qew=| kai\\ a(/ma ' \
      'th\\n e(orth\\n boulo/menos qea/sasqai ti/na tro/pon poih/sousin a(/te nu=n prw=ton a)/gontes. kalh\\ me\\n ' \
      'ou)=n moi kai\\ h( tw=n e)pixwri/wn pomph\\ e)/docen ei)=nai, ou) me/ntoi h(=tton e)fai/neto pre/pein h(\\n ' \
      'oi( *qra=|kes e)/pempon. proseuca/menoi de\\ kai\\ qewrh/santes a)ph=|men pro\\s to\\ a)/stu. katidw\\n ' \
      'ou)=n po/rrwqen h(ma=s oi)/kade w(rmhme/nous *pole/marxos o( *kefa/lou e)ke/leuse dramo/nta to\\n pai=da ' \
      'perimei=nai/ e( keleu=sai. kai/ mou o)/pisqen o( pai=s labo/menos tou= i(mati/ou, keleu/ei u(ma=s, e)/fh, ' \
      '*pole/marxos perimei=nai. kai\\ e)gw\\ metestra/fhn te kai\\ h)ro/mhn o(/pou au)to\\s ei)/h. ou(=tos, e)/fh, ' \
      'o)/pisqen prose/rxetai: a)lla\\ perime/nete. a)lla\\ perimenou=men, h)= d\' o(\\s o( *glau/kwn.',
      BetaCode.greek_to_beta_code(
        'κατέβην χθὲς εἰς Πειραιᾶ μετὰ Γλαύκωνος τοῦ Ἀρίστωνος προσευξόμενός τε τῇ θεῷ καὶ ἅμα τὴν ἑορτὴν βουλόμενος ' \
        'θεάσασθαι τίνα τρόπον ποιήσουσιν ἅτε νῦν πρῶτον ἄγοντες. καλὴ μὲν οὖν μοι καὶ ἡ τῶν ἐπιχωρίων πομπὴ ἔδοξεν ' \
        'εἶναι, οὐ μέντοι ἧττον ἐφαίνετο πρέπειν ἣν οἱ Θρᾷκες ἔπεμπον. προσευξάμενοι δὲ καὶ θεωρήσαντες ἀπῇμεν πρὸς ' \
        'τὸ ἄστυ. κατιδὼν οὖν πόρρωθεν ἡμᾶς οἴκαδε ὡρμημένους Πολέμαρχος ὁ Κεφάλου ἐκέλευσε δραμόντα τὸν παῖδα ' \
        'περιμεῖναί ἑ κελεῦσαι. καί μου ὄπισθεν ὁ παῖς λαβόμενος τοῦ ἱματίου, κελεύει ὑμᾶς, ἔφη, Πολέμαρχος ' \
        'περιμεῖναι. καὶ ἐγὼ μετεστράφην τε καὶ ἠρόμην ὅπου αὐτὸς εἴη. οὗτος, ἔφη, ὄπισθεν προσέρχεται· ἀλλὰ ' \
        'περιμένετε. ἀλλὰ περιμενοῦμεν, ἦ δ\' ὃς ὁ Γλαύκων.',
      ),
      'longer piece of text',
    )

    assert_equal(
      'dd*ds',
      BetaCode.greek_to_beta_code('δδΔς'),
      'random characters',
    )

    assert_equal(
      '*pollh\\ me\\n e)n brotoi=si kou)k a)nw/numos qea\\ ke/klhmai *ku/pris ou)ranou= t᾿ e)/sw:',
      BetaCode.greek_to_beta_code('Πολλὴ μὲν ἐν βροτοῖσι κοὐκ ἀνώνυμος θεὰ κέκλημαι Κύπρις οὐρανοῦ τ᾿ ἔσω·'),
      'unicode normalization',
    )

    assert_equal(
      'w(=|*(=w|',
      BetaCode.greek_to_beta_code('ᾧᾯ'),
      'many diacritics',
    )

    assert_equal(
      'mou_s',
      BetaCode.greek_to_beta_code('μοῡς', custom_map: { ᾱ: 'a_', ῑ: 'i_', ῡ: 'u_' }),
      'custom map',
    )
  end

  def test_beta_code_to_greek
    assert_equal(
      'χαῖρε ὦ κόσμε',
      BetaCode.beta_code_to_greek('xai=re w)= ko/sme'),
      'hello world',
    )

    assert_equal(
      'μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος',
      BetaCode.beta_code_to_greek('mh=nin a)/eide qea\\ *phlhi+a/dew *)axilh=os'),
      'first line of the Iliad',
    )

    assert_equal(
      'κατέβην χθὲς εἰς Πειραιᾶ μετὰ Γλαύκωνος τοῦ Ἀρίστωνος προσευξόμενός τε τῇ θεῷ καὶ ἅμα τὴν ἑορτὴν βουλόμενος ' \
      'θεάσασθαι τίνα τρόπον ποιήσουσιν ἅτε νῦν πρῶτον ἄγοντες. καλὴ μὲν οὖν μοι καὶ ἡ τῶν ἐπιχωρίων πομπὴ ἔδοξεν ' \
      'εἶναι, οὐ μέντοι ἧττον ἐφαίνετο πρέπειν ἣν οἱ Θρᾷκες ἔπεμπον. προσευξάμενοι δὲ καὶ θεωρήσαντες ἀπῇμεν πρὸς τὸ ' \
      'ἄστυ. κατιδὼν οὖν πόρρωθεν ἡμᾶς οἴκαδε ὡρμημένους Πολέμαρχος ὁ Κεφάλου ἐκέλευσε δραμόντα τὸν παῖδα περιμεῖναί ' \
      'ἑ κελεῦσαι. καί μου ὄπισθεν ὁ παῖς λαβόμενος τοῦ ἱματίου, κελεύει ὑμᾶς, ἔφη, Πολέμαρχος περιμεῖναι. καὶ ἐγὼ ' \
      'μετεστράφην τε καὶ ἠρόμην ὅπου αὐτὸς εἴη. οὗτος, ἔφη, ὄπισθεν προσέρχεται· ἀλλὰ περιμένετε. ἀλλὰ ' \
      'περιμενοῦμεν, ἦ δ\' ὃς ὁ Γλαύκων.',
      BetaCode.beta_code_to_greek(
        'kate/bhn xqe\\s ei)s *peiraia= meta\\ *glau/kwnos tou= *)ari/stwnos proseuco/meno/s te th=| qew=| kai\\ ' \
        'a(/ma th\\n e(orth\\n boulo/menos qea/sasqai ti/na tro/pon poih/sousin a(/te nu=n prw=ton a)/gontes. kalh\\ ' \
        'me\\n ou)=n moi kai\\ h( tw=n e)pixwri/wn pomph\\ e)/docen ei)=nai, ou) me/ntoi h(=tton e)fai/neto pre/pein ' \
        'h(\\n oi( *qra=|kes e)/pempon. proseuca/menoi de\\ kai\\ qewrh/santes a)ph=|men pro\\s to\\ a)/stu. ' \
        'katidw\\n ou)=n po/rrwqen h(ma=s oi)/kade w(rmhme/nous *pole/marxos o( *kefa/lou e)ke/leuse dramo/nta to\\n ' \
        'pai=da perimei=nai/ e( keleu=sai. kai/ mou o)/pisqen o( pai=s labo/menos tou= i(mati/ou, keleu/ei u(ma=s, ' \
        'e)/fh, *pole/marxos perimei=nai. kai\\ e)gw\\ metestra/fhn te kai\\ h)ro/mhn o(/pou au)to\\s ei)/h. ' \
        'ou(=tos, e)/fh, o)/pisqen prose/rxetai: a)lla\\ perime/nete. a)lla\\ perimenou=men, h)= d\' o(\\s o( ' \
        '*glau/kwn.',
      ),
      'longer piece of text',
    )

    assert_equal(
      'δδΔς',
      BetaCode.beta_code_to_greek('dd*ds'),
      'random characters',
    )

    assert_equal(
      'δδΔς',
      BetaCode.beta_code_to_greek('dD*Ds2'),
      'random characters',
    )

    assert_equal(
      [
        '*o(/rkos *a)/zwton *e(/llhnas *a)=pis *w(=|',
        '*(/orkos *)/azwton *(/ellhnas *)=apis *(=|w',
        '*(/orkos *)/azwton *(/ellhnas *)=apis *(=w|',
      ].map { |n| BetaCode.beta_code_to_greek(n) },
      ['Ὅρκος Ἄζωτον Ἕλληνας Ἆπις ᾯ'] * 3,
    )

    assert_equal(
      'μοῡς',
      BetaCode.beta_code_to_greek('mou_s', custom_map: { a_: 'ᾱ', i_: 'ῑ', u_: 'ῡ' }),
      'custom map',
    )
  end
end
