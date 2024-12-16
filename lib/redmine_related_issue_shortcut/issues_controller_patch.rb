require_dependency 'issues_controller'

module RedmineRelatedIssueShortcut::IssuesControllerPatch

end

class IssuesController < ApplicationController
  after_action :creation_relation, :only => [:create]
  append_before_action :update_project_if_related_to_other_issue, :only => [:new, :create]

  def creation_relation
    if @issue.persisted? && params[:issue][:related_issue] && params[:issue][:related_issue].to_i.to_s == params[:issue][:related_issue]
      @relation = IssueRelation.new
      @related_issue = Issue.find(params[:issue][:related_issue])
      @relation.issue_from = @related_issue
      @relation.issue_to = @issue
      @relation.relation_type = params[:issue][:relation_type]
      @relation.init_journals(User.current)
      @relation.save

      # Update initial issue status
      if Setting["plugin_redmine_related_issue_shortcut"]["create_related_issue_shortcut_closed_status_id"].present?
        closed_status = IssueStatus.find_by_id(Setting["plugin_redmine_related_issue_shortcut"]["create_related_issue_shortcut_closed_status_id"])
        if @related_issue.status != closed_status
          @related_issue.status = closed_status
          @related_issue.save
        end
      end
    end
  end

  def update_project_if_related_to_other_issue
    related_to = params[:related_to] if params[:related_to].present?
    # Case of fail validation

    if request.referer.present? && request.referer.include?("related_to")
      related_to = request.referer.partition('related_to=')[2]
      @related_to = related_to # pass id to view
    end

    if related_to.present?
      related_issue = Issue.where(id: related_to).first
      if related_issue.present?
        @issue.project = related_issue.project unless params[:project_id].present?

        @unregistered_watchers = []
        @unregistered_watchers << UnregisteredWatcher.new(email: params[:issue][:unregistered_watchers].strip) if params[:issue] && params[:issue][:unregistered_watchers].present?
        @issue.unregistered_watchers = @unregistered_watchers
      end
    end
  end

end
