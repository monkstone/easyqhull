KLASSES = %w[Delauny EasyQHull Hull Voronoi PointInterface VoronoiFactory].freeze

if RUBY_PLATFORM == 'java'
  require_relative 'easyqhull.jar'
  def import_class_list(list, string)
    list.each { |klass| java_import format(string, klass) }
  end
  easy_format = 'easy.%s'
  import_class_list(KLASSES, easy_format)
end
