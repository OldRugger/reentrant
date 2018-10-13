APP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/config.yml")).result)[Rails.env]
APP_CONFIG.symbolize_keys!
BUILD = `git rev-parse --short HEAD`
APP_VERSION = '2.0.0'
COURSES = ['Green', 'Brown', 'Orange', 'Yellow', 'Sprint'].freeze
FINAL_SPLIT = 999
CLUB_ABBREVIATIONS = YAML.load(ERB.new(File.read("#{Rails.root}/config/club_abbreviations.yml")).result)['club_abbreviations']
HIGH_SCHOOL_LIST = Set.new
CLUB_ABBREVIATIONS.each { |k,v| HIGH_SCHOOL_LIST << v }
