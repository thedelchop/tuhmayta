class RootConstraints
  def self.matches?(request)
    if request.env['warden'].authenticated?(:user)
      return true
    else
      return false
    end
  end
end
