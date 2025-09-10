global class UpstoxInstrumentsService implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts {

    global Integer totalInserted = 0;
    global Integer totalFailed   = 0;

    // Config
    global Integer pageSize = 1000; // request limit per page
    global Integer currentPage = 1;
    global Boolean moreData = true;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Dummy query - batch is controlled by execute()
        return Database.getQueryLocator('SELECT Id FROM Account LIMIT 1');
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        if (!moreData) {
            return;
        }

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://gzip-proxy.onrender.com/proxy?page=' + currentPage + '&limit=' + pageSize);
        req.setMethod('GET');
        req.setTimeout(60000);

        try {
            HttpResponse res = h.send(req);
            System.debug('HTTP Status: ' + res.getStatusCode());

            if (res.getStatusCode() == 200) {
                List<Object> instruments = (List<Object>) JSON.deserializeUntyped(res.getBody());
                System.debug('Fetched ' + instruments.size() + ' instruments for page ' + currentPage);

                if (instruments.isEmpty()) {
                    moreData = false;
                    return;
                }

                List<Market_Instrument__c> toInsert = new List<Market_Instrument__c>();

                for (Object o : instruments) {
                    Map<String, Object> row = (Map<String, Object>) o;

                    Market_Instrument__c inst = new Market_Instrument__c();
                    inst.Exchange__c       = (String) row.get('exchange');
                    inst.Symbol__c         = (String) row.get('trading_symbol');
                    inst.Name__c           = (String) row.get('name');
                    inst.Instrument_Key__c = (String) row.get('instrument_key');

                    if (row.containsKey('exchange_token') && row.get('exchange_token') != null)
                        inst.Token__c = Decimal.valueOf(row.get('exchange_token').toString());
                    if (row.containsKey('expiry') && row.get('expiry') != null) {
                        try {
                            // expiry sometimes comes as a long timestamp
                            Long expiryMillis = Long.valueOf(row.get('expiry').toString());
                            inst.Expiry__c = Date.newInstance(1970, 1, 1).addDays((Integer)(expiryMillis / (1000*60*60*24)));
                        } catch (Exception e) {
                            System.debug('Expiry parse failed: ' + e.getMessage());
                        }
                    }
                    if (row.containsKey('lot_size') && row.get('lot_size') != null)
                        inst.Lot_Size__c = Decimal.valueOf(row.get('lot_size').toString());
                    if (row.containsKey('tick_size') && row.get('tick_size') != null)
                        inst.Tick_Size__c = Decimal.valueOf(row.get('tick_size').toString());

                    toInsert.add(inst);
                }

                try {
                    insert toInsert;
                    totalInserted += toInsert.size();
                } catch (DmlException d) {
                    totalFailed += toInsert.size();
                    System.debug('Insert failed: ' + d.getMessage());
                }

                // Prepare for next page
                currentPage++;
                Database.executeBatch(this, 1); // enqueue next page execution
            } else {
                System.debug('Error: ' + res.getStatusCode() + ' ' + res.getBody());
                moreData = false;
            }
        } catch (Exception ex) {
            System.debug('Callout exception: ' + ex.getMessage());
            moreData = false;
        }
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Batch Completed. Total Inserted: ' + totalInserted + ', Total Failed: ' + totalFailed);
    }
}