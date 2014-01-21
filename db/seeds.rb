# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.delete_all
Category.delete_all
User.delete_all
Review.delete_all

c1 = Category.create(name: "Biographies")
c2 = Category.create(name: "Political Dramas")
c3 = Category.create(name: "Romantic Dramas")

user_1 = User.create(email: "jlevinger@jtonedesigns.com", password: "joelevinger", full_name: "Joe Levinger")
user_2 = User.create(email: "steve@gotealeaf.com", password: "steveturczyn", full_name: "Steve Turczyn")
user_3 = User.create(email: "lisamurphy0205@earthlink.net", password: "lisamurphy", full_name: "Lisa Murphy")

gandhi = Video.create(title: "Gandhi", description: "This awe-inspiring biopic about Mahatma Gandhi -- the diminutive lawyer who stood up against British rule in India and became an international symbol of nonviolence and understanding -- brilliantly underscores the difference one person can make.", small_cover_url: 'tmp/gandhi.jpg', large_cover_url: 'tmp/gandhi_large.jpg', category: c1)
Review.create(body: "No doubt one of the very best historical and biographical films ever made. Gandhi, as portrayed by Ben Kingsley, is completely accessible and lovable. The man had important things to say, and he did so in little ways. Don't worry, this is not a preachy film, unless you consider a film about someone who will go to any lengths to live by his basic principles, preachy. Mohandas K. Gandhi is an inspiration to all of us, especially those of us who call ourselves Christian and see how this little half-clothed man, a Hindu, practiced the teachings of Jesus more than most of us. No wonder Martin Luther King was inspired by his teachings and life. If you do not see this DVD (with excellent cinematography and music, by the way), you are depriving yourself of a most extraordinary experience. I'm serious!", rating: 5, video: gandhi, user: user_1)
Review.create(body: "I’m glad I saw Gandhi. This movie gave me insight into the life of Mahatma Gandhi that I didn’t have before. It is also very interesting to see Ben Kingsley completely disappear into the role of this iconic historical figure. However, like many other biopics, the quest to cover a person’s whole life tends to drag when you put it on the screen. It’s an educational film. It’s a well-made film. But it’s not a film I would choose to watch again.", rating: 3, video: gandhi, user: user_2)
Review.create(body: "Amazing, amazing movie! I know that this is an older film, but it was well casted and the overall plot was great. I liked that there really wasn't any cursing or sexuality in the film, unlike so many modern films. I give this movie an \"A.\"", rating: 5, video: gandhi, user: user_3)

