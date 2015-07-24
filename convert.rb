require 'json'
require 'mustache'
require 'securerandom'

unless ARGV.length == 2
  puts 'Usage: convert.rb "Readdle Pre-Interview 1" "2015-07-24-Readdle-Pre-interview-1.json"'
  exit(1)
end

#####################
# Config
#####################
ClipIn = 86313
Fps = 24
BlackVideoSnippet = File.read('black-video.xml')
ClipItemTemplate = File.read('clip-item.xml.mustache')
SequenceLayoutTemplate = File.read('sequence-layout.xml.mustache')
RatingToColorMap = {
  0 => 'Iris',
  1 => 'Violet',
  2 => 'Forest',
  3 => 'Mango'
}

SequenceName = ARGV[0]
JsonPath = ARGV[1]

#####################
# Functions
#####################
def add_end_dates_to_ratings(ratings)
  ratings.map.with_index do |rating, i|
    end_date = if next_point = ratings[i+1]
                  next_point['date']
                else
                  rating['date'] + 100
                end
    rating.merge({ 'endDate' => end_date })
  end
end

def black_video_snippet_or_reference
  @black_video_snippet_called ||= false

  return '<file id="file-4"/>' if @black_video_snippet_called
  @black_video_snippet_called = true
  BlackVideoSnippet
end

def data_point_to_hash(start_time, data_point)
  @clip_item_id ||= 0
  {
    name: data_point['rating'],
    clip_item_id: @clip_item_id += 1,
    clip_start: clip_start = time_span_to_frame_count(start_time, data_point['date'], Fps),
    clip_end: clip_end = time_span_to_frame_count(start_time, data_point['endDate'], Fps),
    clip_in: ClipIn,
    clip_out: ClipIn + (clip_end - clip_start),
    file: black_video_snippet_or_reference,
    clip_color: RatingToColorMap[data_point['rating']]
  }
end

def time_span_to_frame_count(start_time, end_time, fps)
  (end_time - start_time) * fps
end

#####################
# Implementation
#####################
data = JSON.parse(File.read(JsonPath))

data_points = add_end_dates_to_ratings(data['ratings'])

data_point_hashes = data_points.map { |data_point| data_point_to_hash(data['startDate'], data_point) }

clip_item_snippets = data_point_hashes.map { |data_point_hash| Mustache.render(ClipItemTemplate, data_point_hash) }

puts Mustache.render(SequenceLayoutTemplate, {
  sequence_id: SecureRandom.uuid,
  duration: data_point_hashes.last['clip_out'],
  sequence_name: @sequence_name,
  clip_items: clip_item_snippets.join("\n")
})
