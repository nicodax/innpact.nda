# frozen_string_literal: true

require 'logger'

namespace :remove_duplicates_from_tables do # rubocop:disable Metrics/BlockLength
  desc 'Remove the duplicates from the archive_v_loans tables'
  task archive_v_loans: :environment do
    logger = Logger.new('./log/tasks.log')
    logger.info('Remove_duplicates_from_tables archive_v_loans task started.')
    result = execute_statement(delete_duplicated_archive_v_loans_table_entry_sql)
    if result.length.positive?
      logger.info("Found #{result.length} duplicated rows in archive_v_loans entries from #{result.uniq.length} loans.")
      duplicates_after_deletion = execute_statement(duplicated_archive_v_loans_table_entry_sql)
      if duplicates_after_deletion.length.positive?
        logger.info('The rows has not been deleted due to an issue in the transaction.')
      else
        logger.info('All the duplicated rows has been correctly deleted by the transaction.')
        result.uniq.each do |row|
          new_loan_attribute = {}
          row.each do |key, value|
            new_loan_attribute[key] = value
          end
          new_archive_loan = ArchiveVLoan.create(new_loan_attribute)
          return_from_saving_back_temp_loan = new_archive_loan.save
          if return_from_saving_back_temp_loan
            logger.info("Saved back the loan with loan_id:#{new_loan_attribute['loan_id']} successfuly to archive_v_loans after deletion.")
          else
            logger.error("Failed to save back the loan \n #{new_loan_attribute.to_json} \n to archive_v_loans after deletion.")
          end
        end
      end
    else
      logger.info('Found no duplicated rows in archive_v_loans entries.')
    end
  end

  def delete_duplicated_archive_v_loans_table_entry_sql # rubocop:disable Metrics/MethodLength
    %(
      BEGIN TRANSACTION
        DECLARE @ArchiveVLoansDuplicates TABLE(
          count_id int,
          id bigint,
          loan_id bigint NULL,
          version_number int NULL,
          status nvarchar(4000) NULL,
          version_status nvarchar(4000) NULL,
          currency_id bigint NULL,
          loan_type_id bigint NULL,
          repayment_type_id bigint NULL,
          creation_user_id bigint NULL,
          assignment_date date NULL,
          deadline_assignment_date date NULL,
          ratification_date date NULL,
          deadline_ratification_date date NULL,
          approval_date date NULL,
          deadline_approval_date date NULL,
          expected_disbursement_date date NULL,
          specific_approval_condition nvarchar(4000) NULL,
          probabilities float NULL,
          disbursement_date date NULL,
          in_waiting_list bit NULL,
          maturity_date date NULL,
          nav_usd float NULL,
          net_position_value decimal(17, 2) NULL,
          gross_position_value decimal(17, 2) NULL,
          critical_cases nvarchar(4000) NULL,
          provision_date date NULL,
          provision_value decimal(17, 2) NULL,
          vrr nvarchar(4000) NULL,
          vrr_maturity_date date NULL,
          proposed_nominal_amount decimal(17, 2) NULL,
          proposed_tenor int NULL,
          proposed_spread float NULL,
          proposed_upfront_fees float NULL,
          proposed_fixed_rate float NULL,
          ratified_nominal_amount decimal(17, 2) NULL,
          ratified_tenor int NULL,
          ratified_spread float NULL,
          ratified_upfront_fees float NULL,
          ratified_fixed_rate float NULL,
          approved_nominal_amount decimal(17, 2) NULL,
          approved_tenor int NULL,
          approved_spread float NULL,
          approved_upfront_fees float NULL,
          approved_fixed_rate float NULL,
          executed_nominal_amount decimal(17, 2) NULL,
          executed_tenor int NULL,
          executed_spread float NULL,
          executed_upfront_fees float NULL,
          executed_fixed_rate float NULL,
          pending_ratification_nominal_amount decimal(17, 2) NULL,
          pending_ratification_tenor int NULL,
          pending_ratification_spread float NULL,
          pending_ratification_upfront_fees float NULL,
          pending_ratification_fixed_rate float NULL,
          pending_ratification_date date NULL,
          deadline_pending_ratification_date date NULL,
          pending_approval_nominal_amount decimal(17, 2) NULL,
          pending_approval_tenor int NULL,
          pending_approval_spread float NULL,
          pending_approval_upfront_fees float NULL,
          pending_approval_fixed_rate float NULL,
          pending_approval_date date NULL,
          deadline_pending_approval_date date NULL,
          approved_change_request_nominal_amount decimal(17, 2) NULL,
          approved_change_request_tenor int NULL,
          approved_change_request_spread float NULL,
          approved_change_request_upfront_fees float NULL,
          approved_change_request_fixed_rate float NULL,
          approval_change_request_date date NULL,
          deadline_approval_change_request_date date NULL,
          validation_user_id bigint NULL,
          rejection_user_id bigint NULL,
          created_at datetime2(6) NULL,
          updated_at datetime2(6) NULL,
          deleted_at date NULL,
          bond_id bigint NULL,
          pool_id bigint NULL,
          interest_rate_type_id bigint NULL,
          hedge_comment nvarchar(100) NULL,
          pending_ratification_comment nvarchar(max) NULL,
          ratified_comment nvarchar(max) NULL,
          not_ratified_comment nvarchar(max) NULL,
          assignement_expired_comment nvarchar(max) NULL,
          released_before_approval_comment nvarchar(max) NULL,
          pending_approval_comment nvarchar(max) NULL,
          approved_comment nvarchar(max) NULL,
          not_approved_comment nvarchar(max) NULL,
          approval_expired_comment nvarchar(max) NULL,
          approved_change_request_comment nvarchar(max) NULL,
          invested_comment nvarchar(max) NULL,
          released_after_approval_comment nvarchar(max) NULL,
          not_validated_comment nvarchar(max) NULL,
          nav_date date NULL,
          innpact_loan_id int NOT NULL,
          institution_mode_at_creation nvarchar(4000) NOT NULL,
          last_loan_version int NOT NULL,
          noval int NULL,
          restructuring bit NOT NULL,
          tranche_original_loan_id bigint NULL,
          proposed_nominal_amount_USD decimal(38, 17) NULL,
          ratified_nominal_amount_USD decimal(38, 17) NULL,
          approved_nominal_amount_USD decimal(38, 17) NULL,
          executed_nominal_amount_USD decimal(38, 17) NULL,
          pending_ratification_nominal_amount_USD decimal(38, 17) NULL,
          pending_approval_nominal_amount_USD decimal(38, 17) NULL,
          approved_change_request_nominal_amount_USD decimal(38, 17) NULL,
          Institutions nvarchar(4000) NULL,
          Institution_group nvarchar(4000) NULL,
          in_watchlist bit NULL,
          institution_type nvarchar(4000) NULL,
          fund_name nvarchar(4000) NULL,
          fund_status int NULL,
          loan_type_description nvarchar(4000) NULL,
          loan_type nvarchar(4000) NULL,
          Country nvarchar(4000) NULL,
          rating_MOODYS nvarchar(4000) NULL,
          rating_MIMOSA int NULL,
          Region nvarchar(4000) NULL,
          Local_Currency nvarchar(4000) NULL,
          Local_Currency_Rate decimal(17, 6) NULL,
          repayment_type nvarchar(4000) NULL,
          bond nvarchar(4000) NULL,
          bond_description nvarchar(4000) NULL,
          interest_rate_type nvarchar(4000) NULL,
          interest_rate_type_description nvarchar(4000) NULL,
          pool nvarchar(4000) NULL,
          IM_Group nvarchar(4000) NULL,
          data_viewed_at date NULL,
          SysStartTime datetime NULL,
          SysEndTime datetime NULL,
          executed_bond_id bigint NULL,
          executed_interest_rate_type_id bigint NULL,
          approved_bond_id bigint NULL,
          approved_interest_rate_type_id bigint NULL,
          number_of_disbursement_date_updates int NULL,
          invested_hedge_fx_rate decimal(18, 9) NULL,
          loan_version_id bigint NULL,
          hedge_spread float NULL,
          hedge_interest_rate_type_id bigint NULL
        )

        DECLARE @ArchiveVLoansDeletedRow TABLE(
          id int,
          loan_id bigint NULL,
          version_number int NULL,
          status nvarchar(4000) NULL,
          version_status nvarchar(4000) NULL,
          currency_id bigint NULL,
          loan_type_id bigint NULL,
          repayment_type_id bigint NULL,
          creation_user_id bigint NULL,
          assignment_date date NULL,
          deadline_assignment_date date NULL,
          ratification_date date NULL,
          deadline_ratification_date date NULL,
          approval_date date NULL,
          deadline_approval_date date NULL,
          expected_disbursement_date date NULL,
          specific_approval_condition nvarchar(4000) NULL,
          probabilities float NULL,
          disbursement_date date NULL,
          in_waiting_list bit NULL,
          maturity_date date NULL,
          nav_usd float NULL,
          net_position_value decimal(17, 2) NULL,
          gross_position_value decimal(17, 2) NULL,
          critical_cases nvarchar(4000) NULL,
          provision_date date NULL,
          provision_value decimal(17, 2) NULL,
          vrr nvarchar(4000) NULL,
          vrr_maturity_date date NULL,
          proposed_nominal_amount decimal(17, 2) NULL,
          proposed_tenor int NULL,
          proposed_spread float NULL,
          proposed_upfront_fees float NULL,
          proposed_fixed_rate float NULL,
          ratified_nominal_amount decimal(17, 2) NULL,
          ratified_tenor int NULL,
          ratified_spread float NULL,
          ratified_upfront_fees float NULL,
          ratified_fixed_rate float NULL,
          approved_nominal_amount decimal(17, 2) NULL,
          approved_tenor int NULL,
          approved_spread float NULL,
          approved_upfront_fees float NULL,
          approved_fixed_rate float NULL,
          executed_nominal_amount decimal(17, 2) NULL,
          executed_tenor int NULL,
          executed_spread float NULL,
          executed_upfront_fees float NULL,
          executed_fixed_rate float NULL,
          pending_ratification_nominal_amount decimal(17, 2) NULL,
          pending_ratification_tenor int NULL,
          pending_ratification_spread float NULL,
          pending_ratification_upfront_fees float NULL,
          pending_ratification_fixed_rate float NULL,
          pending_ratification_date date NULL,
          deadline_pending_ratification_date date NULL,
          pending_approval_nominal_amount decimal(17, 2) NULL,
          pending_approval_tenor int NULL,
          pending_approval_spread float NULL,
          pending_approval_upfront_fees float NULL,
          pending_approval_fixed_rate float NULL,
          pending_approval_date date NULL,
          deadline_pending_approval_date date NULL,
          approved_change_request_nominal_amount decimal(17, 2) NULL,
          approved_change_request_tenor int NULL,
          approved_change_request_spread float NULL,
          approved_change_request_upfront_fees float NULL,
          approved_change_request_fixed_rate float NULL,
          approval_change_request_date date NULL,
          deadline_approval_change_request_date date NULL,
          validation_user_id bigint NULL,
          rejection_user_id bigint NULL,
          created_at datetime2(6) NULL,
          updated_at datetime2(6) NULL,
          deleted_at date NULL,
          bond_id bigint NULL,
          pool_id bigint NULL,
          interest_rate_type_id bigint NULL,
          hedge_comment nvarchar(100) NULL,
          pending_ratification_comment nvarchar(max) NULL,
          ratified_comment nvarchar(max) NULL,
          not_ratified_comment nvarchar(max) NULL,
          assignement_expired_comment nvarchar(max) NULL,
          released_before_approval_comment nvarchar(max) NULL,
          pending_approval_comment nvarchar(max) NULL,
          approved_comment nvarchar(max) NULL,
          not_approved_comment nvarchar(max) NULL,
          approval_expired_comment nvarchar(max) NULL,
          approved_change_request_comment nvarchar(max) NULL,
          invested_comment nvarchar(max) NULL,
          released_after_approval_comment nvarchar(max) NULL,
          not_validated_comment nvarchar(max) NULL,
          nav_date date NULL,
          innpact_loan_id int NOT NULL,
          institution_mode_at_creation nvarchar(4000) NOT NULL,
          last_loan_version int NOT NULL,
          noval int NULL,
          restructuring bit NOT NULL,
          tranche_original_loan_id bigint NULL,
          proposed_nominal_amount_USD decimal(38, 17) NULL,
          ratified_nominal_amount_USD decimal(38, 17) NULL,
          approved_nominal_amount_USD decimal(38, 17) NULL,
          executed_nominal_amount_USD decimal(38, 17) NULL,
          pending_ratification_nominal_amount_USD decimal(38, 17) NULL,
          pending_approval_nominal_amount_USD decimal(38, 17) NULL,
          approved_change_request_nominal_amount_USD decimal(38, 17) NULL,
          Institutions nvarchar(4000) NULL,
          Institution_group nvarchar(4000) NULL,
          in_watchlist bit NULL,
          institution_type nvarchar(4000) NULL,
          fund_name nvarchar(4000) NULL,
          fund_status int NULL,
          loan_type_description nvarchar(4000) NULL,
          loan_type nvarchar(4000) NULL,
          Country nvarchar(4000) NULL,
          rating_MOODYS nvarchar(4000) NULL,
          rating_MIMOSA int NULL,
          Region nvarchar(4000) NULL,
          Local_Currency nvarchar(4000) NULL,
          Local_Currency_Rate decimal(17, 6) NULL,
          repayment_type nvarchar(4000) NULL,
          bond nvarchar(4000) NULL,
          bond_description nvarchar(4000) NULL,
          interest_rate_type nvarchar(4000) NULL,
          interest_rate_type_description nvarchar(4000) NULL,
          pool nvarchar(4000) NULL,
          IM_Group nvarchar(4000) NULL,
          data_viewed_at date NULL,
          SysStartTime datetime NULL,
          SysEndTime datetime NULL,
          executed_bond_id bigint NULL,
          executed_interest_rate_type_id bigint NULL,
          approved_bond_id bigint NULL,
          approved_interest_rate_type_id bigint NULL,
          number_of_disbursement_date_updates int NULL,
          invested_hedge_fx_rate decimal(18, 9) NULL,
          loan_version_id bigint NULL,
          hedge_spread float NULL,
          hedge_interest_rate_type_id bigint NULL
        )

        DECLARE @NumberOfDuplicatedRowToDelete int

        DECLARE @NumberOfDuplicatedRow int

        DECLARE @NumberOfArchiveVLoansRowBeforeDeletion int

        DECLARE @NumberOfArchiveVLoansRowAfterDeletion int

        DECLARE @DuplicateCursor CURSOR

        DECLARE @temp_loan_id varchar(50)
        DECLARE @temp_version_number varchar(50)
        DECLARE @temp_data_viewed_at varchar(50)
        DECLARE @temp_created_at varchar(50)
        DECLARE @temp_updated_at varchar(50)
        DECLARE @temp_deleted_at varchar(50)

        INSERT INTO @ArchiveVLoansDuplicates
        #{duplicated_archive_v_loans_table_entry_sql}

        SELECT @NumberOfDuplicatedRowToDelete = SUM(count_id)
        FROM @ArchiveVLoansDuplicates;

        SELECT @NumberOfDuplicatedRow = COUNT(count_id)
        FROM @ArchiveVLoansDuplicates;

        SELECT @NumberOfArchiveVLoansRowBeforeDeletion = COUNT(loan_id)
        FROM archive_v_loans;

        IF @NumberOfDuplicatedRow > 0
          BEGIN
            SET @DuplicateCursor = CURSOR FOR
            SELECT loan_id, version_number, data_viewed_at, created_at, updated_at, deleted_at
            FROM   @ArchiveVLoansDuplicates

            OPEN @DuplicateCursor
            FETCH NEXT
            FROM @DuplicateCursor INTO @temp_loan_id, @temp_version_number, @temp_data_viewed_at, @temp_created_at, @temp_updated_at, @temp_deleted_at
            WHILE @@FETCH_STATUS = 0
              BEGIN
                INSERT INTO @ArchiveVLoansDeletedRow
                SELECT * FROM archive_v_loans WHERE
                loan_id = @temp_loan_id
                AND version_number = @temp_version_number
                AND data_viewed_at = @temp_data_viewed_at
                AND created_at = @temp_created_at
                AND updated_at = @temp_updated_at

                DECLARE @test_variable int
                SELECT @test_variable = COUNT(loan_id)
                FROM @ArchiveVLoansDeletedRow;

                DELETE FROM archive_v_loans WHERE
                loan_id = @temp_loan_id
                AND version_number = @temp_version_number
                AND data_viewed_at = @temp_data_viewed_at
                AND created_at = @temp_created_at
                AND updated_at = @temp_updated_at
                FETCH NEXT
                FROM @DuplicateCursor INTO @temp_loan_id, @temp_version_number, @temp_data_viewed_at, @temp_created_at, @temp_updated_at, @temp_deleted_at
              END
            CLOSE @DuplicateCursor
            DEALLOCATE @DuplicateCursor

            SELECT @NumberOfArchiveVLoansRowAfterDeletion = COUNT(loan_id)
            FROM archive_v_loans;

            IF @NumberOfArchiveVLoansRowAfterDeletion = @NumberOfArchiveVLoansRowBeforeDeletion - @NumberOfDuplicatedRowToDelete
              BEGIN
                COMMIT TRANSACTION
                SELECT * FROM @ArchiveVLoansDeletedRow
              END
            ELSE
              BEGIN
                ROLLBACK TRANSACTION
                SELECT * FROM @ArchiveVLoansDeletedRow
              END
          END
        ELSE
          BEGIN
            COMMIT TRANSACTION
            SELECT * FROM @ArchiveVLoansDeletedRow
          END
    )
  end

  def execute_statement(sql)
    ActiveRecord::Base.connection.exec_query(sql)
  end

  def duplicated_archive_v_loans_table_entry_sql
    # rubocop:disable Layout/LineLength
    %(
     SELECT count(id) AS count_id, id, loan_id ,version_number , status,version_status ,currency_id ,loan_type_id ,repayment_type_id ,creation_user_id ,assignment_date ,deadline_assignment_date ,ratification_date ,deadline_ratification_date ,approval_date ,deadline_approval_date, expected_disbursement_date ,specific_approval_condition ,probabilities ,disbursement_date ,in_waiting_list ,maturity_date, nav_usd ,net_position_value ,gross_position_value ,critical_cases ,provision_date ,provision_value ,vrr, vrr_maturity_date ,proposed_nominal_amount ,proposed_tenor ,proposed_spread ,proposed_upfront_fees ,proposed_fixed_rate ,ratified_nominal_amount ,ratified_tenor ,ratified_spread ,ratified_upfront_fees,ratified_fixed_rate ,approved_nominal_amount ,approved_tenor ,approved_spread ,approved_upfront_fees ,approved_fixed_rate ,executed_nominal_amount ,executed_tenor ,executed_spread ,executed_upfront_fees ,executed_fixed_rate ,pending_ratification_nominal_amount ,pending_ratification_tenor,pending_ratification_spread ,pending_ratification_upfront_fees ,pending_ratification_fixed_rate ,pending_ratification_date ,deadline_pending_ratification_date ,pending_approval_nominal_amount ,pending_approval_tenor,pending_approval_spread ,pending_approval_upfront_fees ,pending_approval_fixed_rate ,pending_approval_date,deadline_pending_approval_date ,approved_change_request_nominal_amount ,approved_change_request_tenor ,approved_change_request_spread ,approved_change_request_upfront_fees ,approved_change_request_fixed_rate ,approval_change_request_date,deadline_approval_change_request_date ,validation_user_id ,rejection_user_id ,created_at ,updated_at ,deleted_at ,bond_id ,pool_id ,interest_rate_type_id ,hedge_comment ,pending_ratification_comment,ratified_comment ,not_ratified_comment ,assignement_expired_comment ,released_before_approval_comment ,pending_approval_comment ,approved_comment ,not_approved_comment ,approval_expired_comment ,approved_change_request_comment ,invested_comment,released_after_approval_comment ,not_validated_comment ,nav_date ,innpact_loan_id ,institution_mode_at_creation,last_loan_version ,noval ,restructuring ,tranche_original_loan_id ,proposed_nominal_amount_USD ,ratified_nominal_amount_USD ,approved_nominal_amount_USD ,executed_nominal_amount_USD ,pending_ratification_nominal_amount_USD,pending_approval_nominal_amount_USD ,approved_change_request_nominal_amount_USD ,Institutions ,Institution_group ,in_watchlist ,institution_type ,fund_name ,fund_status ,loan_type_description,loan_type ,Country ,rating_MOODYS ,rating_MIMOSA ,Region ,Local_Currency ,Local_Currency_Rate ,repayment_type ,bond ,bond_description ,interest_rate_type ,interest_rate_type_description,pool ,IM_Group ,data_viewed_at ,SysStartTime ,SysEndTime ,executed_bond_id ,executed_interest_rate_type_id ,approved_bond_id ,approved_interest_rate_type_id ,number_of_disbursement_date_updates ,invested_hedge_fx_rate,loan_version_id ,hedge_spread ,hedge_interest_rate_type_id
     FROM archive_v_loans
     group by loan_id, id, version_number , status, version_status ,currency_id ,loan_type_id ,repayment_type_id ,creation_user_id ,assignment_date ,deadline_assignment_date ,ratification_date ,deadline_ratification_date ,approval_date ,deadline_approval_date, expected_disbursement_date ,specific_approval_condition ,probabilities ,disbursement_date ,in_waiting_list ,maturity_date, nav_usd ,net_position_value ,gross_position_value ,critical_cases ,provision_date ,provision_value ,vrr, vrr_maturity_date ,proposed_nominal_amount ,proposed_tenor ,proposed_spread ,proposed_upfront_fees ,proposed_fixed_rate ,ratified_nominal_amount ,ratified_tenor ,ratified_spread ,ratified_upfront_fees,ratified_fixed_rate ,approved_nominal_amount ,approved_tenor ,approved_spread ,approved_upfront_fees ,approved_fixed_rate ,executed_nominal_amount ,executed_tenor ,executed_spread ,executed_upfront_fees ,executed_fixed_rate ,pending_ratification_nominal_amount ,pending_ratification_tenor,pending_ratification_spread ,pending_ratification_upfront_fees ,pending_ratification_fixed_rate ,pending_ratification_date ,deadline_pending_ratification_date ,pending_approval_nominal_amount ,pending_approval_tenor,pending_approval_spread ,pending_approval_upfront_fees ,pending_approval_fixed_rate ,pending_approval_date,deadline_pending_approval_date ,approved_change_request_nominal_amount ,approved_change_request_tenor ,approved_change_request_spread ,approved_change_request_upfront_fees ,approved_change_request_fixed_rate ,approval_change_request_date,deadline_approval_change_request_date ,validation_user_id ,rejection_user_id ,created_at ,updated_at ,deleted_at ,bond_id ,pool_id ,interest_rate_type_id ,hedge_comment ,pending_ratification_comment,ratified_comment ,not_ratified_comment ,assignement_expired_comment ,released_before_approval_comment ,pending_approval_comment ,approved_comment ,not_approved_comment ,approval_expired_comment ,approved_change_request_comment ,invested_comment,released_after_approval_comment ,not_validated_comment ,nav_date ,innpact_loan_id ,institution_mode_at_creation,last_loan_version ,noval ,restructuring ,tranche_original_loan_id ,proposed_nominal_amount_USD ,ratified_nominal_amount_USD ,approved_nominal_amount_USD ,executed_nominal_amount_USD ,pending_ratification_nominal_amount_USD,pending_approval_nominal_amount_USD ,approved_change_request_nominal_amount_USD ,Institutions ,Institution_group ,in_watchlist ,institution_type ,fund_name ,fund_status ,loan_type_description,loan_type ,Country ,rating_MOODYS ,rating_MIMOSA ,Region ,Local_Currency ,Local_Currency_Rate ,repayment_type ,bond ,bond_description ,interest_rate_type ,interest_rate_type_description,pool ,IM_Group ,data_viewed_at ,SysStartTime ,SysEndTime ,executed_bond_id ,executed_interest_rate_type_id ,approved_bond_id ,approved_interest_rate_type_id ,number_of_disbursement_date_updates ,invested_hedge_fx_rate,loan_version_id ,hedge_spread ,hedge_interest_rate_type_id
     having count(id) > 1;
    )
    # rubocop:enable Layout/LineLength
  end
end