Video.create(title: "The Iron Lady", description: "Meryl Streep provides a subtle and nuanced portrait of Margaret Thatcher, the first female prime minister of Britain, whose political career and determination changed the rules that had limited women's opportunities for leadership.", small_cover_url: 'tmp/ironlady.jpg', large_cover_url: 'tmp/ironlady_large.jpg', category: c1)
Video.create(title: "Lincoln", description: "Director Steven Spielberg takes on the towering legacy of Abraham Lincoln, focusing on his stewardship of the Union during the Civil War years. The biographical saga also reveals the conflicts within Lincoln's cabinet regarding the war and abolition.", small_cover_url: 'tmp/lincoln.jpg', large_cover_url: 'tmp/lincoln_large.jpg', category: c1)
Video.create(title: "John Adams", description: "Paul Giamatti shines in the title role of this epic Emmy and Golden Globe winner that recounts the life of founding father John Adams as revolutionary leader, America's first ambassador to England, the first vice president and the second president. The iconic cast of characters includes Abigail Adams (Laura Linney), George Washington (David Morse), Thomas Jefferson (Stephen Dillane) and Benjamin Franklin (Tom Wilkinson).", small_cover_url: 'tmp/johnadams.jpg', large_cover_url: 'tmp/johnadams_large.jpg', category: c1)
Video.create(title: "Lawrence of Arabia", description: "This Oscar-winning epic tells the true story of T.E. Lawrence, who helped unite warring Arab tribes to strike back against the Turks in World War I. This lush, timeless classic underscores the clash between cultures that changed the tide of war.", small_cover_url: 'tmp/lawrencearabia.jpg', large_cover_url: 'tmp/lawrencearabia_large.jpg', category: c1)
Video.create(title: "Raging Bull", description: "Robert De Niro won an Oscar for his portrayal of self-destructive boxer Jake LaMotta in Martin Scorsese's widely acclaimed biopic, which paints a raw portrait of a tormented soul unable to control his violent outbursts.", small_cover_url: 'tmp/ragingbull.jpg', large_cover_url: 'tmp/ragingbull_large.jpg', category: c1)
Video.create(title: "Che", description: "Eduardo Noriega stars as Ernesto \"Che\" Guevara in this riveting film that follows the fearless revolutionary as he takes up arms in Fidel Castro's bloody fight to overthrow Cuba's U.S.-backed government. As Che becomes a leader in guerilla warfare, his passion for social equality pushes him to the edge of brutality; his determination to purge oppression will make him a rebel to some, a hero to many and a legend to all.", small_cover_url: 'tmp/che.jpg', large_cover_url: 'tmp/che_large.jpg', category: c1)
Video.create(title: "Norma Rae", description: "In an Oscar-winning performance, Sally Field is unforgettable as Norma Rae Webster, the real-life Southern millworker who revolutionizes a small town and discovers a power within herself that she never knew she had. Under the guidance of a New York unionizer (Ron Leibman) and with increasing courage and determination, Norma Rae organizes her fellow factory workers to fight for better conditions and wages. Beau Bridges co-stars.", small_cover_url: 'tmp/normarae.jpg', large_cover_url: 'tmp/normarae_large.png', category: c1)
Video.create(title: "Frances", description: "Jessica Lange (nominated for the 1983 Best Actress Oscar) delivers the performance of her career as Frances Farmer, the notorious 1930s movie star whose impassioned opinions and outspoken behavior created scandal throughout the industry. When she was betrayed by the studio system and committed to an insane asylum by her domineering mother, Frances descended into a madness that exposed the cruelest consequences of Hollywood fame.", small_cover_url: 'tmp/frances.jpg', large_cover_url: 'tmp/frances_large.png', category: c1)
Video.create(title: "Schindler's List", description: "Liam Neeson stars as Oskar Schindler, a greedy German factory owner made rich by exploiting cheap Jewish labor. But as World War II unfolds, he becomes an unlikely humanitarian, spending his entire fortune to help save 1,100 Jews from Auschwitz.", small_cover_url: 'tmp/schindlerslist.jpg', large_cover_url: 'tmp/schindlerslist_large.png', category: c1)

