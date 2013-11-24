module RoutesHelper
  def route_title_for_performant(route, performance_id)
    performance = route.route_performances.where(:id => performance_id).first
    "#{route.name}-#{performance.user.username}-#{performance.created_at.to_s}.gpx"
  end
end
