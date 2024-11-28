Deface::Override.new :virtual_path => 'issues/_action_menu',
                     :name => 'add-link-issue-button-to-issue-actions',
                     :insert_before => 'erb[loud]:contains("link_to l(:button_edit)")',
                     :partial => 'issues/link_to_new_related_issue'