Video.create(title: "Reds", description: "Radical journalist and socialist John Reed (Warren Beatty), along with his paramour, protofeminist Louise Bryant (Diane Keaton), gets swept up in the world-changing spirit, euphoria and aftermath of Russia's 1917 Bolshevik Revolution and the newly founded Soviet Union. Jack Nicholson, Paul Sorvino, Edward Herrmann, M. Emmet Walsh and Maureen Stapleton co-star in this Beatty-directed, Oscar-winning epic.", small_cover_url: 'tmp/reds.jpg', large_cover_url: 'tmp/reds_large.jpg', category: c2)
Video.create(title: "W.", description: "Featuring an all-star cast, director Oliver Stone's satiric retrospective chronicles the life and political career of George W. Bush, from his troubles as a young adult through his governorship of Texas and all the way to the Oval Office.", small_cover_url: 'tmp/w.jpg', large_cover_url: 'tmp/w_large.jpg', category: c2)
Video.create(title: "Bury My Heart at Wounded Knee", description: "A dark chapter of U.S. history comes to light in this epic saga (which earned an Emmy Award for Best Made-for-Television Movie) of the U.S. government's deliberate extermination of the American Indians. Beginning after the Sioux victory at Little Big Horn, the film traces the stories of three men: a Sioux doctor (Adam Beach), a lobbying senator (Aidan Quinn) and the Lakota hero Sitting Bull (August Schellenberg).", small_cover_url: 'tmp/burymyheart.jpg', large_cover_url: 'tmp/burymyheart_large.jpg', category: c2)
Video.create(title: "Mr. Smith Goes to Washington", description: "When idealistic junior senator Jefferson Smith (James Stewart) arrives in Washington, D.C., he's full of plans and dazzled by his surroundings -- qualities he retains despite widespread corruption among his cynical colleagues. Jean Arthur puts in a sharp performance as Smith's streetwise secretary, who helps him navigate his way through Congress, in this Academy Award-winning classic from director Frank Capra.", small_cover_url: 'tmp/mrsmith.jpg', large_cover_url: 'tmp/mrsmith_large.jpg', category: c2)
Video.create(title: "A Passage to India", description: "Adventurous young Englishwoman Adela Quested journeys to colonial India with open-minded Mrs. Moore. When the women accompany a \"native\" named Dr. Aziz on a tour of the Marabar Caves, the excursion turns ugly as Adela ends up accusing Aziz of rape.", small_cover_url: 'tmp/passageindia.jpg', large_cover_url: 'tmp/passageindia_large.jpg', category: c2)
Video.create(title: "The Candidate", description: "Bill McKay is a California lawyer urged to run against the seemingly unbeatable Republican incumbent in a senatorial race. McKay is a well-meaning innocent, but as support widens for his open platform, the sellout begins.", small_cover_url: 'tmp/candidate.jpg', large_cover_url: 'tmp/candidate_large.jpg', category: c2)
Video.create(title: "The Lion in Winter", description: "In this stylish costume drama, England's King Henry II (Peter O'Toole) and his dysfunctional family gather on Christmas Eve to decide who will inherit the throne. What ensues is a bitter battle of wills that strains every family bond of love and trust. Henry fancies youngest son John (Nigel Terry), but his iron-willed spouse (Katharine Hepburn) thinks the crown should go to eldest son Richard the Lionhearted (Anthony Hopkins, in his film debut).", small_cover_url: 'tmp/lioninwinter.jpg', large_cover_url: 'tmp/lioninwinter_large.png', category: c2)
Video.create(title: "The Pentagon Papers", description: "This compelling political drama is based on the true story of high-ranking Pentagon official Daniel Ellsberg (James Spader), who, during the Nixon era, strove to preserve American democracy by leaking top-secret documents to the New York Times and Washington Post. The documents in question would eventually become famous as the Pentagon Papers, which revealed the true reasons for U.S. involvement in Vietnam. Alan Arkin and Paul Giamatti co-star.", small_cover_url: 'tmp/pentagonpapers.jpg', large_cover_url: 'tmp/pentagonpapers_large.jpg', category: c2)
Video.create(title: "Tinker, Tailor, Soldier, Spy", description: "This gripping thriller about Cold War espionage follows an English spy as he returns to MI-6 under a cloud of suspicion. In the years since he was sacked by the agency, some suspect that he's become an operative for the Soviet Union.", small_cover_url: 'tmp/tinkertailor.jpg', large_cover_url: 'tmp/tinkertailor_large.jpg', category: c2)
Video.create(title: "All the King's Men", description: "Sean Penn stars as corrupt Southern politician Willie Stark -- a charismatic man who wins the populist vote but, behind closed doors, is as underhanded as those he smeared -- in this remake of an Oscar-winning 1949 film of the same name. Ex-reporter Jack Burden (Jude Law) unwittingly helps Stark gain political power, but it's just a matter of time before the governor's crooked dealings are exposed.", small_cover_url: 'tmp/kingsmen.jpg', large_cover_url: 'tmp/kingsmen_large.jpg', category: c2)

