my_date_formats = { :default => '%m/%d/%Y' }
Time::DATE_FORMATS.merge!(my_date_formats)
Date::DATE_FORMATS.merge!(my_date_formats)

ENV[""]

MORNING_START = 5
NOON_START = 12
NIGHT_START = 18


SESSION_TIMEOUT = 30.minutes
