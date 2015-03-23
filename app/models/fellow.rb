class Fellow < User
    def full_name
        "#{first_name} #{last_name}"
    end
    def self.avail_fellows
      @avail_fellows = Fellow.select { |fellow| fellow.cohorts.length == 0 }
    end
end
