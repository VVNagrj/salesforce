public with sharing class OpportunityDetailsController {

    public Opportunity opp { get; set; }
    public List<OpportunityLineItem> oppLineItems { get; set; }

    public OpportunityDetailsController() {

        // Get Opportunity Id from URL
        Id oppId = ApexPages.currentPage().getParameters().get('id');

        if (oppId != null) {

            // Fetch Opportunity
            opp = [
                SELECT Id, Name, StageName, Amount, CloseDate
                FROM Opportunity
                WHERE Id = :oppId
                LIMIT 1
            ];

            // Fetch Opportunity Line Items
            oppLineItems = [
                SELECT Id,
                       Quantity,
                       UnitPrice,
                       TotalPrice,
                       PricebookEntry.Product2.Name
                FROM OpportunityLineItem
                WHERE OpportunityId = :oppId
            ];
        }
    }
}