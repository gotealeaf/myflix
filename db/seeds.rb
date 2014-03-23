category_names = ["TV Commedies", "TV Dramas","Reality TV"]

category_names.each do |category_name|
  Category.create!(name: category_name)
end

(1..3).each do |i|
  category = Category.find_by_name(category_names[i-1])

  Video.create!(
    title: "Monk - #{i}",
    description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk. It originally ran from 2002 to 2009 and is primarily a police procedural series, and also exhibits comic and dramatic tones in its exploration of the main characters' personal lives. The series was produced by Mandeville Films and Touchstone Television in association with Universal Television.",
    small_cover_path: "/tmp/monk.jpg",
    large_cover_path: "/tmp/monk_large.jpg",
    category_id: category.id
  )

  Video.create!(
    title: "Family Guy - #{i}",
    description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often lampoon American culture.",
    small_cover_path: "/tmp/family_guy.jpg",
    large_cover_path: "/tmp/family_guy_large.jpg",
    category_id: category.id
  )

  Video.create!(
    title: "Futurama - #{i}",
    description: "Futurama is an American adult animated science fiction sitcom created by Matt Groening and developed by Groening and David X. Cohen for the Fox Broadcasting Company. The series follows the adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century. The series was envisioned by Groening in the late 1990s while working on The Simpsons, later bringing Cohen aboard to develop storylines and characters to pitch the show to Fox.",
    small_cover_path: "/tmp/futurama.jpg",
    large_cover_path: "/tmp/futurama_large.jpg",
    category_id: category.id
  )

  Video.create!(
    title: "South Park - #{i}",
    description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. Intended for mature audiences, the show has become famous for its crude language and dark, surreal humor that satirizes a wide range of topics. The ongoing narrative revolves around four boys—Stan Marsh, Kyle Broflovski, Eric Cartman, and Kenny McCormick—and their bizarre adventures in and around the titular Colorado town.",
    small_cover_path: "/tmp/south_park.jpg",
    large_cover_path: "/tmp/south_park_large.jpg",
    category_id: category.id
  )

  if i == 1
    # Add some more video
    Video.create!(
      title: "Monk - 1 - 5",
      description: "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk. It originally ran from 2002 to 2009 and is primarily a police procedural series, and also exhibits comic and dramatic tones in its exploration of the main characters' personal lives. The series was produced by Mandeville Films and Touchstone Television in association with Universal Television.",
      small_cover_path: "/tmp/monk.jpg",
      large_cover_path: "/tmp/monk_large.jpg",
      category_id: category.id
    )

    Video.create!(
      title: "Family Guy - 1 - 6",
      description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often lampoon American culture.",
      small_cover_path: "/tmp/family_guy.jpg",
      large_cover_path: "/tmp/family_guy_large.jpg",
      category_id: category.id
    )

    Video.create!(
      title: "Futurama - 1 - 7",
      description: "Futurama is an American adult animated science fiction sitcom created by Matt Groening and developed by Groening and David X. Cohen for the Fox Broadcasting Company. The series follows the adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century. The series was envisioned by Groening in the late 1990s while working on The Simpsons, later bringing Cohen aboard to develop storylines and characters to pitch the show to Fox.",
      small_cover_path: "/tmp/futurama.jpg",
      large_cover_path: "/tmp/futurama_large.jpg",
      category_id: category.id
    )
  end
end

user = User.create(email: "tester@example.com", password: "password", full_name: "Tester Chen")

video = Video.first
video.reviews.create(rating: 4, user: user, comment: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
video.reviews.create(rating: 5, user: user, comment: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
video.reviews.create(rating: 3, user: user, comment: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
