global class UpstoxInstrumentsScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new UpstoxInstrumentsService(), 1);
    }
}

/**String cronExp = '0 0 2 * * ?'; // Run every day at 2 AM
System.schedule('Daily Upstox Sync', cronExp, new UpstoxInstrumentsScheduler()); */