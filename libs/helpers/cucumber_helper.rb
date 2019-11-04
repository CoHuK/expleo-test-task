AllureCucumber::Formatter.class_eval do
  def after_features(features)
    AllureRubyAdaptorApi::Builder.build!
    env_info = CommonHelper.get_environment_information
    AllureHelper.generate_environment_information(env_info)
  end
end
