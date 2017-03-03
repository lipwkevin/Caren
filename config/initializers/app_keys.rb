my_date_formats = { :default => '%d/%m/%Y' }
Time::DATE_FORMATS.merge!(my_date_formats)
Date::DATE_FORMATS.merge!(my_date_formats)


MORNING_START = 6
NOON_START = 12
NIGHT_START = 20


SESSION_TIMEOUT = 30.minutes
