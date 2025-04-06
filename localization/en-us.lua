return {
  descriptions = {
    Back = {
      b_fam_amethyst_deck = {
        name = "Amethyst Deck",
        text = {
            "{C:attention}+5{} hand size",
        }
      },
      b_fam_aureate_deck = {
        name = "Aureate Deck",
        text = {
            "All {C:attention}Cards{} in the deck",
            "are {C:dark_edition}Aureate",
            "All {C:attention}Jokers{} are {C:dark_edition}Aureate",
        }
      },
      b_fam_void_deck = {
        name = "Void Deck",
        text = {
            "{C:dark_edition}-3{} joker slots,",
            "All common {C:attention}Jokers{}",
            "are {C:dark_edition}Negative",
        }
      },
      b_fam_underworld_deck = {
        name = "Underworld Deck",
        text = {
            "When {C:attention}First blind{} each ante",
            "is selected, get a {C:dark_edition}Negative",
            "{C:attention}Mr.Bones{} and set Money to {C:money}0{}",
        }
      },
      b_fam_exclusive_deck = {
        name = "Exclusive Deck",
        text = {
            "Start run with {C:attention}52{} copies",
            "of a {C:attention}random{} card",
        }
      },
      b_fam_fleeting_deck = {
        name = "Fleeting Deck",
        text = {
            "{C:red}Memento{} cards may",
            "appear in the shop",
        }
      },
      b_fam_duality_deck = {
        name = "Duality Deck",
        text = {
            "Start with 26",
            "{C:attention}dual-suit{} cards",
        }
      },
      b_fam_andys_deck = {
        name = "Merry Andy's Deck",
        text = {
            "{C:red}+3{} discards,",
            "{C:blue}-1{} hand size."
        }
      },
      b_fam_burglars_deck = {
        name = "Burglar's Deck",
        text = {
            "{C:blue}+3{} hands every round,",
            "{C:red}0{} discards every round",
        }
      },
      b_fam_ruby_deck = {
        name = "Ruby Deck",
        text = {
            "Start with {C:attention}2 copies{}",
            "of Playback,",
            "{C:red}+2{} discards every round.",
            "{C:blue}-1{} hand every round,"
        }
      },
      b_fam_silver_deck = {
        name = "Silver Deck",
        text = {
            "{C:attention}+2{} joker slots,",
            "{C:blue}-1{} hand every round,",
            "{C:red}-1{} discard every round",
        }
      },
      b_fam_spare_deck = {
        name = "Spare Deck",
        text = {
            "Start run with",
            "Some {C:attention}missing{} cards, ",
            "Some {C:attention}addition{} cards",
            "{C:blue}+1{} hand, and some {C:money}Money",
        }
      },
      b_fam_speckled_deck = {
        name = "Speckled Deck",
        text = {
            "All {C:attention}Cards{} in the deck",
            "are {C:dark_edition}Speckled",
            "All {C:attention}Jokers{} are {C:dark_edition}Speckled",
        }
      },
      b_fam_static_deck = {
        name = "Static Deck",
        text = {
            "All {C:attention}Cards{} in the deck",
            "are {C:dark_edition}Static",
            "All {C:attention}Jokers{} are {C:dark_edition}Static",
        }
      },
      b_fam_topaz_deck = {
        name = "Topaz Deck",
        text = {
            "{C:blue}+1{} hand every round,",
            "{C:red}+1{} discard every round",
            "{C:attention}-2{} hand size",
        }
      },
    },
    Sleeve = {
        sleeve_fam_amythestsleeve = {
            name = "Amethyst Sleeve",
            text = {
                "{C:attention}+5{} hand size"
            }
        },
        sleeve_fam_dualitysleeve = {
            name = "Duality Sleeve",
            text = {
                 "Start with 26",
                "{C:attention}dual-suit{} cards",
            }
        },
        sleeve_fam_andysleeve = {
            name = "Merry Andy's Sleeve",
            text = {
                "{C:attention}+3{} discards,",
                "{C:blue}-1{} hand size."
            }
        },
        sleeve_fam_rubysleeve = {
            name = "Ruby Sleeve",
            text = {
                "Start with {C:attention}2 copies{}",
                "of Playback,",
                "{C:red}+2{} discards every round.",
                "{C:blue}-1{} hand every round."
            }
        },
        sleeve_fam_silversleeve = {
            name = "Silver Sleeve",
            text = {
                "{C:attention}+2{} joker slots,",
                "{C:blue}-1{} hand every round,",
                "{C:red}-1{} discard every round",
            }
        },
        sleeve_fam_sparesleeve = {
            name = "Spare Sleeve",
            text = {
                "Start run with",
                "Some {C:attention}missing{} cards, ",
                "Some {C:attention}addition{} cards",
                "{C:blue}+1{} hand, and some {C:money}Money",
            }
        },
        sleeve_fam_topazsleeve = {
            name = "Topaz Sleeve",
            text = {
                "{C:blue}+1{} hand every round,",
                "{C:red}+1{} discard every round",
                "{C:attention}-2{} hand size",
            }
        },
    },
    Joker = {
      j_fam_archibald = {
        name = 'Archibald',
        text = {
            "Gives {C:money}$#2#{} for every",
            "{C:attention}2{} consumables in hand.",
            "{C:inactive}(Gain {C:money}$#1#{} {C:inactive}at end of round)",
        }
      },
      j_fam_asterism = {
          name = "Asterism",
          text = {
              "Gains {X:chips,C:white} X#1# {} Chips",
              "per {C:purple}Sacred{} card used",
              "{C:inactive}(Currently {X:chips,C:white} X#2# {C:inactive} Chips)"
          }
      },
      j_fam_sacrificial_dagger = {
          name = "Sacrificial Dagger",
          text = {
              "When {C:attention}Blind{} is selected,",
              "destroy Joker to the right",
              "and permanently add its sell",
              "value to this {C:attention}Stockpile{}, gain {C:dark_edition}+#3#",
              "Joker slot per {C:money}$#2#{} in Stock",
              "{C:inactive}(Currently {C:attention}#1#{C:inactive} Stock ({C:dark_edition}+#4#{C:inactive} Slots))"
          }
      },
      j_fam_jester_investor = {
        name = 'Jester Investor',
        text = {
            "For {C:attention}each{} joker give",
            "{X:mult,C:white}X#1#{} for {C:green}Uncommon",
            "{X:mult,C:white}X#2#{} for {C:mult}Rare",
            "{X:mult,C:white}X#3#{} for {C:legendary}Legendary",
        }
      },
      j_fam_astrophysicist = {
        name = 'Astrophysicist',
        text = {
            "Create a {C:blue}Planet{} card",
            "when {C:attention}Blind{} is selected",
            "{C:inactive}(Must have room)",
        }
      },
      j_fam_bard = {
        name = 'Bard',
        text = {
            "{C:attention}#1#{} hand size,",
            "{C:mult}+#2#{} discards",
        }
      },
      j_fam_clown = {
        name = 'Clown',
        text = {
            "Doubles all",
            "card {C:attention}held in",
            "{C:attention}hand{} abilities",
        }
      },
      j_fam_bear_market = {
        name = 'Bear Market',
        text = {
            "{C:red}Lose{} {C:money}$#2#{} of interest for every {C:money}$#1#{}",
            "dollars you have at end of round.",
            "Has a {C:green,E:1,S:1.1}#4# in #3#{} chance to swap to",
            "Bull Market after every shop.",
        }
      },
      j_fam_bull_market = {
        name = 'Bull Market',
        text = {
            "{C:green}Gain{} {C:money}$#2#{} of interest for every {C:money}$#1#{}",
            "dollars you have at end of round.",
            "Has a {C:green,E:1,S:1.1}#4# in #3#{} chance to swap to",
            "Bear Market after every shop.",
        }
      },
      j_fam_cheerful_jester = {
        name = 'Cheerful Jester',
        text = {
            "Gain {C:money}$#2#{} if played",
            "hand contains",
            "a {C:attention}#1#",
        }
      },
      j_fam_con_man = {
        name = 'Con Man',
        text = {
            "At the end of the shop, lose {C:money}$#1#{}",
            "and create a random copy of",
            "a {C:attention}Joker{} or {C:tarot}Consumable{} in your possession",
            "Price increases by {C:money}$2{} on activation",
            "{C:inactive}(Must have room){}"
        }
      },
      j_fam_crash_landing = {
        name = 'Crash Landing',
        text = {
            "Gain {C:money}money{} equivalent to the",
            "{C:dark_edition}level{} of the corresponding hand",
            "when {C:money}selling{} a planet card",
        }
      },
      j_fam_crimsonotype = {
        name = 'Crimsonotype',
        text = {
            "Copies ability of",
            "{C:attention}Joker{} to the left",
        }
      },
      j_fam_debit_card = {
        name = 'Debit Card',
        text = {
            "Store half of cash-out money",
            "earn {C:money}$1{} more interest",
            "for every {C:money}$#2#{}",
            "{C:inactive}(Current balance: {C:money}$#1#{}){}"
        }
      },
      j_fam_delightful_jester = {
        name = 'Delightful Jester',
        text = {
            "Gain {C:money}$#2#{} if played",
            "hand contains",
            "a {C:attention}#1#",
        }
      },
      j_fam_dry_erase_board = {
        name = 'Dry-Erase Board',
        text = {
            "{X:chips,C:white}X#1#{} Chips if",
            "all cards scored",
            "are {C:hearts}Hearts{} and {C:diamonds}Diamonds",
        }
      },
      j_fam_flag_of_surrender = {
        name = 'Flag of Surrender',
        text = {
            "{C:mult}+#1#{} Mult",
            "for each played",
            "{C:attention}hand{} this round",
        }
      },
      j_fam_forged_signature = {
        name = 'Forged Signature',
        text = {
            "When round begins,",
            "add a random {C:attention}playing",
            "{C:attention}card{} with a random",
            "{C:attention}edition{} to your hand",
        }
      },
      j_fam_ham_radio = {
        name = 'H.A.M Radio',
        text = {
            "Each {C:attention}10{} or {C:attention}4{} held",
            "in hand gives",
            "{C:mult}X#1#{} Mult",
        }
      },
      j_fam_joey_j_jester = {
        name = 'Joey. J. Jester',
        text = {
            "{X:chips,C:white}X#1#{} Chips",
        }
      },
      j_fam_joyful_jester = {
        name = 'Joyful Jester',
        text = {
            "Gain {C:money}$#2#{} if played",
            "hand contains",
            "a {C:attention}#1#",
        }
      },
      j_fam_mirthful_jester = {
        name = 'Mirthful Jester',
        text = {
            "Gain {C:money}$#2#{} if played",
            "hand contains",
            "a {C:attention}#1#",
        }
      },
      j_fam_neopolitan = {
        name = 'Neopolitan',
        text = {
            "{C:blue}+#3#{} Chips or {C:mult}+#1#{} Mult or {C:money}+$#5#{}",
            "{C:blue}-#4#{} Chips, {C:mult}-#2#{} Mult, and {C:money}-$#6#{}",
            "for every hand played",
        }
      },
      j_fam_second_half = {
        name = 'Second Half',
        text = {
            "{C:blue}+#1#{} Chips if played",
            "hand contains",
            "{C:attention}#2#{} or more cards",
        }
      },
      j_fam_peppy_jester = {
        name = 'Peppy Jester',
        text = {
            "Gain {C:money}$#2#{} if played",
            "hand contains",
            "a {C:attention}#1#",
        }
      },
      j_fam_perfect_ballot = {
        name = 'Perfect Ballot',
        text = {
            "Retrigger {C:attention}all{} played",
            "cards used in scoring {C:attention}once",
            "{C:inactive}(If you have a perfect hand){}",
        }
      },
      j_fam_golden_ratio = {
        name = 'Golden Ratio',
        text = {
            "Retrigger {C:attention}each{} played",
            "card with the ranks {C:attention}Ace{}",
            "{C:attention}6{}, {C:attention}8{}, {C:attention}rankless{}, {C:attention}3{}, and {C:attention}9{}",
        }
      },
      j_fam_professor = {
        name = 'Professor',
        text = {
            "{C:blue}+#1#{} hand each round",
        }
      },
      j_fam_prosopagnosia = {
        name = 'Prosopagnosia',
        text = {
            "No cards",
            "are considered",
            "{C:attention}face{} cards",
        }
      },
      j_fam_purple_card = {
        name = 'Purple Card',
        text = {
            "This Joker gains",
            "{C:blue}+#2#{} Chips when any",
            "{C:attention}Booster Pack{} is skipped",
            "{C:inactive}(Currently {C:blue}+#1#{} {C:inactive}Chips)",
        }
      },
      j_fam_red_jester = {
        name = 'Red Jester',
        text = {
            "{C:mult}+#1#{} Mult for every two",
            "remaining cards in {C:attention}deck",
            "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult)",
        }
      },
      j_fam_rna = {
        name = 'RNA',
        text = {
            "If {C:attention}first discard{} of round",
            "has only {C:attention}1{} card {C:green,E:1,S:1.1}#2# in #1#{}",
            "chance to add a permanent",
            "copy to deck",
        }
      },
      j_fam_rug_pull = {
        name = 'Rug Pull',
        text = {
            "Lose interest instead of gain,",
            "Gain {C:red}+#1#{} Mult for every {C:money}${}",
            "lost this way.",
            "{C:inactive}(Currently {C:mult}+#2#{}{C:inactive} Mult)",
        }
      },
      j_fam_sixers_scrapbook = {
        name = "Sixer's Scrapbook",
        text = {
            "All hands can have",
            "{C:attention}#1#{} more card selected"
        }
      },
      j_fam_smudged_jester = {
        name = 'Smudged Jester',
        text = {
            "{C:attention}3s{} counts as {C:attention}8s{}",
            "{C:attention}6s{} count as {C:attention}9s{}",
            "{C:attention}Kings{} count as {C:attention}Aces{}",
        }
      },
      j_fam_sploosh = {
        name = 'Sploosh',
        text = {
            "Every {C:attention}In-hand{} card values",
            "counts in scoring",
        }
      },
      j_fam_taromancer = {
        name = 'Taromancer',
        text = {
            "All {C:tarot}Tarot{} cards and",
            "{C:tarot}Arcana Packs{} in",
            "the shop are {C:attention}free",
        }
      },
      j_fam_the_class = {
        name = 'The Class',
        text = {
            "{X:chips,C:white}X#1#{} Chips if played",
            "hand contains",
            "a {C:attention}#2#",
        }
      },
      j_fam_the_kingdom = {
        name = 'The Kingdom',
        text = {
            "{X:chips,C:white}X#1#{} Chips if played",
            "hand contains",
            "a {C:attention}#2#",
        }
      },
      j_fam_the_triplets = {
        name = 'The Triplets',
        text = {
            "{X:chips,C:white}X#1#{} Chips if played",
            "hand contains",
            "a {C:attention}#2#",
        }
      },
      j_fam_the_twins = {
        name = 'The Twins',
        text = {
            "{X:chips,C:white}X#1#{} Chips if played",
            "hand contains",
            "a {C:attention}#2#",
        }
      },
      j_fam_thinktank = {
        name = 'Thinktank',
        text = {
            "Copies the ability",
            "of rightmost {C:attention}Joker{}",
        }
      },
      j_fam_trapeze_artist = {
        name = 'Trapeze Artist',
        text = {
            "{X:chips,C:white}X#1#{} Chips on {C:attention}first",
            "{C:attention}hand{} of round",
        }
      },
      j_fam_troublesome_triangle = {
        name = 'Troublesome Triangle',
        text = {
            "Whenever a {C:attention}3{} is played,",
            "{C:dark_edition,E:1}Chaos reigns supreme!{}",
        }
      },
      j_fam_the_tetrad = {
        name = 'The Tetrad',
        text = {
            "{X:chips,C:white}X#1#{} Chips if played",
            "hand contains",
            "a {C:attention}#2#",
        }
      },
    },
    Familiar_Tarots = {
      c_fam_the_broken = {
        name = "The Broken",
        text = {
            "Creates a {C:attention}Familiar Consumable",
            "based on the {C:attention}Consumable",
            "you last used",
        }
      },
      c_fam_oligarch = {
        name = "Oligarch",
        text = {
            "Converts up to {C:attention}two{} random",
            "Consumables into their",
            "{C:attention}Familiar{} version",
        }
      },
      c_fam_the_wed = {
        name = "The Wed",
        text = {
            "Enhances {C:attention}#1#{} selected card",
            "into a {C:attention}Split Card{}.",
        }
      },
      c_fam_the_carriage = {
        name = "The Carriage",
        text = {
            "Enhances {C:attention}#1#{} selected card",
            "into a {C:attention}Stainless Card{}.",
        }
      },
      c_fam_vengeance = {
        name = "Vengeance",
        text = {
            "Enhances {C:attention}#1#{} selected card into",
            "a {C:attention}Stained Glass Card{}.",
        }
      },
      c_fam_the_pirate = {
        name = "The Pirate",
        text = {
            "Enhances {C:attention}#1#{} selected card",
            "into a {C:attention}Jewel Card{}.",
        }
      },
      c_fam_indulgent = {
        name = "Indulgent",
        text = {
            "Gives triple of a",
            "selected Joker's sell",
            "value {C:inactive}(Max of {C:money}$#1#{}{C:inactive})",
            "{C:inactive}(Currently {C:money}$#2#{}{C:inactive})",
        }
      },
      c_fam_demise = {
        name = "Demise",
        text = {
            "Select {C:attention}#1#{} cards,",
            "convert {C:attention}them{} into",
            "a {C:attention}random{} selected card",
        }
      },
      c_fam_the_bishop = {
        name = "The Bishop",
        text = {
            "Enhances {C:attention}#1#{} selected card",
            "into a {C:attention}Penalty Card{}.",
        }
      },
      c_fam_humanity = {
        name = "Humanity",
        text = {
            "Enhances {C:attention}#1#{} selected card",
            "into a {C:attention}Gilded card{}.",
        }
      },
      c_fam_the_cycle_of_fate = {
        name = "The Cycle of Fate",
        text = {
            "{C:green,E:1,S:1.1}#2# in #1#{} chance to",
            "make a {C:attention}joker{} Negative.",
            "{C:inactive}(Overrides other Editions){}"
        }
      },
      c_fam_the_daylight = {
        name = "The Daylight",
        text = {
            "Adds {C:hearts}Hearts{} to up",
            "to {C:attention}#1#{} selected cards.",
            "{C:inactive}(Does not remove other suit(s))",
        }
      },
      c_fam_the_galaxy = {
        name = "The Galaxy",
        text = {
            "Adds {C:diamonds}Diamonds{} to up",
            "to {C:attention}#1#{} selected cards.",
            "{C:inactive}(Does not remove other suit(s))",
        }
      },
      c_fam_the_harlot = {
        name = "The Harlot",
        text = {
            "Creates a {C:attention}planet{} card",
            "of your {C:attention}most{} used poker hand",
            "{C:inactive}(Must have room){}"
        }
      },
      c_fam_the_illusionist = {
        name = "The Illusionist",
        text = {
            "Enhances {C:attention}#1#{} selected card",
            "into a {C:attention}Charmed Card{}.",
        }
      },
      c_fam_the_landscape = {
        name = "The Landscape",
        text = {
            "Adds {C:spades}Spades{} to up",
            "to {C:attention}#1#{} selected cards.",
            "{C:inactive}(Does not remove other suit(s))",
        }
      },
      c_fam_the_martyr = {
        name = "The Martyr",
        text = {
            "Creates {C:attention}#1#{} random cards",
        }
      },
      c_fam_the_midnight = {
        name = "The Midnight",
        text = {
            "Adds {C:clubs}Clubs{} to up",
            "to {C:attention}#1#{} selected cards.",
            "{C:inactive}(Does not remove other suit(s))",
        }
      },
      c_fam_the_pit = {
        name = "The Pit",
        text = {
            "Turns up to {C:attention}#1#{} selected",
            "cards to {C:GREY}Suitless",
            "{C:inactive}(Suitless cards always score)",
        }
      },
      c_fam_the_queen = {
        name = "The Queen",
        text = {
            "Enhances {C:attention}#1#{} selected card",
            "into a {C:attention}Div Card{}.",
        }
      },
      c_fam_verdict = {
        name = "Verdict",
        text = {
            "Creates a random",
            "{C:attention}Consumble{} card",
        }
      },
      c_fam_vigor = {
        name = "Vigor",
        text = {
            "Increases rank of",
            "{C:attention}one{} selected card",
            "by {C:attention}3",
        }
      },
    },
    Familiar_Planets = {
      c_fam_hades = {
        name = "Hades",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_hecate = {
        name = "Hecate",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_hermes = {
        name = "Hermes",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_poseidon = {
        name = "Poseidon",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_terra = {
        name = "Terra",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_zeus = {
        name = "Zeus",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_aphrodite = {
        name = "Aphrodite",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_ares = {
        name = "Ares",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_caelus = {
        name = "Caelus",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_cronus = {
        name = "Cronus",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_demeter = {
        name = "Demeter",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
      c_fam_discordia = {
        name = "Discordia",
        text = {
            "(lvl:#1#+i) Imaginary Level Up",
            "{C:attention}#4#",
            "{C:red}X#2#{} Mult and",
            "{C:blue}X#3#{} chips",
        }
      },
    },
    Familiar_Spectrals = {
      c_fam_forge = {
        name = "Forge",
        text = {
            "Add a {C:money}Gilded Seal",
            "to 2 {C:attention}selected cards{}",
            "in your hand",
        }
      },
      c_fam_mesmer = {
        name = "Mesmer",
        text = {
            "Add a {C:blue}Sapphire Seal",
            "to one {C:attention}selected card{}",
            "in your hand",
        }
      },
      c_fam_naked_singularity = {
        name = "Naked Singularity ",
        text = {
            "Upgrade every",
            "{C:legendary,E:1}poker hand{} by",
            "{C:attention}1+i{} Imaginary level"
        }
      },
      c_fam_oracle = {
        name = "Oracle",
        text = {
            "Add a Familiar Seal",
            "to one {C:attention}selected card{}",
            "in your hand",
        }
      },
      c_fam_overlap = {
        name = "Overlap",
        text = {
            "Applies a {C:attention}selected suit{} to all",
            "cards in hand, {C:mult}-#1#{} hand size",
            "{C:inactive}(does not override previous suit)",
        }
      },
      c_fam_playback = {
        name = "Playback",
        text = {
            "Add a {C:red}Maroon Seal",
            "to one {C:attention}selected card{}",
            "in your hand",
        }
      },
      c_fam_shade = {
        name = "Shade",
        text = {
            "{C:green,E:1,S:1.1}#3# in #2#{} chance to",
            "create a {C:mult}rare{} joker",
            "{C:green,E:1,S:1.1}#3# in #1#{} chance to",
            "set money to {C:attention}-$10{}",
        }
      },
    },
    Spectral = {
      c_fam_the_fool_qm = {
        name = "The Fool?",
        text = {
            "Creates a {C:attention}Jester{} counterpart ",
            "of a selected Joker in hand.",
        }
      },
    },
    tekana = {
      c_fam_desolate_wanderer = {
        name = "Desolate Wanderer",
        text = {
            "Add a {C:money}Gilded Seal",
            "to 2 {C:attention}selected cards{}",
            "in your hand",
        }
      },
      c_fam_internet = {
        name = "The Internet",
        text = {
            "Converts up to",
            "{C:attention}3{} selected cards",
            "to {C:web}Webs",
        }
      },
    },
    Voucher = {
      v_fam_pickpocket = {
        name = 'Pickpocket',
        text = {
            "{C:attention}+#1#{} hand size",
            "{C:mult}-#2#{} discards",
        }
      },
      v_fam_sleight_of_hand = {
        name = 'Sleight of Hand',
        text = {
            "{C:blue}+#1#{} hand",
            "{C:mult}-#2#{} discard",
        }
      },
    },
    Tag = {
      tag_fam_statics = {
        name = "Static Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Static'
        }
      },
      tag_fam_aureate = {
        name = "Aureate Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Aureate'
        }
      },
      tag_fam_mezmerize_tag = {
        name = "Mezmerize Pin",
        text = {
            "Gives a free",
            "Fortune Chest"
        }
      },
      tag_fam_Zeus_tag = {
        name = "Pin of Zeus",
        text = {
            "Gives a free",
            "Pantheon Chest"
        }
      },
      tag_fam_speckle = {
        name = "Speckled Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Speckled'
        }
      },
      tag_fam_specter_tag = {
        name = "Specter Pin",
        text = {
            "Gives a free",
            "{C:red}Ethereal Pack"
        }
      },
    },
    Enhanced = {
      m_fam_charmed = {
        name = 'Charmed',
        text = {
            "{C:green,E:1,S:1.1}#3# in #1#{} chance",
            "for {C:blue}+#2#{} Chips",
            "{C:green,E:1,S:1.1}#3# in #4#{} chance",
            "for a random {C:attention}Tarot{} card",
        }
      },
      m_fam_split = {
        name = 'Split',
        text = {
            "Copies {C:attention}suit{} on the card",
            "to its right and {C:attention}rank",
            "to its left",
        }
      },
      m_fam_div = {
        name = 'Div',
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "{C:blue}+#2#{} Chips",
        }
      },
      m_fam_jewel = {
        name = 'Jewel',
        text = {
            "{X:blue,C:white}X#1#{} Chips",
            "no rank or suit"
        }
      },
      m_fam_stainless = {
        name = 'Stainless',
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "{C:blue}+#2#{} Chips",
            "Cannot have {C:dark_edition}Editions{}",
            "Cannot be {C:red}debuffed",
        }
      },
      m_fam_stained_glass = {
        name = 'Stained Glass',
        text = {
            "Gains random {C:dark_edition}Edition",
            "every time it scores",
            "{C:green,E:1,S:1.1}#2# in #1#{} chance to shatter",
            "{C:inactive}(Keeps effects of lost Editions)",
        }
      },
      m_fam_gilded = {
        name = 'Gilded',
        text = {
            "{C:money}$#1#{} when held in hand",
            "decreases by {C:money}$#2#{} each use",
            "becomes a {C:attention}steel card",
            "after {C:attention}#3#{} uses.",
        }
      },
      m_fam_penalty = {
        name = 'Penalty',
        text = {
            "{C:red}+#1#{} Mult",
            "{C:blue}-#2#{} Chips",
        }
      }
    },
    Edition = {
      e_fam_aureate = {
        name = "Aureate",
        text = {
            "{X:money,C:white}$#1#{}"
        }
      },
      e_fam_speckle = {
        name = "Speckled",
        text = {
            "{C:blue}+null{} Chips",
            "{C:red}+null{} Mult"
        }
      },
      e_fam_statics = {
        name = "Static",
        text = {
            "{X:chips,C:white} X#1# {} Chips"
        }
      },
    },
    Other = {
      -- Seals - this is fine
      fam_familiar_seal_seal = {
        name = 'Familiar Seal',
        text = {
            'Creates a {C:attention}Familiar tarot{} when',
            'only this card is {C:attention}discarded',
        }
      },
      fam_gilded_seal_seal = {
        name = 'Gilded Seal',
        text = {
            '{C:money}$5{} when played, {C:green,E:1,S:1.1}#2# in #1#{} chance',
            'that it gives {C:money}-$5{} instead.',
        }
      },
      fam_maroon_seal_seal = {
        name = 'Maroon Seal',
        text = {
            'Retrigger leftmost',
            'card {C:attention}1{} time',
        }
      },
      fam_sapphire_seal_seal = {
        name = 'Sapphire Seal',
        text = {
            'Creates a {C:blue}Spectral{} card',
            'if {C:attention}held in hand{} until',
            'the end of round',
        }
      },
      -- Stickers
      fam_locked = {
        name = "Locked",
		text = {
			"Locked in its ",
			"starting position",
		}
      },
      fam_sample = {
        name = "Sample",
		text = {
			"{C:attention}Free{}, but {C:attention}1/3{}",
			"as effective",
		}
      },
      fam_unstable = {
        name = "Unstable",
		text = {
			"{C:green}#1# in 3{} chance this",
			"joker is debuffed",
			"at end of round",
			"{C:inactive}(debuffed till next round){}"
		}
      },
      -- Boosters
      p_fam_ethereal_booster_3 = {
        name = "Ethereal Collector Chest",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Memento Cards"
        }
      },
      p_fam_ethereal_booster_1 = {
        name = "Ethereal Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Memento Cards"
        }
      },
      p_fam_ethereal_booster_2 = {
        name = "Ethereal Booster Tin",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Memento Cards"
        }
      },
      p_fam_forture_booster_3 = {
        name = "Fortune Collector Chest",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Fortune Cards"
        }
      },
      p_fam_forture_booster_1 = {
        name = "Fortune Pack",
        text = {
            "Choose {C:attention}#2#{} of up to",
			"{C:attention}#3#{} Fortune Cards"
        }
      },
      p_fam_forture_booster_2 = {
        name = "Fortune Booster Tin",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Fortune Cards"
        }
      },
      p_fam_pantheon_booster_3 = {
        name = "Pantheon Chest",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Sacred Cards"
        }
      },
      p_fam_pantheon_booster_1 = {
        name = "Pantheon Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Sacred Cards"
        }
      },
      p_fam_pantheon_booster_2 = {
        name = "Pantheon Tin",
        text = {
            "Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} Sacred Cards"
        }
      },
    },
  },
  misc = {
    dictionary = {
      
    },
    v_dictionary = {
      a_stock = "+#1# Stock"
    },
    suits_singular = {
      --N/A
    },
    suits_plural = {
      --N/A
    },
    poker_hands = {
      --N/A
    },
    poker_hand_descriptions = {
      --N/A
    },
    labels = {
      fam_aureate = "Aureate",
      fam_speckle = "Speckled",
      fam_statics = "Static",
      fam_familiar_seal_seal = 'Familiar Seal',
      fam_gilded_seal_seal = 'Gilded Seal',
      fam_maroon_seal_seal = 'Maroon Seal',
      fam_sapphire_seal_seal = 'Sapphire Seal',
      fam_locked = "Locked",
      fam_sample = "Sample",
      fam_unstable = "Unstable",
      fam_Familiar_Tarots = 'Fortune',
      fam_Familiar_Planets = 'Sacred',
      fam_Familiar_Spectrals = 'Mementos',
      fam_tekana = 'Tekana',
    }
  }
}
