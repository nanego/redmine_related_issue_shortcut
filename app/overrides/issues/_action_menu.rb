Deface::Override.new :virtual_path => 'issues/_action_menu',
                     :name => 'add-link-issue-button-to-issue-actions',
                     :insert_before => 'erb[loud]:contains("link_to l(:button_edit)")',
                     :text => <<~RELATEDISSUE
                       <% if Setting["plugin_redmine_related_issue_shortcut"]["create_related_issue_shortcut"].present? %>
                           <%= link_to l(:label_create_related_issue_shortcut),
                               new_project_issue_path(project_id: Setting["plugin_redmine_related_issue_shortcut"]["create_related_issue_shortcut_project_id"] || @project.id,
                                                      'issue[description]' =>  @issue.description,
                                                      related_to: @issue,),
                               class: "icon icon-link-break" %>
                       <% end %>
                     RELATEDISSUE
