require_dependency 'issues_controller'

module RedmineRelatedIssueShortcut::IssuesControllerPatch

end

class IssuesController < ApplicationController
  after_action :creation_relation, :only => [:create]
  append_before_action :update_project_if_related_to_other_issue, :only => [:new, :create]

  def creation_relation
    if @issue.persisted? && params[:issue][:related_issue] && params[:issue][:related_issue].to_i.to_s == params[:issue][:related_issue]
      @relation = IssueRelation.new
      @relation.issue_from = Issue.find(params[:issue][:related_issue])
      @relation.issue_to = @issue
      @relation.relation_type = params[:issue][:relation_type]
      @relation.init_journals(User.current)
      @relation.save
    end
  end

  def update_project_if_related_to_other_issue
    related_to = params[:related_to] if params[:related_to].present?
    # Case  of fail validation

    if request.referer.present? && request.referer.include?("related_to")
      related_to = request.referer.partition('related_to=')[2]
      @related_to = related_to # pass id to view
    end

    if related_to.present?
      related_issue = Issue.where(id: related_to).first
      if related_issue.present?
        @issue.project = related_issue.project unless params[:project_id].present?
      end
    end
  end

end
