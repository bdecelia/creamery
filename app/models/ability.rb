class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all     #can do everything
    
    elsif user.role? :manager
      #can read any information on stores, jobs, flavors.
      can :read, [Store, Job, Flavor]

      #can read employee information for employees at the same store
      can :read, Employee do |e|
        unless user.employee.current_assignment.nil? or e.current_assignment.nil?
          e.current_assignment.store.id == user.employee.current_assignment.store.id
      end

      #can read assignment information for employees at the same store
      can :read, Assignment do |a|
        unless user.employee.current_assignment.nil? and not a.end_date.nil?
          a.store.id == user.employee.current_assignment.store.id
        end
      end

      #can read shift information for employees at the same store
      can :read, Shift do |s|
        unless user.employee.current_assignment.nil?
          s.assignment.store.id == user.employee.current_assignment.store.id
        end
      end

      #can create shifts for the same store the manager is currently assigned to.
      can :create, Shift do |s|
        unless user.employee.current_assignment.nil?
          s.assignment.store.id == user.employee.current_assignment.store.id
        end
      end

      #can update or destroy shifts for the same store the manager is currently assigned to.
      can [:update, :destroy] Shift do |s|
        unless user.employee.current_assignment.nil?
          s.assignment.store.id == user.employee.current_assignment.store.id
        end
      end

      #can create or destroy shift-jobs for the same store the manager is currently assigned to.
      can [:create, :destroy] ShiftJob do |sj|
        unless user.employee.current_assignment.nil?
          sj.assignment.store.id == user.employee.current_assignment.store.id
        end
      end

      #can create or destroy store-flavors for the same store the manager is currently assigned to.
      can [:create, :destroy] StoreFlavor do |sf|
        unless user.employee.current_assignment.nil?
          sf.assignment.store.id == user.employee.current_assignment.store.id
        end
      end
  
    elsif user.role? :employee
      #can read any information on stores, jobs, flavors.
      can :read, [Store, Job, Flavor]

      #can read or update their own employee info
      can [:read, :update] Employee do |e|
        e.id == user.employee.id
      end

      #can read their own assignment info
      can :read, Assignment do |a|
        a.employee.id == user.employee.id
      end

      #can read their own shift info
      can :read, Shift do |s|
        s.assignment.employee.id == user.employee.id
      end

      #can read their own shift-job info
      can :read, ShiftJob do |sj|
        sj.shift.assignment.employee.id == user.employee.id
      end

      #can read or update their own user data (besides SSN-- fixed elsewhere)
      can [:read, :update] User do |u|
        u.id == user.id
      end

    else
      #guests can only read active store information
      can :read, Store do |s|
        return s.active
    end  
  end
end