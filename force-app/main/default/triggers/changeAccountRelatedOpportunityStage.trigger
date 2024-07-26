trigger changeAccountRelatedOpportunityStage on Opportunity ( 
                                        
                                                                before update, 
                                                                after update,
                                                                before delete, 
                                                                after delete, 
                                                                after undelete
                                                                ) {

        TriggerDispatcher.run(new AccountRealtedOpportunityStageHandler(), 'changeAccountRelatedOpportunityStage');

}