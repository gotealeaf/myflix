# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'Science Fiction')
sf = Category.find_by_name('Science Fiction')

Video.create(
  category: sf,
  title: 'Star Wars IV',
  description: "Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a wookiee and two droids to save the universe from the Empire's world-destroying battle-station, while also attempting to rescue Princess Leia from the evil Darth Vader.",
  small_cover_url: "http://placehold.it/166x236&text=Star+Wars+IV",
  large_cover_url: "http://placehold.it/665x375&text=Star+Wars+IV")

Video.create(
  category: sf,
  title: 'Star Wars V',
  description: "After the rebels have been brutally overpowered by the Empire on their newly established base, Luke Skywalker takes advanced Jedi training with Master Yoda, while his friends are pursued by Darth Vader as part of his plan to capture Luke.",
  small_cover_url: "http://placehold.it/166x236&text=Star+Wars+V",
  large_cover_url: "http://placehold.it/665x375&text=Star+Wars+V")

Video.create(
  category: sf,
  title: 'Star Wars VI',
  description: "After rescuing Han Solo from the palace of Jabba the Hutt, the Rebels attempt to destroy the Second Death Star, while Luke Skywalker tries to bring his father back to the Light Side of the Force.",
  small_cover_url: "http://placehold.it/166x236&text=Star+Wars+VI",
  large_cover_url: "http://placehold.it/665x375&text=Star+Wars+VI")

  Video.create(
    category: sf,
    title: 'Star Wars IV',
    description: "Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a wookiee and two droids to save the universe from the Empire's world-destroying battle-station, while also attempting to rescue Princess Leia from the evil Darth Vader.",
    small_cover_url: "http://placehold.it/166x236&text=Star+Wars+IV",
    large_cover_url: "http://placehold.it/665x375&text=Star+Wars+IV")

  Video.create(
    category: sf,
    title: 'Star Wars V',
    description: "After the rebels have been brutally overpowered by the Empire on their newly established base, Luke Skywalker takes advanced Jedi training with Master Yoda, while his friends are pursued by Darth Vader as part of his plan to capture Luke.",
    small_cover_url: "http://placehold.it/166x236&text=Star+Wars+V",
    large_cover_url: "http://placehold.it/665x375&text=Star+Wars+V")

  Video.create(
    category: sf,
    title: 'Star Wars VI',
    description: "After rescuing Han Solo from the palace of Jabba the Hutt, the Rebels attempt to destroy the Second Death Star, while Luke Skywalker tries to bring his father back to the Light Side of the Force.",
    small_cover_url: "http://placehold.it/166x236&text=Star+Wars+VI",
    large_cover_url: "http://placehold.it/665x375&text=Star+Wars+VI")

  Video.create(
    category: sf,
    title: 'Star Wars VI',
    description: "After rescuing Han Solo from the palace of Jabba the Hutt, the Rebels attempt to destroy the Second Death Star, while Luke Skywalker tries to bring his father back to the Light Side of the Force.",
    small_cover_url: "http://placehold.it/166x236&text=Star+Wars+VI",
    large_cover_url: "http://placehold.it/665x375&text=Star+Wars+VI")

Category.create(name:'Fantasy Fiction')
ff = Category.find_by_name('Fantasy Fiction')

Video.create(
  category: ff,
  title: 'The NeverEnding Story',
  description: "A troubled boy dives into a wonderous fantasy world through the pages of a mysterious book.",
  small_cover_url: "http://placehold.it/166x236&text=Neverending+Story",
  large_cover_url: "http://placehold.it/665x375&text=Neverending+Story")

Video.create(
  category: ff,
  title: 'In The Name of the King',
  description: "A man named Farmer sets out to rescue his kidnapped wife and avenge the death of his son -- two acts committed by the Krugs, a race of animal-warriors who are controlled by the evil Gallian.",
  small_cover_url: "http://placehold.it/166x236&text=Name+Of+The+King",
  large_cover_url: "http://placehold.it/665x375&text=Name+Of+The+King")
