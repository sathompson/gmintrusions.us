module IntrusionsHelper
  def intrusion_details(intrusion)
    "#{intrusion.id} - #{intrusion.description}"
  end
end
