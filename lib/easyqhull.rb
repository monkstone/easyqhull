KLASSES = %w[
  Delaunay EasyQhull Hull VoronoiImpl PointInterface VoronoiFactory
].freeze

if RUBY_PLATFORM == 'java'
  require_relative 'easyqhull.jar'
  def import_class_list(list, string)
    list.each { |klass| java_import format(string, klass) }
  end
  easy_format = 'easy.%s'
  import_class_list(KLASSES, easy_format)
end

require_relative 'easyqhull/point'
