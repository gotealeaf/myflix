require 'spec_helper'

describe Category do
  # it 'save itself' do
  #   category = Category.new(name: "Movie")   
  #   category.save
  #   expect(Category.first.name).to eq("Movie") 
  # end

  # it "has many videos" do
  #   category = Category.new(name: "Movie")   
  #   category.save
  #   video1 = Video.new(title: "Bones test", description: 'Test informations', small_cover_url: '/img/bones_small.jpg', large_cover_url: '/img/bones_large.jpg', category_id: 1)
  #   video1.save
  #   video2 = Video.new(title: "Another Bones", description: 'Test informations 2', small_cover_url: '/img/bones_small2.jpg', large_cover_url: '/img/bones_large2.jpg', category_id: 1)
  #   video2.save
  #   category.videos.size.should == 2
  #   expect(category.videos).to eq([video2, video1])
  # end

  # it "is invalid if has a same name" do
  #   Category.create(name: "Animation")
  #   expect(Category.create(name: "Animation")).to have(1).errors_on(:name)  
  # end
  #
  #
  # rewrite using shoulda matchers

  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}

  it "returns videos in the reverse chronical order by created_at" do
    drama  = Category.create(name: "Drama")
    toy    = Video.create(title: 'Toy Story 3', description: "The toys are mistakenly delivered to a" , created_at: 1.month.ago, category: drama)
    totoro = Video.create(title: 'My Neighbour Totoro', description: "When two girls move to the cou", created_at: 2.months.ago, category: drama)
    howl   = Video.create(title: "Howl's Moving Castle", description: "When an unconfident young wom", created_at: 10.days.ago, category: drama)
    truman = Video.create(title: "The Truman Show", description: "An insurance salesman/adjuster dis", created_at: 15.days.ago, category: drama)
    bruce  = Video.create(title: "Bruce Almighty", description: "A guy who complains about God too o", created_at: 10.months.ago, category: drama)
    bean   = Video.create(title: "Bean The Movie", description: "The bumbling Mr. Bean travels to Am", created_at: 12.months.ago, category: drama)
    inter  = Video.create(title: "The Internship", description: "Two salesmen whose careers have bee", created_at: 13.days.ago, category: drama)
    gump   = Video.create(title: "Forrest Gump", description: "Forrest Gump, while not intelligent", created_at: 1.hour.ago, category: drama)
    ryan   = Video.create(title: "Saving Private Ryan", description: "Following the Normandy Landing", created_at: 7.month.ago, category: drama)
    expect(drama.recent_videos).to eq([gump, howl, inter, truman, toy, totoro])
  end

  it "returns all the videos if there are less than 6 videos" do
    drama  = Category.create(name: "Drama")
    toy    = Video.create(title: 'Toy Story 3', description: "The toys are mistakenly delivered to a" , created_at: 1.month.ago, category: drama)
    totoro = Video.create(title: 'My Neighbour Totoro', description: "When two girls move to the cou", created_at: 2.months.ago, category: drama)
    expect(drama.recent_videos.size).to eq(2)
  end

  it "returns only 6 videos when there are more than 6 videos" do
    drama  = Category.create(name: "Drama")
    toy    = Video.create(title: 'Toy Story 3', description: "The toys are mistakenly delivered to a" , created_at: 1.month.ago, category: drama)
    totoro = Video.create(title: 'My Neighbour Totoro', description: "When two girls move to the cou", created_at: 2.months.ago, category: drama)
    howl   = Video.create(title: "Howl's Moving Castle", description: "When an unconfident young wom", created_at: 10.days.ago, category: drama)
    truman = Video.create(title: "The Truman Show", description: "An insurance salesman/adjuster dis", created_at: 15.days.ago, category: drama)
    bruce  = Video.create(title: "Bruce Almighty", description: "A guy who complains about God too o", created_at: 10.months.ago, category: drama)
    bean   = Video.create(title: "Bean The Movie", description: "The bumbling Mr. Bean travels to Am", created_at: 12.months.ago, category: drama)
    inter  = Video.create(title: "The Internship", description: "Two salesmen whose careers have bee", created_at: 13.days.ago, category: drama)
    gump   = Video.create(title: "Forrest Gump", description: "Forrest Gump, while not intelligent", created_at: 1.hour.ago, category: drama)
    ryan   = Video.create(title: "Saving Private Ryan", description: "Following the Normandy Landing", created_at: 7.month.ago, category: drama)
    bones  = Video.create(title: 'Bones', description: "Bones was one of several series which popped up", created_at: 2.years.ago, category: drama)
    expect(drama.recent_videos).not_to include(bones, bruce, bean)
  end

  it "returns an empty array if no recent videos in this category" do
    drama  = Category.create(name: "Drama")
    expect(drama.recent_videos).to eq([])
  end
end
