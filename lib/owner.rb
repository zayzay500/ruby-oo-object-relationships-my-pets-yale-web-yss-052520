require_relative "cat.rb"
require_relative "dog.rb"

class Owner
  # code goes here
  attr_reader :name, :species

  @@all = []

  def initialize(name)
    @name = name
    @species = "human"

    save
  end

  def save
    self.class.all << self
  end

  def say_species
    "I am a #{self.species}."
  end

  def cats
    pet_select_by_owner(Cat)
  end

  def dogs
    pet_select_by_owner(Dog)
  end

  def buy_cat(name)
    buy_animal(Cat, name, self)
  end

  def buy_dog(name)
    buy_animal(Dog, name, self)
  end

  def walk_dogs
    change_moods(self.dogs, "happy")
  end

  def feed_cats
    change_moods(self.cats, "happy")
  end

  def sell_pets
    change_moods(self.dogs, "nervous")
    change_moods(self.cats, "nervous")

    change_owners(self.dogs, nil)
    change_owners(self.cats, nil)
  end

  def self.all
    @@all
  end

  def self.count
    self.all.count
    # binding.pry
  end

  def self.reset_all
    self.all.clear
  end

  def list_pets
    "I have #{self.dogs.count} dog(s), and #{self.cats.count} cat(s)."
  end

  private

  def pet_select_by_owner(species)
    species.all.select {|animal| animal.owner == self}
  end

  def buy_animal(animal, name, owner)
    animal.new(name, owner)
  end

  # method used to test issue w/ abstraction "change attributes"
  # problem = don't have access to 

  # def change_mood(animals, new_mood)
  #   animals.each {|animal| animal.mood = new_mood}
  # end

  def change_moods(animals, new_mood)
    animals.each {|animal| animal.mood = new_mood}
  end

  def change_owners(animals, new_owner)
    animals.each {|animal| animal.owner = new_owner}
  end

end