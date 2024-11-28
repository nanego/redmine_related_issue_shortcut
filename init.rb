require 'redmine'
require_relative 'lib/redmine_related_issue_shortcut/hooks'

Redmine::Plugin.register :redmine_related_issue_shortcut do
  name 'Redmine Related Issue Shortcut plugin'
  author 'Vincent ROBERT'
  description 'This is a Redmine plugin which allow to quickly create a new issue related to another'
  version '1.0.0'
  url 'https://github.com/nanego/redmine_related_issue_shortcut'
  author_url 'https://github.com/nanego'
  requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.4' if Rails.env.test?
  requires_redmine_plugin :redmine_base_deface, :version_or_higher => '0.0.1'

  settings partial: 'settings/redmine_plugin_related_issue_shortcut_settings',
           default: {
             'create_related_issue_shortcut': '',
             'create_related_issue_shortcut_project_id': ''
           }
end
