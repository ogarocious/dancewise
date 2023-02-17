# frozen_string_literal: true

acts_as_votable

require "json"
require "i18n"
require "date"

class Event < ApplicationRecord
  belongs_to :user, optional: true
  has_many :event_dance_styles
  has_many :dance_styles, through: :event_dance_styles
  has_many :event_artists
  has_many :artists, through: :event_artists
  has_many :event_event_types, dependent: :nullify
  has_many :event_types, through: :event_event_types
  has_one_attached :event_image
  has_rich_text :description
  belongs_to :event_frequency, optional: true, class_name: "EventFrequency", foreign_key: "event_frequency_id"
  validates :name, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :event_start_date, presence: true
  validates :event_end_date, presence: true
  validates :event_frequency, presence: true
  validates_uniqueness_of :slug, case_sensitive: false
  validates :address, presence: true, unless: :online_event
  
  geocoded_by :address 
  
  before_validation :set_address, if: :online_event?
  after_validation :geocode, :reverse_geocode, :save_additional_address_fields, unless: :online_event?
  after_validation :date_parsing, :nametoslug
  before_save :set_online_event


  extend FriendlyId
  friendly_id :slug, use: :slugged

  enum event_status: {
        active: 1,
        pending: 2,
      }

   scope :status_sorted, -> { order(event_status_id: :desc) }
   scope :active, -> { where(event_status_id: 1) }
   scope :pending, -> { where(event_status_id: 2) }
   scope :sorted, -> { order(name: :asc) }

    scope :past_events, -> { where('event_end_date < ?', Date.yesterday).order(event_end_date: :desc) }
    scope :upcoming_events, -> { where('event_start_date >= ?', Date.today).or(where('event_end_date > ?', Date.yesterday)).order(event_start_date: :asc) }
    
    scope :in_austin, -> { where(city: "Austin").or(where(city: "Pflugerville")).where(state: "Texas") }
    scope :in_boise, -> { where(city: "Boise").or(where(city: "Meridian")).or(where(city: "Nampa")).or(where(city: "Kuna")).where(state:"Idaho") }
    scope :in_bogota, -> { where(city: "Bogota") }
    scope :in_cinci, -> { where(city: "Cincinnati").or(where(city: "Dayton")).or(where(city: "Erlanger")).or(where(city: "Kentucky")).or(where(city: "Loveland")).or(where(city: "Maineville")).or(where(city: "Mason")).where(state:"Ohio") } 
    scope :in_chicago, -> { where(city: "Chicago").or(where(city: "Schaumburg")).or(where(city: "Rosemont")).or(where(city: "Algonquin")).or(where(city: "Wheeling")).where(state:"Illinois") }
    scope :in_cleveland, -> { where(city: "Cleveland").where(state: "Ohio") }
    scope :in_denver, -> { where(city: "Denver").or(where(city: "Westminster")).or(where(city: "Lakewood")).or(where(city: "Aurora")).where(state: "Colorado") }
    scope :in_dfw, -> { where(city: "Dallas").or(where(city: "Fort Worth")).or(where(city: "Mesquite")).or(where(city: "Frisco")).or(where(city: "Mckinney")).or(where(city: "Richardson")).or(where(city: "Plano")).or(where(city: "Arlington")).or(where(city: "Hurst")).or(where(city: "Burleson")).or(where(city: "Euless")).or(where(city: "Duncanville")).or(where(city: "Desoto")).or(where(city: "Desoto")).or(where(city: "Irving")).or(where(city: "Carrolton")).or(where(city: "Farmers Branch")).or(where(city: "Grand Prarie")).or(where(city: "Cedar Hill")).or(where(city: "Rowlett")).or(where(city: "Allen")).or(where(city: "Flower Mound")).or(where(city: "Southlake")).or(where(city: "Keller")).where(state: "Texas") }
    scope :in_halifax, -> { where(city: "Halifax").where(country: "Canada") }
    scope :in_htx, -> { where(city: "Houston").or(where(city: "Bellaire")).or(where(city: "Sugar Land")).or(where(city: "Pasadena")).or(where(city: "Pearland")).or(where(city: "Katy")).or(where(city: "Spring")).or(where(city: "Jersey Village")).or(where(city: "Stafford")).or(where(city: "The Woodlands")).where(state:"Texas") }
    scope :in_indy, -> { where(city: "Indianapolis").where(state: "Indiana") }
    scope :in_kelowna, -> { where(city: "Kelowna").where(country: "Canada") }
    scope :in_lagos, -> { where(city: "Lagos").where(country: "Nigeria") }
    scope :in_louisville, -> { where(city: "Louisville").where(state: "Kentucky") }
    scope :in_okc, -> { where(city: "Oklahoma City").or(where(city: "Moore")).where(state: "Oklahoma") }
    scope :in_medellin, -> { where(city: "Medellin") }
    scope :in_mtl, -> { where(city: "Montreal").where(country: "Canada") }
    scope :in_phoenix, -> { where(city: "Phoenix").or(where(city: "Mesa")).or(where(city: "Tempe")).or(where(city: "Scottsdale")).where(state: "Arizona") }
    scope :in_qqc, -> { where(city: "Quebec City").where(country: "Canada") }
    scope :in_saska, -> { where(city: "Saskatoon")..where(country: "Canada") }
    scope :in_seattle, -> { where(city: "Seattle").or(where(city: "Bellevue")).or(where(city: "Redmond")).or(where(city: "Tacoma")).or(where(city: "Bellingham")).or(where(city: "Olympia")).or(where(city: "Port Townsend")).where(state: "Washington") }
    scope :in_stl, -> { where(city: "St. Louis").where(state: "Missouri") } 
    scope :in_thebay, -> { where(city: "San Francisco").or(where(city: "Oakland")).or(where(city: "Berkeley")).or(where(city: "San Jose")).or(where(city: "Sunnyvale")).or(where(city: "Redwood City")).or(where(city: "Napa")).or(where(city: "Daly City")).or(where(city: "Richmond")).or(where(city: "San Rafael")).or(where(city: "San Mateo")).or(where(city: "Santa Clara")).where(state: "California") }
    scope :in_toronto, -> { where(city: "Toronto").where(country: "Canada") }
    scope :in_vancouver, -> { where(city: "Vancouver").where(country: "Canada") }
    scope :in_victoria, -> { where(city: "Victoria").where(country: "Canada") }
    scope :in_wpg, -> { where(city: "Winnipeg").where(country: "Canada") }
    scope :in_yeg, -> { where(city: "Edmonton").where(country: "Canada") }
    scope :in_yyc, -> { where(city: "Calgary").where(country: "Canada") }
    scope :in_ottawa, -> { where(city: "Ottawa").or(where(city: "Gatineau")).where(country: "Canada") }

  def date_parsing
    event_date = self.event_start_date
    self.event_month = event_date.strftime("%B")
    self.event_year = event_date.strftime("%Y")
  end

  def save_additional_address_fields
    search_results = Geocoder.search(address)
    # search_results = Geocoder.search(to_coordinates)
    result = search_results.select { |x| (x.types == "city") && (x.data["class"] == "place")  }.first || search_results.first

    # JSON hash country code lookup to find continent
    file = File.read(File.join(Rails.root, "app", "assets", "json", "continents.json"))
    continent_string = JSON.parse(file)
    country_code = result.country_code.upcase
    continent = continent_string[country_code]

    self.city =  I18n.transliterate(result.city) rescue "unknown"
    self.state =  I18n.transliterate(result.state) rescue "unknown"
    self.country =  I18n.transliterate(result.country) rescue "unknown"
    self.continent =  I18n.transliterate(continent) rescue "unknown"
  end

  def nametoslug
    eventslug = self.slug
    self.slug = eventslug.parameterize
  end

  def online_event?
    online_event
  end

  private

  def set_address
    self.address = "Online"
  end

  def set_online_event
    if self.online_event && !self.event_types.include?(EventType.find_by(name: 'Online Event'))
      self.event_types << EventType.find_by(name: 'Online Event')
    end
  end
end
