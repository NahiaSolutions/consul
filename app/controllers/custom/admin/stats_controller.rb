class Admin::StatsController < Admin::BaseController

  def show
    @event_types = Ahoy::Event.group(:name).count

    @visits = Visit.count
    @debates = Debate.with_hidden.count
    @proposals = Proposal.with_hidden.count
    @comments = Comment.not_valuations.with_hidden.count

    @debate_votes = Vote.where(votable_type: 'Debate').count
    @proposal_votes = Vote.where(votable_type: 'Proposal').count
    @comment_votes = Vote.where(votable_type: 'Comment').count
    @votes = Vote.count

    @user_level_two = User.active.level_two_verified.count
    @user_level_three = User.active.level_three_verified.count
    @verified_users = User.active.level_two_or_three_verified.count
    @unverified_users = User.active.unverified.count
    @users = User.active.count
    @user_ids_who_voted_proposals = ActsAsVotable::Vote.where(votable_type: 'Proposal').distinct.count(:voter_id)
    @user_ids_who_didnt_vote_proposals = @verified_users - @user_ids_who_voted_proposals
    @spending_proposals = SpendingProposal.count
    budgets_ids = Budget.where.not(phase: 'finished').pluck(:id)
    @budgets = budgets_ids.size
    @investments = Budget::Investment.where(budget_id: budgets_ids).count

    #Datos Casa Somos
    @zonal_administrations = ZonalAdministration.count
    @houses = House.count
    @workshops = Workshop.count
    @workshop_users = WorkshopUser.count
    @workshop_users_different = WorkshopUser.distinct.count(:id_user)
    @workshop_users_ins = WorkshopUser.where(status: 1).count
    @workshop_users_wait = WorkshopUser.where(status: 0).count
    #Datos Voluntariado
    @categories = VoluntCategory.count
    @programs = VoluntProgram.count
    @volunt_users = VoluntUser.count
    @volunt_users_different = VoluntUser.distinct.count(:id_user)
  end

  def proposal_notifications
    @proposal_notifications = ProposalNotification.all
    @proposals_with_notifications = @proposal_notifications.select(:proposal_id).distinct.count
  end

  def direct_messages
    @direct_messages = DirectMessage.count
    @users_who_have_sent_message = DirectMessage.select(:sender_id).distinct.count
  end

  def polls
    @polls = ::Poll.current
    @participants = ::Poll::Voter.where(poll: @polls)
  end

  def houses
    @houses = House.all
    @workshops = Workshop.all
    @ageRanges = HousesAgeRange.all
    @workshop_users = WorkshopUser.all
    #Imprimir en EXCEL
    respond_to do |format|
      format.html
      format.xlsx { set_attachment_name "Reporte Casa Somos #{Time.now.utc.strftime('%Y%M%d%H%M%S')}.xlsx" }
    end
  end

  def volunteerings
    @categories = VoluntCategory.all
    @programs = VoluntProgram.all
    #Imprimir en EXCEL
    respond_to do |format|
      format.html
      format.xlsx { set_attachment_name "Reporte Voluntariado #{Time.now.utc.strftime('%Y%M%d%H%M%S')}.xlsx" }
    end
  end

  def set_attachment_name(name)
    escaped = URI.encode(name)
    response.headers['Content-Disposition'] = "attachment; filename*=UTF-8''#{escaped}"
  end

end
