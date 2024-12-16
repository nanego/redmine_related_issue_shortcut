Deface::Override.new :virtual_path  => "issues/new",
                     :name          => "add-related-issue-if-any",
                     :insert_before => "div.box.tabular",
                     :partial       => "issues/related_issue"

Deface::Override.new :virtual_path  => "issues/new",
                     :name          => "remove_create_and_continue_button",
                     :remove        => "erb[loud]:contains(\"submit_tag l(:button_create_and_continue)\")"