Video.create(title: "Dr. Zhivago", description: "As political turmoil rumbles through Russia, Doctor Zhivago is trapped in a love triangle between his wife and his mistress. Meanwhile, the Bolshevik Revolution will change all their lives forever in this miniseries remake of the classic 1965 film.", small_cover_url: 'tmp/drzhivago.jpg', large_cover_url: 'tmp/drzhivago_large.png', category: c3)
Video.create(title: "Hope Springs", description: "After decades of marriage, Kay and Arnold go to a couples' counselor in order to spice things up and reconnect. The real challenge for both of them comes as they try to reignite the spark that made them fall for each other in the first place.", small_cover_url: 'tmp/hopesprings.jpg', large_cover_url: 'tmp/hopesprings_large.jpg', category: c3)
Video.create(title: "Water for Elephants", description: "In this captivating Depression-era melodrama, impetuous veterinary student Jacob Jankowski joins a celebrated circus as an animal caretaker but faces a wrenching dilemma when he's transfixed by angelic married performer Marlena.", small_cover_url: 'tmp/waterelephants.jpg', large_cover_url: 'tmp/waterelephants_large.jpg', category: c3)
Video.create(title: "Jane Eyre", description: "Driven from her post at Thornfield House by her love for her brooding employer and his secret past, young governess Jane Eyre reflects on her youth and the events that led her to the misty moors in this artful adaptation of Charlotte Brontë's novel.", small_cover_url: 'tmp/janeeyre.jpg', large_cover_url: 'tmp/janeeyre_large.jpg', category: c3)
Video.create(title: "Atonement", description: "When 13-year-old Briony discovers a lustful letter and witnesses a sexual encounter between her older sister and a servant's son, her confusion prompts her to finger the young man for a violent crime. Her half-truth changes their lives forever.", small_cover_url: 'tmp/atonement.jpg', large_cover_url: 'tmp/atonement_large.jpg', category: c3)
Video.create(title: "The Great Gatsby", description: "Leonardo DiCaprio stars as literary icon Jay Gatsby in this adaptation of F. Scott Fitzgerald's novel. Fascinated by the mysterious, affluent Gatsby, his neighbor Nick Carraway bears witness to the man's obsessive love and spiral into tragedy.", small_cover_url: 'tmp/greatgatsby.jpg', large_cover_url: 'tmp/greatgatsby_large.jpg', category: c3)
Video.create(title: "Les Misérables", description: "The musical version of Victor Hugo's epic tale of love and sacrifice, first produced for the stage in 1985, now receives the big-screen treatment. The bloody era of the French Revolution is the backdrop to Jean Valjean's long struggle for redemption.", small_cover_url: 'tmp/lesmiserables.jpg', large_cover_url: 'tmp/lesmiserables_large.jpg', category: c3)
Video.create(title: "Pride & Prejudice", description: "In this retelling of Jane Austen's novel set in 19th-century England, Mrs. Bennet is all atwitter in hopes of marrying her daughters to prosperous gentlemen callers, especially when a wealthy bachelor moves nearby.", small_cover_url: 'tmp/prideprejudice.jpg', large_cover_url: 'tmp/prideprejudice_large.jpg', category: c3)
Video.create(title: "Triston & Isolde", description: "When gallant English knight Tristan wins the love of beautiful Isolde -- the daughter of the Irish king -- soon after the fall of the Roman Empire, their liaison threatens to destroy the uneasy truce between their respective nations.", small_cover_url: 'tmp/tristanisolde.jpg', large_cover_url: 'tmp/tristanisolde_large.jpg', category: c3)
Video.create(title: "Chocolat", description: "A single mother and her young daughter move into a peaceful French village and open a chocolate shop during the height of Lent. At first, the shop's rich, sensuous desserts scandalize the town. But the villagers soon learn to savor the sweetness.", small_cover_url: 'tmp/chocolat.jpg', large_cover_url: 'tmp/chocolat_large.jpg', category: c3)

