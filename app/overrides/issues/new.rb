Deface::Override.new :virtual_path  => "issues/new",
                     :name          => "add-related-issue-if-any",
                     :insert_before => "div.box.tabular",
                     :partial       => "issues/related_issue"
