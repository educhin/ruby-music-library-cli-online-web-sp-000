module Concerns::Findable
  # module ClassMethods
    #create
    def create(name)
      instance = self.new(name)
      instance.save
      instance
    end

    #destroy_all
    def destroy_all
      self.all.clear
    end

    def find_by_name(name)
      self.all.detect {|a| a.name == name}
    end

    def find_or_create_by_name(name)
      song = self.find_by_name(name)
      if song == nil
        self.create(name)
      else
        song
      end
    end
  # end
  #
  module InstanceMethods
    #save
    def save
      self.class.all << self
    end
  end
end
