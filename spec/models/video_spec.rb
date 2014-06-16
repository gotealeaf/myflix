require 'rails_helper'

describe Video do
  it "saves to database" do
    soth = Video.new(name: 'shaun of the dead',
                 slug: 'shaun_of_the_dead',
                 duration: '97', year: '2004',
                 large_cover_url: 'sotd_lrg.jpg',
                 small_cover_url: 'sotd_sml.jpg',
                 description: "It's often said that the true character of a man is only revealed in times of dire crisis, and for likable, lovelorn loser Shaun (Simon Pegg), that moment of reckoning came when the dead rose from their slumber to feast on the flesh of the living. A hapless electronics store employee who spends most of his spare time downing pints at the local pub with his roommate, Ed (Nick Frost), Shaun's life seems to fall apart when he is dumped by his girlfriend, Liz (Kate Ashfield), and his obnoxious stepfather, Philip (Bill Nighy), shows up to berate him for not being more attentive to his caring mother Barbara (Penelope Wilton) -- especially since he forgot to send flowers for her birthday. Things take a turn for the worse when the dead return to stake their claim on the Earth, and though the chaos that follows threatens to swallow up all of England, it's up to Shaun to keep his cool and prove himself once and for all by successfully rescuing Liz and his mother. With his trusty roommate by his side, nothing -- not even the living dead -- can stand between Shaun and the two most important women in his life. ~ Jason Buchanan, Rovi")
    soth.save

    expect(Video.first.name).to eq(soth.name)
  end
end
