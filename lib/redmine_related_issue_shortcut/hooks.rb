module RedmineRelatedIssueShortcut
  class Hooks < Redmine::Hook::ViewListener
    # adds our css on each page
    def view_layouts_base_html_head(context)
      # stylesheet_link_tag("related_issue_shortcut", :plugin => "redmine_related_issue_shortcut") +
      #  javascript_include_tag('redmine_related_issue_shortcut.js', plugin: 'redmine_related_issue_shortcut')
    end
  end

  class ModelHook < Redmine::Hook::Listener
    def after_plugins_loaded(_context = {})

    end
  end
end
