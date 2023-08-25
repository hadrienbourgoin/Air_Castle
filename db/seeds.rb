# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

User.destroy_all
User.create!(email: "test@gmail.com",
             password: "azerty",
             password_confirmation: "azerty",
             first_name: "test",
             last_name: "test",
             username: "tester1",
             avatar: "https://dessins-animes-hrd.appspot.com/img/dessins-animes/davidlegnome.jpg")
User.create!(email: "test2@gmail.com",
             password: "azerty",
             password_confirmation: "azerty",
             first_name: "test2",
             last_name: "test2",
             username: "tester2",
             avatar: "https://dessins-animes-hrd.appspot.com/img/dessins-animes/davidlegnome.jpg")
20.times do
  password = Faker::Internet.password
  User.create!(email: Faker::Internet.email,
               password: password,
               password_confirmation: password,
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               username: Faker::Internet.username(specifier: 6..10),
               avatar: "https://dessins-animes-hrd.appspot.com/img/dessins-animes/davidlegnome.jpg")
end

addresses = %i[20 rue des capucins, Lyon
  69 rue Henri Gorjus, Lyon
  33 Rue de Margnolles, 69300 Caluire-et-Cuire
  7 Rue de Cuire, 69004 Lyon
  19 Rue Tissot, 69009 Lyon
  8 bis Quai Saint-Vincent, 69001 Lyon
  35 Rue Juliette Récamier, 69006 Lyon
  Parc de la Tête d'Or, Rue de Créqui, 69006 Lyon
  103 Gd Rue de la Croix-Rousse, 69004 Lyon
  8 Pl. de Fourvière, 69005 Lyon
  43 Rue des Docks, 69009 Lyon
  41 Rue René Leynaud, 69001 Lyon
  44 Rue de la Villette, 69000 Lyon
  52 Rue Alexis Perroncel, 69100 Villeurbanne
  36 Bd des Canuts, 69004 Lyon
  43 Bd du 11 Novembre 1918, 69100 Villeurbanne
  10 Chem. Petit 10, 69300 Caluire-et-Cuire
  68 Rue François Mermet, 69160 Tassin-la-Demi-Lune
  112 Cr Charlemagne, 69002 Lyon
  86 Quai Perrache, 69002 Lyon
  3 Rue Pré-Gaudry, 69007 Lyon
  228 Av. Berthelot, 69008 Lyon
  Av. du Chater, 69340 Francheville
  185 Chem. du Bois de la Ligue, 71520 Dompierre-les-Ormes
  187 Grande Rue, 71520 Dompierre-les-Ormes
  Le Bourg, 71520 Dompierre-les-Ormes
  57 Rue de la Gendarmerie, 71520 Dompierre-les-Ormes
  473 route de, 71520 Trambly
  Croix de Mission, 71520 Matour
  2 Rue de la Piscine, 71520 Matour
  Manoir du Parc, 71520 Matour
  1 Rue de la Légion d'Honneur, 75007 Paris
  Champ de Mars, 5 Av. Anatole France, 75007 Paris
  92 Bd de la République, 92100 Boulogne-Billancourt
  627 H St NW, Washington, DC 20001, United States
  2001 11th St NW, Washington, DC 20001, United States
  321 Sherman Dr, Fort Myer, VA 22211, United States
  1109 N Highland St, Arlington, VA 22201, United States
  1200 N Courthouse Rd, Arlington, VA 22201, United States
  3211 Wilson Blvd, Arlington, VA 22201, United States]

upload = 1
50.times do
  Cloudinary::Uploader.upload("https://commedesfrancais.com/uploads/images/global/main_pictures/5ea979aaea92d277586719.jpg",
                              folder: "development")
  p "#{200 - upload} uploads left"
  upload += 1
end
50.times do
  Cloudinary::Uploader.upload("https://furansujapon.com/wp-content/uploads/2022/06/chateau-de-Matsumoto-1052x592.jpg",
                              folder: "development")
  p "#{200 - upload} uploads left"
  upload += 1
end
50.times do
  Cloudinary::Uploader.upload("https://static.nationalgeographic.fr/files/styles/image_3200/public/Pyramids-at-Giza.ngsversion.1458139144541.png",
                              folder: "development")
  p "#{200 - upload} uploads left"
  upload += 1
end
50.times do
  Cloudinary::Uploader.upload("https://www.neonmag.fr/imgre/fit/~1~NEO~2020~11~16~959a63fb-576c-40ca-b4d1-13716fd3d659.jpeg/1200x630/quality/80/avec-le-confinement-la-vente-de-manoirs-anglais-explose.jpg",
                              folder: "development")
  p "#{200 - upload} uploads left"
  upload += 1
end
response = Cloudinary::Search
                   .expression('resource_type:image AND folder="development"')
                   .sort_by('public_id', 'desc')
                   .max_results(200)
                   .execute
castles_pictures = []

response.to_a[3][1].each { |hash| castles_pictures << hash }
castles_pictures.shuffle
i = 0
castle_count = 1
40.times do
  castle = Castle.create!(user: User.all.sample,
                          name: "Castle #{Faker::Name.name}",
                          price: Faker::Commerce.price(range: 50..1000),
                          address: addresses.sample,
                          description: Faker::Movie.quote)

  5.times do
    castle.photos.attach(io: URI.open(castles_pictures[i]["url"]), filename: castles_pictures[i]["filename"], content_type: "image/jpg")
    Cloudinary::Uploader.destroy(castles_pictures[i]["public_id"])
    i += 1
  end
  p "#{40 - castle_count} castles left to build"
  castle_count += 1
end

today = Date.today
10.times do
  begin_date = (today..(today + 30.days)).to_a.sample
  end_date = ((begin_date + 1.days)..((begin_date + 1.days) + 30.days)).to_a.sample
  Booking.create!(date_begin: begin_date,
                  date_end: end_date,
                  user: User.all.sample,
                  castle: Castle.all.sample)
end
